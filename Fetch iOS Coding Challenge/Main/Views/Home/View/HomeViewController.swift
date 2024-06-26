//
//  HomeViewController.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import UIKit
import SwiftUI
import Combine

class HomeViewController: UIViewController {
    // MARK: - References / Properties
    /// The type of view model to inject.
    private let homeViewModel: any HomeViewModelProtocol
    /// Custom view for the home screen.
    private var homeView: HomeView!
    /// Bar button item for sorting meals.
    private var sortMealsBarButtonItem: UIBarButtonItem!
    /// Set to hold Combine cancellables to manage subscriptions.
    private var anyCancelableSet = Set<AnyCancellable>()
    
    init(homeViewModel: any HomeViewModelProtocol) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        homeViewModel.dessertsPublisher
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
        homeViewModel.searchedDessertsPublisher
            .receive(on: DispatchQueue.main)
            .dropFirst() // Skip initial empty value
            .sink { _ in
                self.homeView.reloadCells()
            }
            .store(in: &anyCancelableSet)
        // Bindings for sorting option changes.
        homeViewModel.sortingOptionPublisher
            .receive(on: DispatchQueue.main)
            .dropFirst() // Skip initial empty value
            .sink { sortingOption in
                self.homeView.stopActivityIndicatorAnimating()
                self.homeViewModel.retrieveDessertMeals(sortingOption: sortingOption)
            }
            .store(in: &anyCancelableSet)
        // Bindings for empty search results.
        homeViewModel.emptyMealSearchResultsPublisher
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
        homeViewModel.retrievingMealCategoriesErrorPublisher
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
    
    /// An action to come back from the SwiftUI `MealDetailView`.
    @objc private func mealDetailBackButtonItemAction() {
        navigationController?.popViewController(animated: true)
    }
    
    /// Creates and presents the popover view controller for changing sort option.
    private func presentMealSortPopover() {
        let popoverController = MealSortingPopoverViewController(viewModel: MealSortingOptionsViewModel(selectedSortingOption: homeViewModel.sortingOption))
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
    
    
    private func createCustomBackButton() -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(mealDetailBackButtonItemAction), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mealDetailViewModel = MealDetailViewModel(meal: homeViewModel.searchedDesserts.isEmpty ? homeViewModel.desserts[indexPath.item] : homeViewModel.searchedDesserts[indexPath.item], mealDbManager: MealDbManager())
        let mealDetailView = MealDetailView(mealDetailViewModel: mealDetailViewModel)
        let hostingController = UIHostingController(rootView: mealDetailView)
        hostingController.navigationItem.leftBarButtonItem = createCustomBackButton()
        navigationController?.pushViewController(hostingController, animated: true)
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
