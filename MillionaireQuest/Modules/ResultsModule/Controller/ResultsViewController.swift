//
//  ResultsViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 29.03.2024.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var gameCaretaker = GameCaretaker()
    
    private let resultsTableView = ResultsTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationbar()
        setupResultsTableView()
        setupConstraints()
        gameCaretaker.loadMementos()
    }
    
    private func setupNavigationbar() {
        title = "Результаты"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupResultsTableView() {
        view.addSubview(resultsTableView)
        resultsTableView.resultsTableViewDataSource.results = gameCaretaker.mementos
    }
}

private extension ResultsViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            resultsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
