//
//  CollectionsViewController.swift
//  Storefront
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

import UIKit
import Buy

class CollectionsViewController: UIViewController {

    @IBOutlet weak var tableView: StorefrontTableView!
    
    fileprivate var collections: [CollectionViewModel] = []
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = Storefront.buildQuery { $0
            .shop { $0
                .collections(first: 25) { $0
                    .edges { $0
                        .node { $0
                            .id()
                            .title()
                            .descriptionPlainSummary()
                            .fragmentForStandardImage()
                            .products(first: 25) { $0
                                .fragmentForStandardProduct()
                            }
                        }
                    }
                }
            }
        }
        
        let task = GraphClient.shared.queryGraphWith(query) { (query, error) in
            
            if let query = query {
                self.collections = query.shop.collectionsArray().viewModels
                self.tableView.reloadData()
            } else {
                print("Failed to load collections: \(error)")
            }
        }
        
        task.resume()
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDataSource -
//
extension CollectionsViewController: UITableViewDataSource {
    
    // ----------------------------------
    //  MARK: - Data -
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.collections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell       = tableView.dequeueReusableCell(withIdentifier: CollectionCell.className, for: indexPath) as! CollectionCell
        let collection = self.collections[indexPath.section]
        
        cell.configureFrom(collection)
        
        return cell
    }
    
    // ----------------------------------
    //  MARK: - Titles -
    //
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.collections[section].title
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.collections[section].description
    }
    
    // ----------------------------------
    //  MARK: - Height -
    //
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
        let collection = self.collections[indexPath.section]
        
        let productsController: ProductsViewController = self.storyboard!.instantiateViewController()
        productsController.collection = collection
        self.navigationController!.pushViewController(productsController, animated: true)
    }
}
