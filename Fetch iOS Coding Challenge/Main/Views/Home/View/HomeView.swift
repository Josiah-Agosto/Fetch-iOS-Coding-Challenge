//
//  HomeView.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import UIKit

class HomeView: UIView {
    // MARK: - References / Properties
    /// Custom view for navigation bar, it is used at the top middle of the navigation bar showing the category and mock button.
    public lazy var navigationBarCustomView: UIView = {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        return customView
    }()
    /// Displays the meal category in the navigation bar custom view.
    public lazy var navigationBarTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        // Hardcoded since we are only focusing on Dessert.
        label.text = "Dessert"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    /// Mock button for selecting recipe category in navigation bar.
    public lazy var navigationBarRecipeCategorySelectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .bold))!
        button.setImage(chevronImage.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    /// Activity indicator shown during data loading.
    public let mealCategoryActivityIndicator = UIActivityIndicatorView(style: .large)
    /// Container view for all content.
    public lazy var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    /// Search bar for filtering desserts.
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
    /// Collection view displaying dessert categories.
    public lazy var mealCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MealCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "MealCategoryCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    /// Refresh control for updating meal categories.
    public let mealCategoryRefreshControl = UIRefreshControl()
    /// Label displayed when no meal categories are found.
    public lazy var noMealCategoryFoundLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(contentView)
        contentView.addSubview(searchBar)
        contentView.addSubview(mealCategoryCollectionView)
        contentView.addSubview(noMealCategoryFoundLabel)
        mealCategoryCollectionView.addSubview(mealCategoryRefreshControl)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    /// Sets up auto layout constraints for subviews.
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
        // Meal Collection View
        mealCategoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        mealCategoryCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30).isActive = true
        mealCategoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        mealCategoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        mealCategoryCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        // No Meal Category Found Label
        noMealCategoryFoundLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        noMealCategoryFoundLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        noMealCategoryFoundLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85).isActive = true
        noMealCategoryFoundLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
    }
    
    // MARK: - Public Methods
    /// Configures the navigation bar custom view with title label and selection button.
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
        navigationBarRecipeCategorySelectionButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        navigationBarRecipeCategorySelectionButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    /// Sets up and displays activity indicator.
    public func setupActivityIndicator() {
        DispatchQueue.main.async {
            self.contentView.addSubview(self.mealCategoryActivityIndicator)
            self.mealCategoryActivityIndicator.center = self.center
            self.mealCategoryActivityIndicator.startAnimating()
        }
    }
    
    /// Stops and hides activity indicator.
    public func stopActivityIndicatorAnimating() {
        DispatchQueue.main.async {
            self.mealCategoryActivityIndicator.isHidden = true
            self.mealCategoryActivityIndicator.stopAnimating()
            self.mealCategoryActivityIndicator.removeFromSuperview()
        }
    }
    
    /// Stops refresh control animation.
    public func stopRefreshControlAnimating() {
        DispatchQueue.main.async {
            self.mealCategoryRefreshControl.endRefreshing()
        }
    }
    
    /// Removes no meal category found message.
    public func removeMessage() {
        DispatchQueue.main.async {
            self.mealCategoryCollectionView.isHidden = false
            self.noMealCategoryFoundLabel.isHidden = true
        }
    }
    
    /// Displays message when no meal category is found.
    /// - Parameter text: The text message to display.
    public func displayMessage(_ text: String) {
        DispatchQueue.main.async {
            self.mealCategoryCollectionView.isHidden = true
            self.noMealCategoryFoundLabel.text = text
            self.noMealCategoryFoundLabel.isHidden = false
        }
    }
    
    /// Displays error message.
    /// - Parameters:
    ///   - text: Error message to display.
    ///   - hidden: Boolean flag to hide or show message.
    public func displayErrorMessage(_ text: String, hidden: Bool) {
        DispatchQueue.main.async {
            self.mealCategoryCollectionView.isHidden = !hidden
            self.noMealCategoryFoundLabel.text = text
            self.noMealCategoryFoundLabel.isHidden = hidden
        }
    }
    
    /// Reloads collection view cells.
    public func reloadCells() {
        DispatchQueue.main.async {
            self.mealCategoryCollectionView.isHidden = true
            self.mealCategoryCollectionView.isHidden = false
            self.mealCategoryCollectionView.reloadData()
        }
    }
    
}
