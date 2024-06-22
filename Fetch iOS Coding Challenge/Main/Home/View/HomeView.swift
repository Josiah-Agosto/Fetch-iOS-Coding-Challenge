//
//  HomeView.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import UIKit

class HomeView: UIView {
    // MARK: - References / Properties
    public lazy var filterBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"))
        return item
    }()
    public lazy var mockProfileBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "person.circle"))
        return item
    }()
    public lazy var navigationBarCustomView: UIView = {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        return customView
    }()
    public lazy var navigationBarTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        // Hardcoded since we are only focusing on Dessert.
        label.text = "Dessert"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    public lazy var navigationBarRecipeCategorySelectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return button
    }()
    public lazy var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    public lazy var searchBar: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search Desserts"
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    public lazy var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeItemCollectionViewCell.self, forCellWithReuseIdentifier: "HomeItemCollectionViewCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(contentView)
        contentView.addSubview(searchBar)
        contentView.addSubview(itemCollectionView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureNavigationBarCustomView() {
        navigationBarCustomView.addSubview(navigationBarTitleLabel)
        navigationBarCustomView.addSubview(navigationBarRecipeCategorySelectionButton)
        // Setup Constraints
        // Navigation Bar Title Label
        navigationBarTitleLabel.leadingAnchor.constraint(equalTo: navigationBarCustomView.leadingAnchor).isActive = true
        navigationBarTitleLabel.topAnchor.constraint(equalTo: navigationBarCustomView.topAnchor).isActive = true
        navigationBarTitleLabel.bottomAnchor.constraint(equalTo: navigationBarCustomView.bottomAnchor).isActive = true
        // Navigation Bar Recipe Category Selection Button
        navigationBarRecipeCategorySelectionButton.leadingAnchor.constraint(equalTo: navigationBarTitleLabel.trailingAnchor, constant: 5).isActive = true
        navigationBarRecipeCategorySelectionButton.trailingAnchor.constraint(equalTo: navigationBarCustomView.trailingAnchor).isActive = true
        navigationBarRecipeCategorySelectionButton.centerYAnchor.constraint(equalTo: navigationBarCustomView.centerYAnchor).isActive = true
    }
    
    
    private func setupConstraints() {
        // Content View
        contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        // Search Bar
        searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Item Collection View
        itemCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        itemCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30).isActive = true
        itemCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        itemCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        itemCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
    }
    
}
