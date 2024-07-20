//
//  ResultsTableViewDataSource.swift
//  MillionaireQuest
//
//  Created by KOДИ on 18.04.2024.
//

import UIKit

class ResultsTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let identifier: String
    var results = [RecordsOriginator]()
    
    init(identifier: String) {
        self.identifier = identifier
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.textLabel?.text = "Результат: \(results[indexPath.row].scoredPercentage.rounded())%"
        cell.selectionStyle = .none
        return cell
    }
}
