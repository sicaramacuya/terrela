//
//  TestingCategoryCell.swift
//  terrela
//
//  Created by Eric Morales on 7/13/21.
//

import UIKit

class TestingCategoryCell: UICollectionViewCell {
    
    // MARK: Properties
    static var identifier: String = "TestingCategoryCell"
    
    
    let imageSize: CGSize = CGSize(width: 20, height: 20)
    var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray4
        button.tintColor = .systemGray
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        button.setTitleColor(.systemGray, for: .normal)
        button.setImage(UIImage(systemName: "flame"), for: .normal)
        button.setTitle("Rockets", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true

        return button
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
        // MARK: Constrains
        self.addSubview(button)
 
        // MARK: Constraints
        button.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -20).isActive = true
        button.imageView!.widthAnchor.constraint(equalTo: button.imageView!.heightAnchor).isActive = true
        
        // MARK: Target
        button.addTarget(self, action: #selector(self.goSearchPage), for: .touchUpInside)
    }
    
    @objc func goSearchPage() {
        print("Search button has been tapped.")
    }
}

