//
//  QuestionFormTableView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.05.2024.
//

import UIKit

class QuestionFormTableView: UITableView {
    
    private var questionsCount = 0
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .insetGrouped)
        
        setupTableView()
        addNewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView = BackgroundView()
        register(QuestionFormCell.self, forCellReuseIdentifier: QuestionFormCell.cellIdentifier)
        dataSource = self
        delegate = self
    }
    
    func addNewCell() {
        questionsCount += 1
        reloadData()
    }
    
    func collectQuestion() -> [Question]? {
        var newQuestions = [Question]()
        
        for i in 0..<questionsCount {
            guard let cell = cellForRow(at: IndexPath(row: i, section: 0)) as? QuestionFormCell else { continue }
            if let question = cell.generateQuestion() {
                newQuestions.append(question)
            }
        }
        return newQuestions
    }
}

//MARK: - UITableViewDataSource
extension QuestionFormTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questionsCount
    }
    
    //MARK: - Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionFormCell.cellIdentifier, for: indexPath) as? QuestionFormCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: - Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = TableFooterView()
        footerView.delegate = self
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        50
    }
}

//MARK: - UITableViewDelegate
extension QuestionFormTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    }
}

//MARK: - QuestionFormViewControllerDataSource
extension QuestionFormTableView: QuestionFormViewControllerDataSource {
    func getCountOfQuestions() -> Int {
        questionsCount
    }
    
    func collectQuestions() -> [Question]? {
        collectQuestion()
    }
}

//MARK: - TableFooterViewDelegate
extension QuestionFormTableView: TableFooterViewDelegate {
    func didTapAddForm() {
        addNewCell()
    }
}
