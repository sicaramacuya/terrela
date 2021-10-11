//
//  TitleStack.swift
//  terrela
//
//  Created by Eric Morales on 7/12/21.
//

import UIKit

class TitleStack: UIView {
    // MARK: Properties
    var homeView: UIView!
    let date: Date = Date()
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        
        return formatter.string(from: date)
    }
    let menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    let topStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill // direction of axis
        stack.alignment = .leading // perpendicular to axis
        stack.spacing = 5
        
        return stack
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 42, weight: .regular)
        label.text = "Terrela"
        
        return label
    }()
    var dateLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = dateString
        
        return label
    }
    var searchButton: UIButton!
    
    // MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(homeView: UIView) {
        self.init()
        self.searchButton = SearchButton(vcView: homeView)
        self.homeView = homeView
        self.setup(homeView: homeView)
    }
    
    func setup(homeView: UIView) {
        // MARK: View's hierarchy
        homeView.addSubview(menuButton)
        homeView.addSubview(topStack)
        topStack.addArrangedSubview(titleLabel)
        topStack.addArrangedSubview(dateLabel)
        topStack.addArrangedSubview(searchButton)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: homeView.safeAreaLayoutGuide.topAnchor, constant: 10),
            menuButton.leadingAnchor.constraint(equalTo: homeView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            menuButton.heightAnchor.constraint(equalToConstant: 25),
            menuButton.widthAnchor.constraint(equalToConstant: 32),
            
            topStack.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 40),
            topStack.centerXAnchor.constraint(equalTo: homeView.centerXAnchor),
        ])
        
        // add target to menu
        menuButton.addTarget(self, action: #selector(self.openMenu), for: .touchUpInside)
    }
    
    @objc func openMenu() {
        print("Menu button has been tapped.")
    }
}
