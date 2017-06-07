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
    
    fileprivate var collections: PageableArray<CollectionViewModel>!
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        
        Client.shared.fetchCollections { collections in
            if let collections = collections {
                self.collections = collections
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureTableView() {
        self.tableView.paginationDelegate = self
        
        if self.traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: self.tableView)
        }
    }
    
    // ----------------------------------
    //  MARK: - Fetching -
    //
    fileprivate func fetchCollections(after cursor: String? = nil) {
        Client.shared.fetchCollections(after: cursor) { collections in
            if let collections = collections {
                self.collections = collections
                self.tableView.reloadData()
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - View Controllers -
    //
    func productsViewControllerWith(_ collection: CollectionViewModel) -> ProductsViewController {
        let controller: ProductsViewController = self.storyboard!.instantiateViewController()
        controller.collection = collection
        return controller
    }
    
    func productDetailsViewControllerWith(_ product: ProductViewModel) -> ProductDetailsViewController {
        let controller: ProductDetailsViewController = self.storyboard!.instantiateViewController()
        controller.product = product
        return controller
    }
}

// ----------------------------------
//  MARK: - Actions -
//
extension CollectionsViewController {
    
    @IBAction func cartAction(_ sender: Any) {
        let cartController: CartNavigationController = self.storyboard!.instantiateViewController()
        self.navigationController!.present(cartController, animated: true, completion: nil)
    }
}

// ----------------------------------
//  MARK: - UIViewControllerPreviewingDelegate -
//
extension CollectionsViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let tableView = previewingContext.sourceView as! UITableView
        if let indexPath = tableView.indexPathForRow(at: location) {
            
            let cell  = tableView.cellForRow(at: indexPath) as! CollectionCell
            let touch = cell.convert(location, from: tableView)
            
            if let productResult = cell.productFor(touch) {
                previewingContext.sourceRect = tableView.convert(productResult.sourceRect, from: cell)
                return self.productDetailsViewControllerWith(productResult.model)
                
            } else if let collectionResult = cell.collectionFor(touch) {
                previewingContext.sourceRect = tableView.convert(collectionResult.sourceRect, from: cell)
                return self.productsViewControllerWith(collectionResult.model)
            }
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController!.show(viewControllerToCommit, sender: self)
    }
}

// ----------------------------------
//  MARK: - StorefrontTableViewDelegate -
//
extension CollectionsViewController: StorefrontTableViewDelegate {
    
    func tableViewShouldBeginPaging(_ table: StorefrontTableView) -> Bool {
        return self.collections?.hasNextPage ?? false
    }
    
    func tableViewWillBeginPaging(_ table: StorefrontTableView) {
        if let collections = self.collections,
            let lastCollection = collections.items.last {
            
            Client.shared.fetchCollections(after: lastCollection.cursor) { collections in
                if let collections = collections {
                    
                    self.collections.appendPage(from: collections)
                    
                    self.tableView.reloadData()
                    self.tableView.completePaging()
                }
            }
        }
    }
    
    func tableViewDidCompletePaging(_ table: StorefrontTableView) {
        
    }
}

// ----------------------------------
//  MARK: - CollectionCellDelegate -
//
extension CollectionsViewController: CollectionCellDelegate {
    
    func cell(_ collectionCell: CollectionCell, didRequestProductsIn collection: CollectionViewModel, after product: ProductViewModel) {
        
        Client.shared.fetchProducts(in: collection, limit: 20, after: product.cursor) { products in
            if let products = products, collectionCell.viewModel === collection {
                collectionCell.appendProductsPage(from: products)
            }
        }
    }
    
    func cell(_ collectionCell: CollectionCell, didSelectProduct product: ProductViewModel) {
        let detailsController: ProductDetailsViewController = self.storyboard!.instantiateViewController()
        detailsController.product = product
        self.navigationController!.show(detailsController, sender: self)
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
        return self.collections?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell       = tableView.dequeueReusableCell(withIdentifier: CollectionCell.className, for: indexPath) as! CollectionCell
        let collection = self.collections.items[indexPath.section]
        
        cell.delegate = self
        cell.configureFrom(collection)
        
        return cell
    }
    
    // ----------------------------------
    //  MARK: - Titles -
    //
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.collections.items[section].title
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.collections.items[section].description
    }
    
    // ----------------------------------
    //  MARK: - Height -
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let width  = tableView.bounds.width
        let height = width * 0.75 // 3:4 ratio
        
        return height + 150.0 // 150 is the height of the product collection
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDelegate -
//
extension CollectionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collection         = self.collections.items[indexPath.section]
        let productsController = self.productsViewControllerWith(collection)
        self.navigationController!.show(productsController, sender: self)
    }
}
