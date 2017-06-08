//
//  ProductDetailsViewController.swift
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

private enum CellKind: Int {
    case header
    case details
}

class ProductDetailsViewController: ParallaxViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var product: ProductViewModel!
    
    private var imageViewController: ImageViewController!
    
    // ----------------------------------
    //  MARK: - Segue -
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier! {
        case "ImageViewController":
            self.imageViewController = segue.destination as! ImageViewController
        default:
            break
        }
    }
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerTableCells()
        
        self.configureHeader()
        self.configureImageController()
    }
    
    private func registerTableCells() {
        self.tableView.register(ProductHeaderCell.self)
        self.tableView.register(ProductDetailsCell.self)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
    }
    
    private func configureHeader() {
        self.headerHeight = self.view.bounds.width * 0.5625 // 16:9 ratio
    }
    
    private func configureImageController() {
        
        self.imageViewController.activePageIndicatorColor   = self.view.tintColor.withAlphaComponent(0.8)
        self.imageViewController.inactivePageIndicatorColor = self.view.tintColor.withAlphaComponent(0.3)
        
        self.imageViewController.imageItems = self.product.images.items.map {
            ImageItem.url($0.url, placeholder: nil)
        }
    }
}

// ----------------------------------
//  MARK: - Actions -
//
extension ProductDetailsViewController {
    
    @IBAction func cartAction(_ sender: Any) {
        let cartController: CartNavigationController = self.storyboard!.instantiateViewController()
        self.navigationController!.present(cartController, animated: true, completion: nil)
    }
}

// ----------------------------------
//  MARK: - ProductHeaderDelegate -
//
extension ProductDetailsViewController: ProductHeaderDelegate {
    
    func productHeader(_ cell: ProductHeaderCell, didAddToCart sender: Any) {
        let item = CartItem(product: self.product, variant: self.product.variants.items[0])
        CartController.shared.add(item)
    }
}

// ----------------------------------
//  MARK: - UITableViewDataSource -
//
extension ProductDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CellKind(rawValue: indexPath.row)! {
        case .header:
            let cell = tableView.deque(ProductHeaderCell.self, configureFrom: self.product, at: indexPath)
            cell.delegate = self
            return cell
            
        case .details:
            return tableView.deque(ProductDetailsCell.self, configureFrom: self.product, at: indexPath)
        }
    }
}

// ----------------------------------
//  MARK: - UITableViewDelegate -
//
extension ProductDetailsViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateParallax()
    }
}

// ----------------------------------
//  MARK: - Convenience -
//
private extension UITableView {
    
    func register<C>(_ cellType: C.Type) where C: UITableViewCell {
        let name = String(describing: cellType.self)
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
    func deque<M, C>(_ cellType: C.Type, configureFrom viewModel: M, at indexPath: IndexPath) -> C where M: ViewModel, C: UITableViewCell, C: ViewModelConfigurable, C.ViewModelType == M  {
        let name = String(describing: cellType.self)
        let cell = self.dequeueReusableCell(withIdentifier: name, for: indexPath) as! C
        cell.configureFrom(viewModel)
        return cell
    }
}
