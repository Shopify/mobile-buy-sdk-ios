//
//  Graph.CacheItemTests.swift
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

import XCTest
@testable import Buy

class Graph_CacheItemTests: XCTestCase {

    let fileManager   = FileManager.default
    let testDirectory = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("com.cache.test")
    
    // ----------------------------------
    //  MARK: - Setup -
    //
    override func setUp() {
        super.setUp()
        
        try! self.fileManager.createDirectory(at: self.testDirectory, withIntermediateDirectories: true, attributes: nil)
    }
    
    override func tearDown() {
        super.tearDown()
        
        try! self.fileManager.removeItem(at: self.testDirectory)
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let data  = "abc".data(using: .utf8)!
        let hash  = "123"
        let stamp = Date().timeIntervalSince1970
        let item  = Graph.CacheItem(hash: hash, data: data, timestamp: stamp)
        
        XCTAssertEqual(item.hash, hash)
        XCTAssertEqual(item.data, data)
        XCTAssertEqual(item.timestamp, stamp)
    }
    
    func testInitFromHashEmpty() {
        let location      = Graph.CacheItem.Location(inParent: self.testDirectory, hash: "abcdefg")
        let retrievedItem = Graph.CacheItem(at: location)
        
        XCTAssertNil(retrievedItem)
    }
    
    func testInitFromHash() {
        let item     = self.defaultCacheItem()
        let location = Graph.CacheItem.Location(inParent: self.testDirectory, hash: item.hash)
        
        item.write(to: location)
        
        let retrievedItem = Graph.CacheItem(at: location)
        
        XCTAssertNotNil(retrievedItem)
        XCTAssertEqual(item.data, retrievedItem!.data)
        XCTAssertEqual(item.hash, retrievedItem!.hash)
        XCTAssertEqual(Int(item.timestamp * 100.0), Int(retrievedItem!.timestamp * 100.0))
    }
    
    // ----------------------------------
    //  MARK: - Write -
    //
    func testWrite() {
        let item     = self.defaultCacheItem()
        let location = Graph.CacheItem.Location(inParent: self.testDirectory, hash: "test-item")
        
        XCTAssertFalse(self.fileManager.fileExists(atPath: location.dataURL.path))
        XCTAssertFalse(self.fileManager.fileExists(atPath: location.metaURL.path))
        
        let success = item.write(to: location)
        
        XCTAssertTrue(success)
        XCTAssertTrue(self.fileManager.fileExists(atPath: location.dataURL.path))
        XCTAssertTrue(self.fileManager.fileExists(atPath: location.metaURL.path))
    }
    
    func testWriteRestricted() {
        let item     = self.defaultCacheItem()
        let root     = URL(fileURLWithPath: "/") // Shouldn't be able to write to root -> "/"
        let location = Graph.CacheItem.Location(inParent: root, hash: "test-item-2")
        
        let success = item.write(to: location)
        
        XCTAssertFalse(success)
    }
    
    // ----------------------------------
    //  MARK: - Location -
    //
    func testLocationInitInParent() {
        let parentURL = URL(fileURLWithPath: "/root")
        let location  = Graph.CacheItem.Location(inParent: parentURL, hash: "123")
        
        XCTAssertEqual(location.dataURL.absoluteString, "file:///root/123")
        XCTAssertEqual(location.metaURL.absoluteString, "file:///root/123.meta")
    }
    
    func testLocationInit() {
        let url1      = URL(fileURLWithPath: "/root")
        let url2      = URL(fileURLWithPath: "/var")
        let location  = Graph.CacheItem.Location(dataURL: url1, metaURL: url2)
        
        XCTAssertEqual(location.dataURL.absoluteString, url1.absoluteString)
        XCTAssertEqual(location.metaURL.absoluteString, url2.absoluteString)
    }
    
    // ----------------------------------
    //  MARK: - Private -
    //
    private func defaultCacheItem() -> Graph.CacheItem {
        let data  = "abc".data(using: .utf8)!
        let hash  = "123"
        let stamp = Date().timeIntervalSince1970
        
        return Graph.CacheItem(hash: hash, data: data, timestamp: stamp)
    }
}
