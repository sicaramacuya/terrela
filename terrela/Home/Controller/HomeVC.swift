//
//  HomeVC.swift
//  terrela
//
//  Created by Eric Morales on 7/12/21.
//

import UIKit

class HomeVC: UIViewController {
    // MARK: Properties
    let menuButton: UIButton = {return UIButton()}()
    
    let bottomStack: UIStackView = {return UIStackView()}()
    let collectionView: UICollectionView! = nil // will have title section and cells
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemGray6
        TitleStack(homeView: self.view)
    }
    
    // MARK: Methods
}

