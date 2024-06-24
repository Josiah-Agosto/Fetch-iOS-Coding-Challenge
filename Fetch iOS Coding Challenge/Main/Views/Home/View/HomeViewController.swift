//
//  HomeViewController.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    // MARK: - References / Properties
    /// View model managing the data and logic for the home view.
    public let homeViewModel: HomeViewModel = HomeViewModel()
    /// Custom view for the home screen.
    private var homeView: HomeView!
    /// Bar button item for sorting meals.
    private var sortMealsBarButtonItem: UIBarButtonItem!
    /// Set to hold Combine cancellables to manage subscriptions.
    private var anyCancelableSet = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        homeView = HomeView()
        self.view = homeView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewDelegates()
        setupRefreshControl()
        setupNavigationBarItems()
        setupViewBindings()
        homeView.setupActivityIndicator()
        homeViewModel.retrieveDessertMeals(sortingOption: .alphabeticallyAscending)
    }
    
    // MARK: - Private Methods
    /// Assigns the meal category collection view delegates.
    private func setupCollectionViewDelegates() {
        homeView.mealCategoryCollectionView.delegate = self
        homeView.mealCategoryCollectionView.dataSource = self
    }
    
    /// Sets up pull to refresh control target.
    private func setupRefreshControl() {
        homeView.mealCategoryRefreshControl.addTarget(self, action: #selector(pullDownToRefreshControlAction), for: .valueChanged)
    }
    
    /// Setts up navigation bar configurations.
    private func setupNavigationBarItems() {
        homeView.configureNavigationBarCustomView()
        navigationItem.titleView = homeView.navigationBarCustomView
        sortMealsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3")!.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(sortButtonAction))
        navigationItem.leftBarButtonItem = sortMealsBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle")!.withTintColor(.black, renderingMode: .alwaysOriginal))
    }
    
    /// All combine bindings that connect the UI and data.
    private func setupViewBindings() {
        // Bindings for search bar text changes.
        homeView.searchBar.textDidChangePublisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                guard let self = self else { return }
                self.homeViewModel.filterDesserts(by: searchText ?? "")
            }
            .store(in: &anyCancelableSet)
        // Bindings for updating collection view based on desserts.
        homeViewModel.$desserts
            .receive(on: DispatchQueue.main)
            .dropFirst() // Skip initial empty value
            .sink { desserts in
                self.homeView.stopActivityIndicatorAnimating()
                self.homeView.stopRefreshControlAnimating()
                if desserts.isEmpty {
                    self.homeView.displayMessage("Oh no! Couldn't find any meals in that category.")
                } else {
                    self.homeView.removeMessage()
                    self.homeView.reloadCells()
                }
            }
            .store(in: &anyCancelableSet)
        // Bindings for updating collection view based on searched desserts.
        homeViewModel.$searchedDesserts
            .receive(on: DispatchQueue.main)
            .dropFirst() // Skip initial empty value
            .sink { _ in
                self.homeView.reloadCells()
            }
            .store(in: &anyCancelableSet)
        // Bindings for sorting option changes.
        homeViewModel.$sortingOption
            .receive(on: DispatchQueue.main)
            .dropFirst() // Skip initial empty value
            .sink { sortingOption in
                self.homeView.stopActivityIndicatorAnimating()
                self.homeViewModel.retrieveDessertMeals(sortingOption: sortingOption)
            }
            .store(in: &anyCancelableSet)
        // Bindings for empty search results.
        homeViewModel.$emptyMealSearchResults
            .receive(on: DispatchQueue.main)
            .dropFirst() // Skip initial empty value
            .sink { noMealsFound in
                if noMealsFound {
                    self.homeView.displayMessage("No meals found!")
                } else {
                    self.homeView.removeMessage()
                }
            }
            .store(in: &anyCancelableSet)
        // Bindings for retrieval errors.
        homeViewModel.$retrievingMealCategoriesError
            .receive(on: DispatchQueue.main)
            .dropFirst() // Skip initial empty value
            .sink { _ in
                self.homeView.stopActivityIndicatorAnimating()
                self.homeView.stopRefreshControlAnimating()
                self.homeView.displayErrorMessage("Couldn't get meals in that category. Pull down to try again!", hidden: false)
            }
            .store(in: &anyCancelableSet)
    }
    
    /// Called when pull down to refresh is triggered.
    @objc private func pullDownToRefreshControlAction() {
        homeViewModel.retrieveDessertMeals(sortingOption: homeViewModel.sortingOption)
    }
    
    /// Called when the sort button is pressed.
    @objc private func sortButtonAction() {
        presentMealSortPopover()
    }
    
    /// Creates and presents the popover view controller for changing sort option.
    private func presentMealSortPopover() {
        let popoverController = MealSortingPopoverViewController()
        popoverController.mealSortingPopoverSelectionDelegate = self
        popoverController.modalPresentationStyle = .popover
        popoverController.preferredContentSize = CGSize(width: 300, height: 88)
        if let popoverPresentationController = popoverController.popoverPresentationController {
            popoverPresentationController.barButtonItem = sortMealsBarButtonItem
            popoverPresentationController.permittedArrowDirections = .any
            popoverPresentationController.delegate = self
            popoverPresentationController.sourceView = self.view
        }
        DispatchQueue.main.async {
            self.present(popoverController, animated: true, completion: nil)
        }
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10, height: 175)
    }
    
}


// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.searchedDesserts.isEmpty ? homeViewModel.desserts.count : homeViewModel.searchedDesserts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealCategoryCollectionViewCell", for: indexPath) as? MealCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let dessert = homeViewModel.searchedDesserts.isEmpty ? homeViewModel.desserts[indexPath.item] : homeViewModel.searchedDesserts[indexPath.item]
        cell.configureCellWithMeal(dessert)
        return cell
    }
    
}


// MARK: - UIPopoverPresentationControllerDelegate
extension HomeViewController: UIPopoverPresentationControllerDelegate {
    
    // Used to ensure the popover style no matter the device.
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
}


// MARK: - MealSortingPopoverSelectionProtocol
extension HomeViewController: MealSortingPopoverSelectionProtocol {
    
    func sortingOptionSelected(_ option: MealSortingOption) {
        homeViewModel.sortingOption = option
        homeView.setupActivityIndicator()
    }
    
}
