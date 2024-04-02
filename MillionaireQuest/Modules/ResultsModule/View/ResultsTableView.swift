//
//  ResultsTableView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.04.2024.
//

import UIKit

class ResultsTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .insetGrouped)
        
        setupTableView()
    }
    
    private func setupTableView() {
        backgroundView = BackgroundView()
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableViewDataSource
extension ResultsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Game.shared.gameResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row < Game.shared.gameResult.count {
            let result = Game.shared.gameResult[indexPath.row]
            cell.textLabel?.text = String(format: "Результат: %.0f%%", result)
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ResultsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

