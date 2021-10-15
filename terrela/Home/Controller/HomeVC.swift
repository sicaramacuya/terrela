//
//  HomeVC.swift
//  terrela
//
//  Created by Eric Morales on 7/12/21.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: Properties
    lazy var categories: [Category] = [.pictureOfTheDay, .missions, .rockets]
    lazy var imageName: [imageName] = [.pictureOfTheDay, .missions, .rockets]
    lazy var sections: [Section] = [
        TitleSection(title: "What do you want to learn about?"),
        CategorySection(items: (categories, imageName))
    ]
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        
        return collectionView
    }()
    lazy var collectionViewLayout: UICollectionViewLayout = {
        var sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            
            return sections[sectionIndex].layoutSection()
        }
        return layout
    }()
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        self.view.backgroundColor = .systemGray6
        TitleStack(homeView: self.view)
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    // MARK: Methods
    private func setupCollectionView() {
        
        // MARK: Setting Delegate and Data Source
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // MARK: Registering
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: TitleCell.identifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)

        // MARK: View's Hierarchy
        self.view.addSubview(collectionView)
        
        // MARK: Constraints
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 0.5).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -250).isActive = true
        
        // MARK: Reload Data
        collectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.reloadData()
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(categories[indexPath.row].displayName())
        
        let categoryListVC = PictureListVC()
        categoryListVC.category = categories[indexPath.row]
        self.navigationController?.pushViewController(categoryListVC, animated: true)
    }
}

