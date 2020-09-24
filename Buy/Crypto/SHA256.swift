//
//  SHA256.swift
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
import CommonCrypto

enum SHA256 {
    static func hash(_ string: String) -> String {
        var container = Container32.initialize()
        var context = CC_SHA256_CTX()
        
        CC_SHA256_Init(&context)
        CC_SHA256_Update(&context, string, CC_LONG(string.lengthOfBytes(using: .utf8)))
        
        Container32.withBaseAddress(&container) { pointer in
            CC_SHA256_Final(pointer, &context)
        }

        return Container32.string(container);
    }
    
    static func hash(_ data: Data) -> String {
        var container = Container32.initialize()
        var context = CC_SHA256_CTX()
        
        CC_SHA256_Init(&context)
        _ = data.withUnsafeBytes { buffer in
            CC_SHA256_Update(&context, buffer.baseAddress, CC_LONG(buffer.count))
        }
        
        Container32.withBaseAddress(&container) { pointer in
            CC_SHA256_Final(pointer, &context)
        }

        return Container32.string(container);
    }
}

// MARK: - Container32 -

private enum Container32 {

    static func initialize() -> Allocation {
        return (
            0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0
        )
    }
    
    static func withBaseAddress(_ allocation: inout Allocation, body: (UnsafeMutablePointer<UInt8>) -> Void) {
        withUnsafeMutableBytes(of: &allocation) { buffer in
            let baseAddress = buffer.baseAddress!.bindMemory(to: UInt8.self, capacity: 32)
            body(baseAddress)
        }
    }

    static func string(_ allocation: Allocation) -> String {
        String(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
               allocation.0,  allocation.1,  allocation.2,  allocation.3,
               allocation.4,  allocation.5,  allocation.6,  allocation.7,
               allocation.8,  allocation.9,  allocation.10, allocation.11,
               allocation.12, allocation.13, allocation.14, allocation.15,
               
               allocation.16, allocation.17, allocation.18, allocation.19,
               allocation.20, allocation.21, allocation.22, allocation.23,
               allocation.24, allocation.25, allocation.26, allocation.27,
               allocation.28, allocation.29, allocation.30, allocation.31
        )
    }
}

// MARK: - Allocation -

extension Container32 {
    typealias Allocation = (
        UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8,
        
        UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8,
        UInt8, UInt8, UInt8, UInt8
    )
}
