//
//  MealSortingPopoverViewController.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import UIKit

class MealSortingPopoverViewController: UIViewController {
    // MARK: - References / Properties
    private var mealSortingPopoverView: MealSortingPopoverView!
    private let viewModel = MealSortingOptionsViewModel()
    weak public var mealSortingPopoverSelectionDelegate: MealSortingPopoverSelectionProtocol?
    
    override func loadView() {
        super.loadView()
        mealSortingPopoverView = MealSortingPopoverView()
        self.view = mealSortingPopoverView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealSortingPopoverView.sortingOptionsTableView.dataSource = self
        mealSortingPopoverView.sortingOptionsTableView.delegate = self
    }
    
}



extension MealSortingPopoverViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortingOptions.count
    }
    
}



extension MealSortingPopoverViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortOptionCell", for: indexPath)
        let option = viewModel.sortingOptions[indexPath.row]
        cell.textLabel?.text = option.displayName
        if option == viewModel.selectedSortingOption {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedOption = viewModel.sortingOptions[indexPath.row]
        viewModel.selectedSortingOption = selectedOption
        mealSortingPopoverSelectionDelegate?.sortingOptionSelected(selectedOption)
        mealSortingPopoverView.reloadCells()
        dismiss(animated: true)
    }
    
}




