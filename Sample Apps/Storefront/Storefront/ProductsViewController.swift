//
//  ProductsViewController.swift
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

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: StorefrontCollectionView!
    
    var graph:      Graph!
    var collection: CollectionViewModel!
    
    fileprivate let columns:  Int = 2
    fileprivate var products: PageableArray<ProductViewModel>!
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureCollectionView()
        
        Client.shared.fetchProducts(in: self.collection) { products in
            if let products = products {
                self.products = products
                self.collectionView.reloadData()
            }
        }
    }
    
    private func configureCollectionView() {
        self.collectionView.paginationDelegate = self
        
        if self.traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: self.collectionView)
        }
    }
    
    // ----------------------------------
    //  MARK: - View Controllers -
    //
    func productDetailsViewControllerWith(_ product: ProductViewModel) -> ProductDetailsViewController {
        let controller: ProductDetailsViewController = self.storyboard!.instantiateViewController()
        controller.product = product
        return controller
    }
}

// ----------------------------------
//  MARK: - Actions -
//
extension ProductsViewController {
    
    @IBAction func cartAction(_ sender: Any) {
        let cartController: CartNavigationController = self.storyboard!.instantiateViewController()
        self.navigationController!.present(cartController, animated: true, completion: nil)
    }
}

// ----------------------------------
//  MARK: - UIViewControllerPreviewingDelegate -
//
extension ProductsViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let collectionView = previewingContext.sourceView as! UICollectionView
        if let indexPath = collectionView.indexPathForItem(at: location),
            let frame = collectionView.rectForItem(at: indexPath) {
            
            previewingContext.sourceRect = frame
            
            let cell = collectionView.cellForItem(at: indexPath) as! ProductCell
            return self.productDetailsViewControllerWith(cell.viewModel!)
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController!.show(viewControllerToCommit, sender: self)
    }
}

// ----------------------------------
//  MARK: - PaginationDelegate -
//
extension ProductsViewController: StorefrontCollectionViewDelegate {
    
    func collectionViewShouldBeginPaging(_ collectionView: StorefrontCollectionView) -> Bool {
        return self.products?.hasNextPage ?? false
    }
    
    func collectionViewWillBeginPaging(_ collectionView: StorefrontCollectionView) {
        if let products = self.products,
            let lastProduct = products.items.last {
            
            Client.shared.fetchProducts(in: self.collection, after: lastProduct.cursor) { products in
                if let products = products {
                    self.products.appendPage(from: products)
                    
                    self.collectionView.reloadData()
                    self.collectionView.completePaging()
                }
            }
        }
    }
    
    func collectionViewDidCompletePaging(_ collectionView: StorefrontCollectionView) {
        
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDataSource -
//
extension ProductsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.className, for: indexPath) as! ProductCell
        let product = self.products.items[indexPath.item]
        
        cell.configureFrom(product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.layer.cornerRadius  = 4.0
        cell.layer.masksToBounds = true
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout         = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing    = layout.minimumInteritemSpacing * CGFloat(self.columns - 1)
        let sectionSpacing = layout.sectionInset.left + layout.sectionInset.right
        let length         = (collectionView.bounds.width - itemSpacing - sectionSpacing) / CGFloat(self.columns)
        
        return CGSize(
            width:  length,
            height: length + 80.0
        )
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDelegate -
//
extension ProductsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product    = self.products.items[indexPath.item]
        let controller = self.productDetailsViewControllerWith(product)
        self.navigationController!.show(controller, sender: self)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
