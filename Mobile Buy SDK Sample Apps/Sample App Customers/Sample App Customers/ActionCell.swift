//
//  ActionCell.swift
//  Sample App Customers
//
//  Created by Dima Bart on 2016-05-04.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {
    
    @IBOutlet private weak var actionLabel: UILabel!
    @IBOutlet private weak var loader:      UIActivityIndicatorView!

    var loading: Bool {
        get {
            return self.actionLabel.hidden
        }
        set {
            self.actionLabel.hidden = newValue
            self.loader.hidden      = !newValue
        }
    }

}
