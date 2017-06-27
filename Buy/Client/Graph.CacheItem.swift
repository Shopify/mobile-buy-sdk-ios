//
//  Graph.CacheItem.swift
//  Buy
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

internal extension Graph {
    
    internal class CacheItem {
        
        let hash:      Hash
        let data:      Data
        let timestamp: Double
        
        // ----------------------------------
        //  MARK: - Init -
        //
        init(hash: Hash, data: Data, timestamp: Double = Date().timeIntervalSince1970) {
            self.hash      = hash
            self.data      = data
            self.timestamp = timestamp
        }
        
        init?(at location: Location) {
            guard let result = CacheItem.read(from: location) else {
                return nil
            }
            
            self.data      = result.data
            self.hash      = result.meta["hash"]      as! String
            self.timestamp = result.meta["timestamp"] as! Double
        }
        
        // ----------------------------------
        //  MARK: - IO -
        //
        private static func read(from location: Location) -> (data: Data, meta: [String : Any])? {
            guard let data = try? Data(contentsOf: location.dataURL),
                let meta = try? Data(contentsOf: location.metaURL),
                let json = (try? JSONSerialization.jsonObject(with: meta, options: [])) as? [String : Any] else {
                    
                    return nil
            }
            
            return (data, json)
        }
        
        @discardableResult
        func write(to location: Location) -> Bool {
            let metaJson: [String : Any] = [
                "hash"      : self.hash,
                "timestamp" : self.timestamp
            ]
            
            do {
                let metaData = try JSONSerialization.data(withJSONObject: metaJson, options: [])
                
                try metaData.write(to: location.metaURL, options: .atomic)
                try self.data.write(to: location.dataURL, options: .atomic)
                
            } catch {
                Log("Failed to flush CacheItem: \(error)")
                return false
            }
            
            return true
        }
    }
}

// ----------------------------------
//  MARK: - Location -
//
extension Graph.CacheItem {
    internal struct Location {
        
        let dataURL: URL
        let metaURL: URL
        
        // ----------------------------------
        //  MARK: - Init -
        //
        init(inParent url: URL, hash: Graph.Hash) {
            let dataURL = url.appendingPathComponent(hash)
            self.init(
                dataURL: dataURL,
                metaURL: dataURL.appendingPathExtension("meta")
            )
        }
        
        internal init(dataURL: URL, metaURL: URL) {
            self.dataURL = dataURL
            self.metaURL = metaURL
        }
    }
}

// ----------------------------------
//  MARK: - URLRequest Hash -
//
extension URLRequest {
    
    var cacheItem: Graph.CacheItem {
        return Graph.CacheItem(hash: self.hash, data: self.httpBody ?? Data())
    }
    
    var hash: Graph.Hash {
        let hash        = self.value(forHTTPHeaderField: Header.queryTag) ?? ""
        let accessToken = self.value(forHTTPHeaderField: Header.authorization) ?? ""
        
        return MD5.hash("\(hash)\(accessToken)")
    }
}
