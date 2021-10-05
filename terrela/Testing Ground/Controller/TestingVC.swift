//
//  TestingVC.swift
//  terrela
//
//  Created by Eric Morales on 7/13/21.
//

import UIKit

class TestingVC: UIViewController {
    // MARK: Properties
    var collectionView: UICollectionView!
    lazy var sections: [Section] = [
        TitleSection(title: "What do you want to learn about?"),
        TestingCategorySection()
    ]
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
        self.view.backgroundColor = .white
        setupCollectionView()
    }
    
    // MARK: Methods
    func setupCollectionView() {
        
        // instanciate
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        // properties
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemRed
        
        // setting delegate and data source
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // registering
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: TitleCell.identifier)
        collectionView.register(TestingCategoryCell.self, forCellWithReuseIdentifier: TestingCategoryCell.identifier)

        // adding to the view
        self.view.addSubview(collectionView)
        
        // constraints
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 0.5).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 500).isActive = true
        
        // reloads all data in collectionView
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.reloadData()
    }
}

extension TestingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
    }
}
