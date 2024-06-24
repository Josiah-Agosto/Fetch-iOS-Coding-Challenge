//
//  MealSortingPopoverView.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import UIKit

/// View representing the content of the meal sorting options popover.
class MealSortingPopoverView: UIView {
    // MARK: - References / Properties
    /// Responsible for displaying sorting options.
    public lazy var sortingOptionsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SortOptionCell")
        return tableView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(sortingOptionsTableView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    /// Reloads the cells in the sorting options table view.
    public func reloadCells() {
        DispatchQueue.main.async {
            self.sortingOptionsTableView.reloadData()
        }
    }
    
    // MARK: - Private Methods
    /// Creates the constraints for this view.
    private func setupConstraints() {
        sortingOptionsTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sortingOptionsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sortingOptionsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sortingOptionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
