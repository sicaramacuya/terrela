//
//  PictureCell.swift
//  terrela
//
//  Created by Eric Morales on 10/9/21.
//

import UIKit

class PictureCell: UITableViewCell {
    
    // MARK: Properties
    static var identifier: String = "Category Cell"
    lazy var pictureOfTheDay: APOD? = nil {
        didSet {
            guard let picture = self.pictureOfTheDay else { return }
            
            self.titleLabel.text = picture.title
            self.dateLabel.text = picture.formatDate(stringDate: picture.date)
            
            self.updatePreviewImage(url: picture.url)
        }
    }
    lazy var mission: Mission? = nil {
        didSet {
            guard let mission = self.mission else { return }

            self.titleLabel.text = mission.name
            
            self.updatePreviewImage(url: mission.imageURL)
            
            guard let startDate = mission.startDate else { return }
            self.dateLabel.text = "Starting date: \(startDate)"
        }
    }
    lazy var rocket: Rocket? = nil {
        didSet {
            guard let rocket = self.rocket else { return }
            
            self.titleLabel.text = rocket.name
            self.dateLabel.text = "Is still in use? \(rocket.rocketConfig.isBeingUsed ? "Yes" : "No" )"
            
            self.updatePreviewImage(url: rocket.rocketConfig.imageURL)
        }
    }
    
    var previewImageID: UUID?
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray6
        
        return stackView
    }()
    lazy var previewImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.image = UIImage(named: "placeholder")
        
        return image
    }()
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.backgroundColor = .systemGray6
        
        return stackView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 3
        
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "September 21, 2021"
        
        return label
    }()
    
    // MARK: Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        // Setting the color of the cell
        self.backgroundColor = .systemGray6
        
        // MARK: View's Hierarchy
        self.contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(previewImage)
        horizontalStackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(dateLabel)
        
        // MARK: Constraints
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            previewImage.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor),
            previewImage.widthAnchor.constraint(equalTo: previewImage.heightAnchor),
            
            verticalStackView.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor),
            titleLabel.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, multiplier: 0.25),
            titleLabel.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, multiplier: 0.75)
        ])
    }
    
    private func updatePreviewImage(url: URL) {
        let previewImageID = UUID()
        self.previewImageID = previewImageID
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            
            let image = UIImage(data: data)
            
            guard let self = self else { return }
            guard self.previewImageID == previewImageID else { return }
            
            DispatchQueue.main.async {
                self.previewImage.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.previewImage.image = UIImage(named: "placeholder")
        self.previewImageID = nil
        self.titleLabel.text = nil
        self.dateLabel.text = nil
    }
}
