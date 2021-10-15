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
    lazy var modal = PictureOfTheDayModal(listView: self.view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemTeal
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()
        
        setup()
    }
    
    private func setup() {
        // MARK: View's hierarchy
        self.view.addSubview(image)
        self.view.addSubview(modal)
        
        // MARK: Constraints
        image.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        modal.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true

    }
    
}
