//
//  PictureListVC.swift
//  terrela
//
//  Created by Eric Morales on 10/8/21.
//

import UIKit

class PictureListVC: UIViewController {
    
    // MARK: Properties
    lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemGray6
        
        return table
    }()
    lazy var picturesOfTheDay: [APOD] = [] {
        didSet {
            table.reloadData()
        }
    }
    lazy var networkManager = APODService()
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        
        setTable()
        updateList()
        setSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Picture of the Day"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    // MARK: Methods
    private func setTable() {
        
        // MARK: Setting Delegate and Data Source
                table.dataSource = self
                table.delegate = self
        
        // MARK: Registering
                table.register(PictureCell.self, forCellReuseIdentifier: PictureCell.identifier)
        
        // MARK: View's Hierarchy
        self.view.addSubview(table)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            table.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            table.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            table.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    private func updateList() {
        networkManager.getPictureOfTheDay { result in
            switch result {
            case let .success(picturesOfTheDay):
                self.picturesOfTheDay = picturesOfTheDay.reversed()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func setSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        //search.searchBar.scopeButtonTitles = ["Title", "Day"]
        navigationItem.searchController = search
    }
}

extension PictureListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picturesOfTheDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifier, for: indexPath) as! PictureCell
        let picture = picturesOfTheDay[indexPath.row]
        cell.pictureOfTheDay = picture
        
        return cell
    }
}

extension PictureListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) selected.")
        let pictureVC = PictureVC()
        pictureVC.pictureOfTheDay = picturesOfTheDay[indexPath.row]
        
        self.navigationController?.pushViewController(pictureVC, animated: true)
    }
}
