//
//  PictureVC.swift
//  terrela
//
//  Created by Eric Morales on 10/9/21.
//

import UIKit

class PictureVC: UIViewController {
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.image = UIImage(named: "placeholder")
        
        return image
    }()
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Details", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = self.view.tintColor
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        
        return button
    }()
    lazy var stackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [self.image,
                                                       spacer,
                                                       self.registerButton
                                                       ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        return stackView
    }()
    lazy var images: [APOD] = [] {
      didSet {
        // feedTableView.reloadData()
      }
    }
    lazy var networkManager: APODService = APODService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemTeal
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        
        setup()
        registerButton.addTarget(self,
                                 action: #selector(presentModalController),
                                 for: .touchUpInside)
    }
    
    private func setup() {
        
        // MARK: View's hierarchy
        self.view.addSubview(stackView)
        
        // MARK: Constraints
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func presentModalController() {
        self.navigationController?.present(PictureDetailsVC(), animated: true)
        
        
        networkManager.getPictureOfTheDay { result in
            switch result {
            case let .success(images):
              self.images = images
            case let .failure(error):
              print(error)
            }
        }
    }
}
