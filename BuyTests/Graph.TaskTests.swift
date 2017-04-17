//
//  Graph.TaskTests.swift
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

class Graph_TaskTests: XCTestCase {
    
    let url: URL = URL(string: "https://www.google.com")!
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let dataTask = MockDataTask()
        let task     = Graph.Task(representing: dataTask)
        
        XCTAssertNotNil(task.task)
        XCTAssertTrue(task.task === dataTask)
    }
    
    // ----------------------------------
    //  MARK: - Tasks -
    //
    func testSetTask() {
        let firstTask  = MockDataTask()
        let task       = Graph.Task(representing: firstTask)
        
        let secondTask = MockDataTask()
        task.setTask(secondTask)
        
        XCTAssertNotNil(task.task)
        XCTAssertTrue(task.task === secondTask)
    }
    
    func testResumeTask() {
        let dataTask = MockDataTask()
        let task     = Graph.Task(representing: dataTask)
        
        XCTAssertFalse(dataTask.isResumed)
        task.resume()
        XCTAssertTrue(dataTask.isResumed)
    }
    
    func testCancelTask() {
        let dataTask = MockDataTask()
        let task     = Graph.Task(representing: dataTask)
        
        XCTAssertFalse(dataTask.isCanceled)
        task.cancel()
        XCTAssertTrue(dataTask.isCanceled)
    }
}
