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
import Crypto

struct Digest {
    
    private init() {}
    
    static func md5(_ data: Data) -> [UInt8] {
        
        var context = CC_MD5_CTX()
        var digest  = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        CC_MD5_Init(&context)
        data.forEach { byte in
            CC_MD5_Update(&context, [byte], 1)
        }
        CC_MD5_Final(&digest, &context)
        
        return digest
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
