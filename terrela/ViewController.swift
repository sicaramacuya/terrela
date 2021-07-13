//
//  ViewController.swift
//  terrela
//
//  Created by Eric Morales on 7/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    let testingView: UIView = {
        let myView = UIView(frame: .zero)
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .systemPink
        
        return myView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupMyView()
    }
    
    func setupMyView() {
        view.addSubview(testingView)
        
        testingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        testingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        testingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        testingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        testingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0).isActive = true
        testingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        
    }

}

