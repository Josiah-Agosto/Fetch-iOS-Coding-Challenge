//
//  MealSortingPopoverViewController.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import UIKit

/// ViewController for displaying a popover to select meal sorting options.
class MealSortingPopoverViewController: UIViewController {
    // MARK: - References / Properties
    /// The view that is being represented in this view controller.
    private var mealSortingPopoverView: MealSortingPopoverView!
    /// The view controllers view model.
<<<<<<< HEAD
    private let viewModel = MealSortingOptionsViewModel()
    /// Delegate that is responsible for sending the sorting option that was selected.
    weak public var mealSortingPopoverSelectionDelegate: MealSortingPopoverSelectionProtocol?
    
=======
    private let viewModel: any MealSortingOptionsViewModelProtocol
    /// Delegate that is responsible for sending the sorting option that was selected.
    weak public var mealSortingPopoverSelectionDelegate: MealSortingPopoverSelectionProtocol?
    
    /// Creates a new instance with the specified view model.
    /// - Parameter viewModel: Must conform to `MealSortingOptionsViewModelProtocol`.
    init(viewModel: any MealSortingOptionsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
>>>>>>> 2b70d0b826369b5c56aa7824c502a6f31d3513d5
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


// MARK: - UITableViewDelegate
extension MealSortingPopoverViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortingOptions.count
    }
    
}


// MARK: - UITableViewDataSource
extension MealSortingPopoverViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortOptionCell", for: indexPath)
        let option = viewModel.sortingOptions[indexPath.row]
        cell.textLabel?.text = option.displayName
        // Checks if the current row is a selected one or not.
        if option == viewModel.selectedSortingOption {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Visually deselects the row.
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedOption = viewModel.sortingOptions[indexPath.row]
        viewModel.selectedSortingOption = selectedOption
        mealSortingPopoverSelectionDelegate?.sortingOptionSelected(selectedOption)
        mealSortingPopoverView.reloadCells()
        // Removes the view after selection.
        dismiss(animated: true)
    }
    
}




