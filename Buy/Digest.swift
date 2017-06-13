//
//  Digest.swift
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

struct Digest {
    
    private init() {}
    
    static func md5(_ data: Data) -> [UInt8] {
        let context = UnsafeMutablePointer<MD5_CTX>.allocate(capacity: 1)
        MD5_Init(context)
        
        data.forEach { byte in
            MD5_Update(context, [byte], 1)
        }
        
        let hash = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        MD5_Final(hash, context)
        
        let array = [UInt8](UnsafeBufferPointer(start: hash, count: 16))
        
        hash.deallocate(capacity: 16)
        context.deallocate(capacity: 1)
        
        return array
    }
}

extension String {
    
    var md5: String {
        return self.data(using: .utf8)!.md5
    }
}

extension Data {
    
    var md5: String {
        return Digest.md5(self).hex
    }
}

extension Array where Element == UInt8 {
    
    var hex: String {
        return self.map { String(format: "%02x", $0) }.joined()
    }
}
