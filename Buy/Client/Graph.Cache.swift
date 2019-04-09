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
    
    class Cache {
        
        let cacheDirectory: URL
        
        private static let fileManager = FileManager.default
        private static let cacheName   = "com.buy.graph.cache"
        
        private let memoryCache = NSCache<NSString, CacheItem>()
        
        // ----------------------------------
        //  MARK: - Init -
        //
        init(shopName: String) {
            self.cacheDirectory = Cache.cacheDirectory(for: shopName)
            self.createCacheDirectoryIfNeeded()
        }
        
        private func createCacheDirectoryIfNeeded() {
            let cacheDirectory = self.cacheDirectory
            if !Cache.fileManager.fileExists(atPath: cacheDirectory.path) {
                try! Cache.fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
            }
        }
        
        func purgeInMemory() {
            self.memoryCache.removeAllObjects()
        }
        
        func purge() {
            self.purgeInMemory()
            
            try? Cache.fileManager.removeItem(at: self.cacheDirectory)
            self.createCacheDirectoryIfNeeded()
        }
        
        // ----------------------------------
        //  MARK: - Item Management -
        //
        func item(for hash: Hash) -> CacheItem? {
            if let cacheItem = self.itemInMemory(for: hash) {
                return cacheItem
                
            } else {
                let location = Graph.CacheItem.Location(inParent: self.cacheDirectory, hash: hash)
                if let cacheItem = CacheItem(at: location) {
                    
                    self.setInMemory(cacheItem)
                    return cacheItem
                }
            }
            
            return nil
        }
        
        func set(_ cacheItem: CacheItem) {
            self.setInMemory(cacheItem)
            
            let location = Graph.CacheItem.Location(inParent: self.cacheDirectory, hash: cacheItem.hash)
            
            cacheItem.write(to: location)
        }
        
        func remove(for hash: Hash) {
            self.removeInMemory(for: hash)
            
            let location = Graph.CacheItem.Location(inParent: self.cacheDirectory, hash: hash)
            do {
                try Cache.fileManager.removeItem(at: location.dataURL)
                try Cache.fileManager.removeItem(at: location.metaURL)
            } catch {
                Log("Failed to delete cached item on disk: \(error)")
            }
        }
        
        // ----------------------------------
        //  MARK: - Memory Cache -
        //
        private func setInMemory(_ cacheItem: CacheItem) {
            self.memoryCache.setObject(cacheItem, forKey: cacheItem.hash as NSString)
        }
        
        private func itemInMemory(for hash: Hash) -> CacheItem? {
            return self.memoryCache.object(forKey: hash as NSString)
        }
        
        private func removeInMemory(for hash: Hash) {
            self.memoryCache.removeObject(forKey: hash as NSString)
        }
        
        // ----------------------------------
        //  MARK: - File System Cache -
        //
        private static func cacheDirectory(for shopName: String) -> URL {
            let tmp = URL(fileURLWithPath: NSTemporaryDirectory())
            var url = tmp
            
            url = url.appendingPathComponent(Cache.cacheName)
            url = url.appendingPathComponent(Global.frameworkVersion)
            url = url.appendingPathComponent(MD5.hash(shopName))
            
            return url
        }
    }
}


