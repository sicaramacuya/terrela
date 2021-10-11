//
//  PictureDetailsVC.swift
//  terrela
//
//  Created by Eric Morales on 10/11/21.
//

import UIKit

class PictureDetailsVC: UIViewController {

    // MARK: Properties
    lazy var date: Date = Date()
    lazy var dateString: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyy"
        
        return formatter.string(from: date)
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 25
        
        return stackView
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = dateString
        
        return label
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 35, weight: .medium)
        label.text = "Astronaut Akihiko Hoshide Conducts DNA Sequencing Aboard Station"
        label.numberOfLines = 0
        
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        label.text = "Description:"
        label.numberOfLines = 0
        
        return label
    }()
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 32)
        textView.isEditable = false
        textView.text = """
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Proin libero nunc consequat interdum varius sit amet mattis vulputate. Pretium nibh ipsum consequat nisl vel pretium lectus. Aliquam ultrices sagittis orci a scelerisque. Et netus et malesuada fames. Laoreet non curabitur gravida arcu ac tortor dignissim convallis aenean. Quis blandit turpis cursus in hac habitasse platea dictumst quisque. Tincidunt tortor aliquam nulla facilisi cras fermentum odio. Neque volutpat ac tincidunt vitae semper quis lectus nulla at. Imperdiet sed euismod nisi porta lorem mollis aliquam ut. Condimentum mattis pellentesque id nibh tortor id aliquet. Adipiscing diam donec adipiscing tristique risus nec. Eu ultrices vitae auctor eu augue ut lectus arcu. Odio facilisis mauris sit amet.

                        Tempor commodo ullamcorper a lacus vestibulum sed arcu non. Justo eget magna fermentum iaculis eu non diam phasellus vestibulum. Enim sed faucibus turpis in eu mi bibendum. Mi eget mauris pharetra et ultrices neque ornare. Egestas tellus rutrum tellus pellentesque eu. Arcu risus quis varius quam. Ornare quam viverra orci sagittis eu. Consectetur lorem donec massa sapien faucibus et molestie ac feugiat. Sit amet mauris commodo quis imperdiet. Sit amet consectetur adipiscing elit ut aliquam. Ac auctor augue mauris augue neque. Eu augue ut lectus arcu bibendum. Quam viverra orci sagittis eu volutpat odio. Non quam lacus suspendisse faucibus interdum posuere lorem ipsum dolor. Duis at tellus at urna condimentum. Nunc pulvinar sapien et ligula ullamcorper malesuada proin libero. Egestas egestas fringilla phasellus faucibus scelerisque. Odio ut sem nulla pharetra diam sit amet nisl. Bibendum arcu vitae elementum curabitur vitae nunc. Purus in mollis nunc sed.
                        """
        
        return textView
    }()
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGreen
        self.setup()
    }
    
    // MARK: Methods
    private func setup() {
        
        // MARK: View's hierarchy
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(descriptionTextView)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
        ])
    }
}
