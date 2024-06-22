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
        let item = UIBarButtonItem(image: UIImage(systemName: "person"))
        return item
    }()
    public lazy var navigationBarCustomView: UIView = {
        let customView = UIView(frame: .zero)
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    public lazy var navigationBarTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        // Hardcoded since we are only focusing on Dessert.
        label.text = "Dessert"
        return label
    }()
    public lazy var navigationBarRecipeCategorySelectionButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return button
    }()
    public lazy var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .red
        return contentView
    }()
    public lazy var searchBar: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search Desserts"
        return textField
    }()
    public lazy var itemCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HomeViewItemCollectionViewLayout())
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
        navigationBarTitleLabel.trailingAnchor.constraint(equalTo: navigationBarCustomView.leadingAnchor).isActive = true
        // Navigation Bar Recipe Category Selection button
        navigationBarRecipeCategorySelectionButton.leadingAnchor.constraint(equalTo: navigationBarTitleLabel.trailingAnchor).isActive = true
        navigationBarRecipeCategorySelectionButton.centerXAnchor.constraint(equalTo: navigationBarTitleLabel.centerXAnchor).isActive = true
    }
    
    
    private func setupConstraints() {
        // Content View
        contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        // Search Bar
        searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Item Collection View
        itemCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        itemCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        itemCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        itemCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
