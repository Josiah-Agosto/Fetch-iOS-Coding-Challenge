//
//  MealSortingPopoverView.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import UIKit

class MealSortingPopoverView: UIView {
    // MARK: - References / Properties
    public lazy var sortingOptionsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SortOptionCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        addSubview(sortingOptionsTableView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadCells() {
        DispatchQueue.main.async {
            self.sortingOptionsTableView.reloadData()
        }
    }
    
    
    private func setupConstraints() {
        sortingOptionsTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sortingOptionsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sortingOptionsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sortingOptionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
