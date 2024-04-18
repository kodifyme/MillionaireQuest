//
//  ResultsViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 29.03.2024.
//

import UIKit

protocol ResultsViewControllerDelegate: AnyObject {
    func reloadTable()
}

class ResultsViewController: UIViewController {
    
    var gameCaretaker = GameCaretaker()
    
    private let resultsTableView = ResultsTableView()
    weak var delegate: ResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationbar()
        setupResultsTableView()
        setupConstraints()
        setDelegates()
        gameCaretaker.loadMementos()
        delegate?.reloadTable()   // MVC
    }
    
    private func setupNavigationbar() {
        title = "Результаты"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupResultsTableView() {
        /*resultsTableView.resultsTableViewDataSource = self*/  //View role
        view.addSubview(resultsTableView)
    }
    
    private func setDelegates() {
        resultsTableView.resultsTableViewDataSource = self
        delegate = resultsTableView
    }
}

//MARK: - ResultsTableViewDataSource
extension ResultsViewController: ResultsTableViewDataSource { //View role
    
    // controller connects gamemanager ->
    // view gives mementos (not gamemanager) ->
    // while initing or via viewdelegate methods
    
    
    func item(at indexPath: IndexPath) -> GameMemento {
        gameCaretaker.mementos[indexPath.row]
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        gameCaretaker.mementos.count
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
