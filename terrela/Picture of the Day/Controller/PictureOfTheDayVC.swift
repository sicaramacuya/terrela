//
//  PictureOfTheDayVC.swift
//  terrela
//
//  Created by Eric Morales on 10/8/21.
//

import UIKit

class PictureOfTheDayVC: UIViewController {

    let testingTitles: [String] = ["Astronaut Akihiko Hoshide Conducts DNA Sequencing Aboard Station",
                                   "Liftoff of Landsat 9",
                                   "The Double CLuster in Perseus",
                                   "Baffin Bay, Greenland A Historical Perspective",
                                   "Saturn at Night"
    ]
    
    // MARK: Properties
    lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemGray6
        
        return table
    }()
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Picture of the Day"
        self.view.backgroundColor = .systemGray6
        
        setTable()
        updateList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        //search.searchBar.scopeButtonTitles = ["Title", "Day"]
        navigationItem.searchController = search
    }
    
    // MARK: Methods
    func setTable() {
        // Adding table to view.
        self.view.addSubview(table)
        
        // Constraints
        table.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        // Letting table know we want to use the custom cell file.
        table.register(PictureOfTheDayTabelViewCell.self, forCellReuseIdentifier: PictureOfTheDayTabelViewCell.identifier)
        
        // Setting the delegate and dataSource.
        table.dataSource = self
        table.delegate = self
        
        
    }
    
    func updateList() {
        
    }

}

extension PictureOfTheDayVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PictureOfTheDayTabelViewCell.identifier, for: indexPath) as! PictureOfTheDayTabelViewCell
        
        
        cell.titleLabel.text = testingTitles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row) selected.")
    }
}

extension PictureOfTheDayVC: UITableViewDelegate {
    
}
