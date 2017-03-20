//
//  DepressibleCell.swift
//  Storefront
//
//  Created by Dima Bart on 2017-03-06.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import UIKit

class DepressibleCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        willSet(highlighted) {
            
            let scale: CGFloat
            if highlighted {
                scale = 0.9
            } else {
                scale = 1.0
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.layer.transform = CATransform3DMakeScale(scale, scale, scale)
            }, completion: nil)
        }
    }
}
