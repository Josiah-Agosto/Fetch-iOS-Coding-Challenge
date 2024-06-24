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
    /// Homes custom view.
    private var homeView: HomeView!
    private var sortMealsBarButtonItem: UIBarButtonItem!
    public let homeViewModel: HomeViewModel = HomeViewModel()
    private var anyCancelableSet = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        homeView = HomeView()
        self.view = homeView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.mealCategoryCollectionView.delegate = self
        homeView.mealCategoryCollectionView.dataSource = self
        homeView.mealCategoryRefreshControl.addTarget(self, action: #selector(pullDownToRefreshControlAction), for: .valueChanged)
        setupNavigationBarItems()
        setupViewBindings()
        homeView.setupActivityIndicator()
        homeViewModel.retrieveDessertMeals(sortingOption: .alphabeticallyAscending)
    }
    
    
    private func setupNavigationBarItems() {
        homeView.configureNavigationBarCustomView()
        navigationItem.titleView = homeView.navigationBarCustomView
        sortMealsBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3")!.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(sortButtonAction))
        navigationItem.leftBarButtonItem = sortMealsBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle")!.withTintColor(.black, renderingMode: .alwaysOriginal))
    }
    
    
    private func setupViewBindings() {
        homeView.searchBar.textDidChangePublisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                guard let self = self else { return }
                self.homeViewModel.filterDesserts(by: searchText ?? "")
            }
            .store(in: &anyCancelableSet)
        homeViewModel.$desserts
            .receive(on: DispatchQueue.main)
            .dropFirst()
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
        homeViewModel.$searchedDesserts
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { searchedDesserts in
                self.homeView.reloadCells()
            }
            .store(in: &anyCancelableSet)
        homeViewModel.$sortingOption
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { sortingOption in
                self.homeView.stopActivityIndicatorAnimating()
                self.homeViewModel.retrieveDessertMeals(sortingOption: sortingOption)
            }
            .store(in: &anyCancelableSet)
        homeViewModel.$emptyMealSearchResults
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { noMealsFound in
                if noMealsFound {
                    self.homeView.displayMessage("No meals found!")
                } else {
                    self.homeView.removeMessage()
                }
            }
            .store(in: &anyCancelableSet)
        homeViewModel.$retrievingMealCategoriesError
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { _ in
                self.homeView.stopActivityIndicatorAnimating()
                self.homeView.stopRefreshControlAnimating()
                self.homeView.displayErrorMessage("Couldn't get meals in that category. Pull down to try again!", hidden: false)
            }
            .store(in: &anyCancelableSet)
    }
    
    
    @objc private func pullDownToRefreshControlAction() {
        homeViewModel.retrieveDessertMeals(sortingOption: homeViewModel.sortingOption)
    }
    
    
    @objc private func sortButtonAction() {
        presentMealSortPopover()
    }
    
    
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



extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10, height: 175)
    }
    
}



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



extension HomeViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
}



extension HomeViewController: MealSortingPopoverSelectionProtocol {
    
    func sortingOptionSelected(_ option: MealSortingOption) {
        homeViewModel.sortingOption = option
        homeView.setupActivityIndicator()
    }
    
}
