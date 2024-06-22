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
        setupNavigationBarTitle()
    }
    
    private func setupNavigationBarTitle() {
        homeView.configureNavigationBarCustomView()
        navigationItem.titleView = homeView.navigationBarCustomView
    }

}

