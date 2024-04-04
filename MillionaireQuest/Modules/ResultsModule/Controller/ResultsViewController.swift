//
//  ResultsViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 29.03.2024.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var gameManager = Game.shared
    
    private let resultsTableView = ResultsTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationbar()
        setupResultsTableView()
    }
    
    private func setupNavigationbar() {
        title = "Результаты"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupResultsTableView() {
        resultsTableView.frame = view.bounds
        resultsTableView.resultsTableViewDataSource = self
        view.addSubview(resultsTableView)
    }
}

//MARK: - ResultsTableViewDataSource
extension ResultsViewController: ResultsTableViewDataSource {
    func item(at indexPath: IndexPath) -> Double {
        gameManager.gameResult[indexPath.row]
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        gameManager.gameResult.count
    }
}
