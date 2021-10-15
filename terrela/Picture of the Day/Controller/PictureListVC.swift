//
//  PictureListVC.swift
//  terrela
//
//  Created by Eric Morales on 10/8/21.
//

import UIKit

class PictureListVC: UIViewController {
    
    // MARK: Properties
    var category: Category?
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
    lazy var rockets: [Rocket] = [] {
        didSet {
            table.reloadData()
        }
    }
    lazy var missions: [Mission] = [] {
        didSet {
            table.reloadData()
        }
    }
    
    lazy var networkManagerNASA = APODService()
    lazy var networkManagerLaunchLibrary = LaunchLibraryService()
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        
        setTable()
        updateList(category: self.category!)
        // setSearchBar()
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
    
    private func updateList(category: Category) {
        switch category {
        case .pictureOfTheDay:
            networkManagerNASA.getPictureOfTheDay { result in
                switch result {
                case let .success(picturesOfTheDay):
                    self.picturesOfTheDay = picturesOfTheDay.reversed()
                case let .failure(error):
                    print(error)
                    print("Error occured with getting the pictures.")
                }
            }
        case .missions:
            networkManagerLaunchLibrary.getMissions { result in
                switch result {
                case .success(let missions):
                    self.missions = missions
                case .failure(let error):
                    print(error)
                    print("Error occured with getting the missions.")
                }
            }
        case .rockets:
            networkManagerLaunchLibrary.getRockets { result in
                switch result {
                case .success(let rockets):
                    self.rockets = rockets
                case .failure(let error):
                    print(error)
                    print("Error occured with getting the rockets.")
                }
            }
        default:
            print("")
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
        switch category {
        case .pictureOfTheDay:
            return picturesOfTheDay.count
        case .missions:
            return missions.count
        case .rockets:
            return rockets.count
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifier, for: indexPath) as! PictureCell
        
        switch category {
        case .pictureOfTheDay:
            let picture = self.picturesOfTheDay[indexPath.row]
            cell.pictureOfTheDay = picture
            
            return cell
        case .missions:
            let mission = self.missions[indexPath.row]
            cell.mission = mission
            
            return cell
        case .rockets:
            let rocket = self.rockets[indexPath.row]
            cell.rocket = rocket
            
            return cell
        default:
            return cell
        }
        
    }
}

extension PictureListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) selected.")
        let pictureVC = PictureVC()
        pictureVC.category = self.category
        
        switch category {
        case .pictureOfTheDay:
            pictureVC.pictureOfTheDay = self.picturesOfTheDay[indexPath.row]
        case .missions:
            pictureVC.mission = self.missions[indexPath.row]
        case .rockets:
            pictureVC.rocket = rockets[indexPath.row]
        default:
            print("TableView DidSelect Default")
        }
        
        self.navigationController?.pushViewController(pictureVC, animated: true)
    }
}
