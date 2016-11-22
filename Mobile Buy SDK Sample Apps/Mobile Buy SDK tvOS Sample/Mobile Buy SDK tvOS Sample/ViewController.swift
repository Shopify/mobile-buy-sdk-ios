//
//  ViewController.swift
//  Mobile Buy SDK tvOS Sample App
//
//  Created by Shopify.
//  Copyright (c) 2016 Shopify Inc. All rights reserved.
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

class ViewController: UIViewController, DataProviderSetter {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collections: Array<BUYCollection> = []
    var dataProvider: DataProvider!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider.delegate = self
        self.dataProvider.getCollections()
    }
    
    // this function is just here to demonstrate focus for the collection view
    // will remove once product cells are in this
    func getRandomColor() -> UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

extension ViewController: DataProviderDelegate {
    
    func dataProviderDidFinishDownloadingCollections(_dataProvider: DataProvider, collections: Array<BUYCollection>) {
        self.collections = collections
        self.collectionView.reloadData()
    }
    
    func dataProviderDidFinishDownloadingProducts(_dataProvider: DataProvider, collection: NSNumber, products: Array<BUYProduct>) {
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewContainerCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = self.getRandomColor()
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}
