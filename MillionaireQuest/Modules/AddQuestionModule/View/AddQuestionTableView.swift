//
//  AddQuestionTableView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.05.2024.
//

import UIKit

class AddQuestionTableView: UITableView {
    
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
        register(AddQuestionCell.self, forCellReuseIdentifier: AddQuestionCell.cellIdentifier)
        dataSource = self
        delegate = self
    }
}

//MARK: - UITableViewDataSource
extension AddQuestionTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: AddQuestionCell.cellIdentifier, for: indexPath) as? AddQuestionCell else { return UITableViewCell() }
        return cell
    }
}

extension AddQuestionTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}


