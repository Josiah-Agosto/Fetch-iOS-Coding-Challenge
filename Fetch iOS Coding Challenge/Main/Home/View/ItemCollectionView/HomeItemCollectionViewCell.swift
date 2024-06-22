//
//  HomeItemCollectionViewCell.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import UIKit

class HomeItemCollectionViewCell: UICollectionViewCell {
    // MARK: - References / Properties
    public lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(white: 0.75, alpha: 0.5)
        return containerView
    }()
    public lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    public lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public lazy var itemCountryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        containerView.layer.cornerRadius = 5
        contentView.addSubview(containerView)
        contentView.addSubview(itemImage)
        containerView.addSubview(itemNameLabel)
        containerView.addSubview(itemCountryImage)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        // Item Image
        itemImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        itemImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        itemImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        // Container View
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        // Item Name
        itemNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        itemNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true
        itemNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Item Country Image
        itemCountryImage.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 5).isActive = true
        itemCountryImage.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor, constant: 10).isActive = true
        itemCountryImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        itemCountryImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
}
