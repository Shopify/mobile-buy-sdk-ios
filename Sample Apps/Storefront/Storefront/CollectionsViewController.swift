//
//  CollectionsViewController.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-16.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import UIKit
import Buy

class CollectionsViewController: UIViewController {

    @IBOutlet weak var tableView: StorefrontTableView!
    
    var collections: [CollectionViewModel] = []
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = ApiSchema.buildQuery { $0
            .shop { $0
                .collections(first: 25) { $0
                    .edges { $0
                        .node { $0
                            .fragmentForStandardImage()
                            .products(first: 25) { $0
                                .fragmentForStandardProduct()
                            }
                        }
                    }
                }
            }
        }

        let client = GraphClient(shopDomain: "your-shop.myshopify.com", apiKey: "your-api-key")
        let task   = client.queryGraphWith(query) { (query, error) in
            
            if let query = query {
                self.collections = query.shop.collections().viewModels
                self.tableView.reloadData()
            } else {
                print("Failed to load collections: \(error)")
            }
        }
        
        task?.resume()
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDataSource -
//
extension CollectionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.collections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell       = tableView.dequeueReusableCell(withIdentifier: CollectionCell.className, for: indexPath) as! CollectionCell
        let collection = self.collections[indexPath.row]
        
        cell.configureFrom(collection)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ratio  = CGFloat(16.0 / 9.0)
        let width  = tableView.bounds.width
        let height = width / ratio // height for header
        
        return height + 150.0 // 150 is the height of the product collection
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDelegate -
//
extension CollectionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
