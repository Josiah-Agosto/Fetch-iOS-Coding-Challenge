//
//  HomeViewController.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/21/24.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - References / Properties
    /// Homes custom view.
    private var homeView: HomeView!
    
    override func loadView() {
        super.loadView()
        homeView = HomeView()
        self.view = homeView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.itemCollectionView.delegate = self
        homeView.itemCollectionView.dataSource = self
        setupNavigationBarItems()
    }
    
    
    private func setupNavigationBarItems() {
        homeView.configureNavigationBarCustomView()
        navigationItem.titleView = homeView.navigationBarCustomView
        navigationItem.leftBarButtonItem = homeView.filterBarButtonItem
        navigationItem.rightBarButtonItem = homeView.mockProfileBarButtonItem
    }

}



extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 10, height: 200)
    }
    
}



extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeItemCollectionViewCell", for: indexPath)
        return cell
    }
    
}
