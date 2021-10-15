//
//  PictureDetailsVC.swift
//  terrela
//
//  Created by Eric Morales on 10/11/21.
//

import UIKit

class PictureDetailsVC: UIViewController {
    
    // MARK: Properties
    lazy var pictureOfTheDay: APOD? = nil {
        didSet {
            guard let picture = self.pictureOfTheDay else { return }
            
            dateLabel.text = picture.formatDate(stringDate: picture.date)
            titleLabel.text = picture.title
            explanationLabel.text = picture.explanation
        }
    }
    lazy var mission: Mission? = nil {
        didSet {
            guard let mission = self.mission else { return }
            
            titleLabel.text = mission.name
            explanationLabel.text = mission.description
            
            guard let startDate = mission.startDate else { return }
            dateLabel.text = mission.formatDate(stringDate: startDate)
        }
    }
    lazy var rocket: Rocket? = nil {
        didSet {
            guard let rocket = self.rocket else { return }
            
            dateLabel.text = "Is still in use? \(rocket.rocketConfig.isBeingUsed ? "Yes" : "No" )"
            titleLabel.text = rocket.name
            explanationLabel.text = rocket.description
        }
    }
    
    let maxDimmedAlpha: CGFloat = 0.6 // Alpha component for dimmedView
    let defaultHeight: CGFloat = 300 // At the height the modal opens to
    let dismissibleHeight: CGFloat = 200 // Hight where the modal is automatically dismiss
    var currentContainerHeight: CGFloat = 300 // Constantly being updated
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64 // Max height for modal
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        
        return view
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        return view
    }()
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [dateLabel,
                                                       titleLabel,
                                                       explanationLabel,
                                                       spacer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12.0
        
        return stackView
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    lazy var explanationLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        
        return label
    }()
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setup()
        self.setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animatePresentContainer()
        self.animateShowDimmedView()
    }
    
    
    // MARK: Methods
    private func setupView() {
        self.view.backgroundColor = .clear
    }
    
    private func setup() {
        
        // MARK: View's hierarchy
        
        self.view.addSubview(dimmedView)
        self.view.addSubview(containerView)
        containerView.addSubview(contentStackView)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            
            dimmedView.topAnchor.constraint(equalTo: self.view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        // Set container to a default height
        self.containerViewHeightConstraint = self.containerView.heightAnchor.constraint(equalToConstant: self.defaultHeight)
        // Set bottom constant to 0
        self.containerViewBottomConstraint = self.containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.defaultHeight)
        
        // Activate constraints
        self.containerViewHeightConstraint?.isActive = true
        self.containerViewBottomConstraint?.isActive = true
        
    }
}

extension PictureDetailsVC {
    // MARK: Modal Specific Methods
    private func animatePresentContainer() {
        // Update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateShowDimmedView() {
        self.dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    private func animateDismissView() {
        // hide main container view by updating buttom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh contraint
            self.view.layoutIfNeeded()
        }
        
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
    }
    
    private func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        // Drag to top will be minus value and vice versa
        print("Pan gesture 'y' offset: \(translation.y)")
        
        // Get drag direction
        let isDraggingDown = translation.y > 0
        print("Dragging direction: \(isDraggingDown ? "Going down" : "Going up")")
        
        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y
        
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            containerViewHeightConstraint?.constant = newHeight
            // Refresh layout
            self.view.layoutIfNeeded()
        case .ended:
            // This happens when user stop drag, so we will get the last height of container
            
            if newHeight < dismissibleHeight {
                // Condition 1: If new height is below min, dismiss controller
                self.animateDismissView()
            } else if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
}
