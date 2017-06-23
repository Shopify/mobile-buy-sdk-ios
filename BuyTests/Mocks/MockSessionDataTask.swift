//
//  MockSessionDataTask.swift
//  BuyTests
//
//  Created by Shopify.
//  Copyright (c) 2017 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

final class MockDataTask: URLSessionDataTask {
    
    typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
    
    var responseJson: [String: Any]? {
        set {
            if let json = newValue {
                self.responseData = try? JSONSerialization.data(withJSONObject: json, options: [])
            } else {
                self.responseData = nil
            }
        }
        get {
            if let data = self.responseData {
                return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String : Any]
            } else {
                return nil
            }
        }
    }
    
    var responseData:   Data?
    var isHTTPResponse: Bool = true
    var responseCode:   Int  = 0
    var headerFields:   [String: String]?
    var responseError:  (domain: String, code: Int)?
    
    private(set) var isResumed  = false
    private(set) var isCanceled = false
    private(set) var isComplete = false
    
    private(set) var request:    URLRequest?
    private(set) var completion: DataTaskCompletion?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(request: URLRequest? = nil, completion: DataTaskCompletion? = nil) {
        self.request    = request
        self.completion = completion
    }
    
    // ----------------------------------
    //  MARK: - State -
    //
    override var state: URLSessionTask.State {
        if self.isComplete {
            return .completed
        } else if self.isCanceled {
            return .canceling
        } else if self.isResumed {
            return .running
        } else {
            return .suspended
        }
    }
    
    override func resume() {
        self.isResumed = true
        self.executeCompletion()
    }
    
    override func cancel() {
        self.isCanceled = true
    }
    
    // ----------------------------------
    //  MARK: - Completion -
    //
    private func executeCompletion() {
        self.completion?(
            self.data(),
            self.response(),
            self.error()
        )
    }
    
    private func data() -> Data? {
        return self.responseData
    }
    
    private func response() -> URLResponse? {
        let url = self.request?.url ?? URL(string: "http://")!
        
        if self.isHTTPResponse {
            return HTTPURLResponse(
                url:          url,
                statusCode:   self.responseCode,
                httpVersion:  "HTTP/1.1",
                headerFields: self.headerFields
            )
            
        } else {
            return URLResponse(
                url:                   url,
                mimeType:              "application/json",
                expectedContentLength: self.data()?.count ?? 0,
                textEncodingName:      "utf8"
            )
        }
    }
    
    private func error() -> Error? {
        if let error = self.responseError {
            return NSError(domain: error.domain, code: error.code, userInfo: nil)
        }
        return nil
    }
}
