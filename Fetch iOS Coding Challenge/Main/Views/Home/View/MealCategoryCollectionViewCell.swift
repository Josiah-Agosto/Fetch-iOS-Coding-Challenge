//
//  MealCategoryCollectionViewCell.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import UIKit

class MealCategoryCollectionViewCell: UICollectionViewCell {
    // MARK: - References / Properties
    /// Image view displaying the meal's thumbnail.
    public lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    /// Gradient layer for the container view holding the item description.
    public lazy var itemDescriptionContainerViewGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        return gradientLayer
    }()
    /// Container view holding the item's description.
    public lazy var itemDescriptionContainerView: UIView = {
        let itemContainerView = UIView(frame: .zero)
        itemContainerView.translatesAutoresizingMaskIntoConstraints = false
        return itemContainerView
    }()
    /// Label displaying the name of the meal.
    public lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        contentView.addSubview(itemImage)
        contentView.addSubview(itemDescriptionContainerView)
        itemDescriptionContainerView.addSubview(itemNameLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Allows the gradient to visibly show when the cell appears, without it, the gradient does not show as expected.
        itemDescriptionContainerView.layer.insertSublayer(itemDescriptionContainerViewGradientLayer, at: 0)
        itemDescriptionContainerViewGradientLayer.frame = itemDescriptionContainerView.bounds
    }
    
    /// Setts up constraints for the entire cell.
    private func setupConstraints() {
        // Item Image constraints
        itemImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        itemImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        itemImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        // Item Description Container View constraints
        itemDescriptionContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        itemDescriptionContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        itemDescriptionContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        itemDescriptionContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        // Item Name Label constraints
        itemNameLabel.topAnchor.constraint(equalTo: itemDescriptionContainerView.topAnchor, constant: 8).isActive = true
        itemNameLabel.leadingAnchor.constraint(equalTo: itemDescriptionContainerView.leadingAnchor, constant: 5).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: itemDescriptionContainerView.trailingAnchor, constant: -5).isActive = true
        itemNameLabel.bottomAnchor.constraint(equalTo: itemDescriptionContainerView.bottomAnchor, constant: -8).isActive = true
    }
    
    // MARK: - Public Methods
    /// Configures the cell with meal data.
    /// - Parameter meal: The meal object containing data to display.
    public func configureCellWithMeal(_ meal: Meal) {
        itemNameLabel.text = meal.name
        Task {
            itemImage.image = await ImageCache.shared.loadImage(url: meal.thumbnail ?? "")
        }
    }
    
}
