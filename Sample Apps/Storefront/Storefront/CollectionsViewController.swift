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

    @IBOutlet weak var collectionView: StorefrontCollectionView!
    
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
                self.collectionView.reloadData()
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
extension CollectionsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell       = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.className, for: indexPath) as! CollectionCell
        let collection = self.collections[indexPath.row]
        
        cell.configureFrom(collection)
        
        return cell
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDelegate -
//
extension CollectionsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// -----------------------------------------------
//  MARK: - UICollectionViewDelegateFlowLayout -
//
extension CollectionsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(
            width:  collectionView.bounds.width,
            height: collectionView.bounds.width / 1.25
        )
    }
}
