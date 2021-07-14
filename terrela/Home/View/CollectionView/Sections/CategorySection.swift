//
//  CategorySection.swift
//  terrela
//
//  Created by Eric Morales on 7/13/21.
//

import UIKit

struct CategorySection: Section {
    // MARK: Properties
    let numberOfItems: Int
    let items: ([Category], [imageName])
    
    // MARK: Methods
    init(items: ([Category], [imageName])  ){
        self.numberOfItems = items.0.count
        self.items = items
    }
    
    func layoutSection() -> NSCollectionLayoutSection? {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(0.12))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCell.self), for: indexPath) as! CategoryCell
        let category = ( items.0[indexPath.item], items.1[indexPath.item] )
        cell.setContent(category: category)
        
        return cell
    }
}
