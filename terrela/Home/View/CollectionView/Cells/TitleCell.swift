//
//  TitleCell.swift
//  terrela
//
//  Created by Eric Morales on 7/13/21.
//

import UIKit

class TitleCell: UICollectionViewCell {
    // MARK: Properties
    static var identifier: String = "TitleCell"
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    // MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        // adding it to view
        self.addSubview(label)
        
        // constraints
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
    }
    
    func set(title: String) {
        label.text = title
    }
}
