//
//  StorefrontCollectionView.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import UIKit

class StorefrontCollectionView: UICollectionView {
    
    @IBInspectable private dynamic var cellNibName: String?
    
    // ----------------------------------
    //  MARK: - Awake -
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let className = self.value(forKey: "cellNibName") as? String {
            self.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
        }
    }
}
