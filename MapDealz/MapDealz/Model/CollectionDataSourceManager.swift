//
//  CollectionDataSourceManager.swift
//  Mapdealz
//
//  Created by Soeb on 10/27/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import Foundation
import UIKit

class CollectionDataSourceManager: NSObject, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! OfferCollectionCell
        return cell
    }

    
    
}

extension CollectionDataSourceManager : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
