//
//  ResultsTableView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.04.2024.
//

import UIKit

protocol ResultsTableViewDataSource: AnyObject {
    func numberOfItems(inSection section: Int) -> Int
    func item(at indexPath: IndexPath) -> GameMemento
}

class ResultsTableView: UITableView {
    
    let indetifier = "cell"
    
    weak var resultsTableViewDataSource: ResultsTableViewDataSource?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .insetGrouped)
        
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView = BackgroundView()
        register(UITableViewCell.self, forCellReuseIdentifier: indetifier)
        dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension ResultsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultsTableViewDataSource?.numberOfItems(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indetifier, for: indexPath)
        guard let dataSource = resultsTableViewDataSource else { return cell }
        let memento = dataSource.item(at: indexPath)
        cell.textLabel?.text = "Результат: \(memento.scoredPercentage)%"
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - ResultsViewControllerDelegate
extension ResultsTableView: ResultsViewControllerDelegate {
    func reloadTable() {
        reloadData()
    }
}
