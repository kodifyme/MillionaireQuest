//
//  ResultsTableView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.04.2024.
//

import UIKit

class ResultsTableView: UITableView {
    
    let identifier = "cell"
    
    var resultsTableViewDataSource = ResultsTableViewDataSource()
    
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
        register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        dataSource = resultsTableViewDataSource
    }
}
