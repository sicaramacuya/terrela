//
//  Section.swift
//  terrela
//
//  Created by Eric Morales on 7/13/21.
//

import UIKit

protocol Section {
    var numberOfItems: Int { get }
    
    func layoutSection() -> NSCollectionLayoutSection?
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}
