//
//  Graph.Cache.swift
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
    
    typealias Hash = String
    
    internal class Cache {
        
        static let cacheName = "com.buy.graph.cache"
        
        private static let fileManager = FileManager.default
        
        private let memoryCache = NSCache<NSString, NSData>()
        
        // ----------------------------------
        //  MARK: - Init -
        //
        init() {
            self.createCacheDirectoryIfNeeded()
        }
        
        private func createCacheDirectoryIfNeeded() {
            let cacheDirectory = Cache.cacheDirectory()
            if !Cache.fileManager.fileExists(atPath: cacheDirectory.path) {
                try! Cache.fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
            }
        }
        
        func purge() {
            self.memoryCache.removeAllObjects()
            
            try? Cache.fileManager.removeItem(at: Cache.cacheDirectory())
            self.createCacheDirectoryIfNeeded()
        }
        
        // ----------------------------------
        //  MARK: - Accessors -
        //
        func data(for hash: Hash) -> Data? {
            if let data = self.dataInMemory(for: hash) {
                return data
                
            } else {
                let location = Graph.CacheItem.Location(inParent: Cache.cacheDirectory(), hash: hash)
                if let item = CacheItem(at: location) {
                    
                    self.setInMemory(item.data, for: hash)
                    return item.data
                }
                
                return nil
            }
        }
        
        func set(_ data: Data, for hash: Hash) {
            self.setInMemory(data, for: hash)
            
            let location  = Graph.CacheItem.Location(inParent: Cache.cacheDirectory(), hash: hash)
            let cacheItem = CacheItem(hash: hash, data: data)
                
            cacheItem.write(to: location)
        }
        
        // ----------------------------------
        //  MARK: - Memory Cache -
        //
        private func setInMemory(_ data: Data, for hash: Hash) {
            self.memoryCache.setObject(data as NSData, forKey: hash as NSString)
        }
        
        private func dataInMemory(for hash: Hash) -> Data? {
            return self.memoryCache.object(forKey: hash as NSString) as Data?
        }
        
        // ----------------------------------
        //  MARK: - File System Cache -
        //
        static func cacheDirectory() -> URL {
            let tmp = URL(fileURLWithPath: NSTemporaryDirectory())
            let url = tmp.appendingPathComponent(Cache.cacheName)
            
            return url
        }
    }
}


