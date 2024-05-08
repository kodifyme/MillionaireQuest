//
//  AddQuestionTableView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.05.2024.
//

import UIKit

protocol AddQuestionTableViewDelegate: AnyObject {
    func receiveNewQuestion(question: String, options: [String], correctAnswerIndex: Int)
}

class AddQuestionTableView: UITableView {
    
    weak var customDelegate: AddQuestionTableViewDelegate?
    
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
    
    //MARK: - Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: AddQuestionCell.cellIdentifier, for: indexPath) as? AddQuestionCell else { return UITableViewCell() }
        cell.delegate = self.inputViewController as? AddQuestionCellDelegate
        return cell
    }
    
    //MARK: - Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = TableFooterView()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        50
    }
}

extension AddQuestionTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    }
}

extension AddQuestionTableView: AddQuestionCellDelegate {
    func getQuestionData(question: String, options: [String], currentAnswer: Int) {
        customDelegate?.receiveNewQuestion(question: question, options: options, correctAnswerIndex: currentAnswer)
    }
}
