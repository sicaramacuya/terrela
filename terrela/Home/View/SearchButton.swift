//
//  SearchButton.swift
//  terrela
//
//  Created by Eric Morales on 7/12/21.
//

import UIKit

class SearchButton: UIButton {
    
    // MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(vcView view: UIView) {
        self.init()
        setup(vcView: view)
    }
    
    func setup(vcView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Properties
        self.backgroundColor = .systemGray4
        self.tintColor = .systemGray
        self.contentHorizontalAlignment = .left
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        self.setTitleColor(.systemGray, for: .normal)
        self.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        self.setTitle("Search", for: .normal)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.addTarget(self, action: #selector(self.goSearchPage), for: .touchUpInside)
        
        // MARK: Constrains
        vcView.addSubview(self)
        
        // MARK: Constraints
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.widthAnchor.constraint(equalTo: vcView.safeAreaLayoutGuide.widthAnchor, constant: -20).isActive = true
    }
    
    @objc private func goSearchPage() {
        print("Search button has been tapped.")
    }
    
}
