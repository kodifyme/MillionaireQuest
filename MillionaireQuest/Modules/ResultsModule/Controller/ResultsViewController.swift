//
//  ResultsViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 29.03.2024.
//

import UIKit

protocol ResultsViewControllerDelegate: AnyObject {
    func setResults(_ results: [RecordsOriginator])
}

class ResultsViewController: UIViewController {
    
    let recordsKeeper = Keeper<RecordsOriginator>()
    
    private lazy var resultsTableView: ResultsTableView = {
        var view = ResultsTableView()
        delegate = view
        return view
    }()
    
    weak var delegate: ResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationbar()
        setupResultsTableView()
        setupConstraints()
    }
    
    private func setupNavigationbar() {
        title = "Результаты"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupResultsTableView() {
        view.addSubview(resultsTableView)
        delegate?.setResults(recordsKeeper.load())
    }
}

//MARK: - Setup Constraints
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
