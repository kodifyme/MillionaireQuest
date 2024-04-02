//
//  ResultsViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 29.03.2024.
//

import UIKit

class ResultsViewController: UIViewController {
    
    private let resultsTableView = ResultsTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupResultsTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationbar()
    }
    
    private func setupNavigationbar() {
        title = "Результаты"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    private func setupResultsTableView() {
        resultsTableView.frame = view.bounds
        view.addSubview(resultsTableView)
    }
}
