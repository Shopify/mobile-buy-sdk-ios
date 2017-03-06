//
//  GraphClient.swift
//  Buy
//
//  Created by Dima Bart on 2017-02-23.
//  Copyright © 2017 Shopify. All rights reserved.
//

import Foundation

internal typealias JSON = [String : Any]

private struct Header {
    static var userAgent     = "User-Agent"
    static var authorization = "Authorization"
    static var accept        = "Accept"
    static var contentType   = "Content-Type"
}

public class GraphClient {
    
    public let session:  URLSession?
    
    private let apiURL:  URL
    private let headers: [String : String]
	
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(shopDomain: String, apiKey: String, session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        
        let shopURL  = GraphClient.urlFor(shopDomain)
        self.apiURL  = GraphClient.urlFor(shopDomain, path: "/api/graphql")
        self.session = session
        self.headers = [
            Header.userAgent     : Global.userAgent,
            Header.authorization : "Basic \(GraphClient.tokenFor(apiKey))"
        ]
        
        precondition(!apiKey.isEmpty, "API Key is required to the Buy SDK. You can obtain one by adding a Mobile App channel here: \(shopURL.appendingPathComponent("admin"))")
    }
    
    static func tokenFor(_ apiKey: String) -> String {
        return apiKey.data(using: .utf8)!.base64EncodedString()
    }
    
    static func urlFor(_ shopDomain: String, path: String = "") -> URL {
        var components    = URLComponents()
        components.scheme = "https"
        components.host   = shopDomain
        components.path   = path
        
        return components.url!
    }

    // ----------------------------------
    //  MARK: - Queries -
    //
	public func queryGraphWith(_ query: ApiSchema.QueryRootQuery, completionHandler: @escaping (ApiSchema.QueryRoot?, GraphError?) -> Void) -> URLSessionTask? {
		return graphRequestTask(query: query, completionHandler: completionHandler)
	}
	
    // ----------------------------------
    //  MARK: - Mutations -
    //
	public func mutateGraphWith(_ mutation: ApiSchema.MutationQuery, completionHandler: @escaping (ApiSchema.Mutation?, GraphError?) -> Void) -> URLSessionTask? {
		return graphRequestTask(query: mutation, completionHandler: completionHandler)
	}
	
    // ----------------------------------
    //  MARK: - Request Management -
    //
	private func graphRequestTask<Q: GraphQL.AbstractQuery, R: GraphQL.AbstractResponse>(query: Q, completionHandler: @escaping (R?, GraphError?) -> Void) -> URLSessionTask? {
        
		func processGraphResponse(data: Data?, response: URLResponse?, error: Error?) -> (json: JSON?, error: GraphError?) {
            
			guard let response = response as? HTTPURLResponse, error == nil else {
				return (json: nil, error: .request(error: error))
			}
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
				return (json: nil, error: .http(statusCode: response.statusCode))
			}
            
            guard let data = data else {
                return (json: nil, error: .noData)
            }
            
			guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
				return (json: nil, error: .jsonDeserializationFailed(data: data))
			}
			
			let graphResponse = json as? JSON
			let graphErrors   = graphResponse?["errors"] as? [JSON]
			let graphData     = graphResponse?["data"]   as? JSON
            
            /* ----------------------------------
             ** This should never happen. A valid
             ** GraphQL response will have either
             ** data or errors.
             */
            guard graphData != nil || graphErrors != nil else {
				return (json: nil, error: .invalidJson(json: json))
			}
            
            /* ---------------------------------
             ** Extract any GraphQL errors found
             ** during execution of the query.
             */
            var queryError: GraphError?
			if let graphErrors = graphErrors {
                queryError = .queryError(reasons: graphErrors.map {
                    GraphError.Reason(json: $0)
                })
			}
            
            return (json: graphData, error: queryError)
		}
		
		return session?.dataTask(with: graphRequest(query: query)) { (data, response, error) in
			let (json, error) = processGraphResponse(data: data, response: response, error: error)
			DispatchQueue.main.async {
				if let json = json {
					do {
						completionHandler(try R(fields: json), error)
					} catch {
						let violation = error as? SchemaViolationError ?? SchemaViolationError(type: R.self, field: "data", value: json)
						completionHandler(nil, GraphError.schemaViolationError(violation: violation))
					}
				} else {
					completionHandler(nil, error)
				}
			}
		}
	}
	
	private func graphRequest(query: GraphQL.AbstractQuery) -> URLRequest {
		var request = URLRequest(url: self.apiURL)
		
		request.httpMethod = "POST"
		request.httpBody = String(describing: query).data(using: .utf8)
		request.httpShouldHandleCookies = false
		request.setValue("application/json", forHTTPHeaderField: Header.accept)
		request.setValue("application/graphql", forHTTPHeaderField: Header.contentType)
		
        for (name, value) in self.headers {
            request.setValue(value, forHTTPHeaderField: name)
        }
		
		return request
	}
}
