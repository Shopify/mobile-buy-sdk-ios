//
//  Global.swift
//  Buy
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation

class Global {
    
    // ----------------------------------
    //  MARK: - User Agent -
    //
    static var userAgent: String {
        return "Mobile Buy SDK iOS/\(self.frameworkVersion)/\(self.applicationIdentifier)"
    }

    // ----------------------------------
    //  MARK: - Versions -
    //
    static var frameworkVersion: String {
        return self.frameworkBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? "x.x"
    }
    
    static var applicationIdentifier: String {
        return self.applicationBundle.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as? String ?? "com.unknown.bundle"
    }
    
    // ----------------------------------
    //  MARK: - Bundles -
    //
    private static var frameworkBundle: Bundle {
        return Bundle(for: self)
    }
    
    private static var applicationBundle: Bundle {
        return Bundle.main
    }
}
