//
//  PictureVC.swift
//  terrela
//
//  Created by Eric Morales on 10/9/21.
//

import UIKit

class PictureVC: UIViewController {
    
    // MARK: Properties
    var pictureOfTheDay: APOD? {
        didSet {
            guard let picture = self.pictureOfTheDay else { return }
            
            self.updateImage(for: picture)
        }
    }
    var previewImageID: UUID?
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
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
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemTeal
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        
        setup()
        registerButton.addTarget(self,
                                 action: #selector(presentModalController),
                                 for: .touchUpInside)
    }
    
    // MARK: Methods
    private func setup() {
        
        // MARK: View's hierarchy
        self.view.addSubview(image)
        self.view.addSubview(registerButton)
        
        // MARK: Constraints
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([

            image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24),
            registerButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            registerButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24)
        ])
    }
    
    private func updateImage(for pictureOfTheDay: APOD) {
        let previewImageID = UUID()
        self.previewImageID = previewImageID
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: pictureOfTheDay.url) else { return }
            
            let image = UIImage(data: data)
            
            guard let self = self else { return }
            guard self.previewImageID == previewImageID else { return }
            
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
    }
    
    @objc private func presentModalController() {
        let vc = PictureDetailsVC()
        vc.pictureOfTheDay = self.pictureOfTheDay
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
}
