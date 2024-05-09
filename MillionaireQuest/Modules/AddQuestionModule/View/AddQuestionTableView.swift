//
//  AddQuestionTableView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.05.2024.
//

import UIKit

class AddQuestionTableView: UITableView {
    
    private var cells: [AddQuestionCell] = []
    
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
        register(AddQuestionCell.self, forCellReuseIdentifier: AddQuestionCell.cellIdentifier)
        dataSource = self
        delegate = self
    }
    
    func addNewCell() {
        let newCell = AddQuestionCell()
        cells.append(newCell)
        reloadData()
    }
    
    func collectQuestion() -> [Question] {
        var newQuestions = [Question]()
        
        for cell in cells {
            if let question = cell.configure() {
                newQuestions.append(question)
            }
        }
        return newQuestions
    }
}

//MARK: - UITableViewDataSource
extension AddQuestionTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    //MARK: - Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cells[indexPath.row]
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
extension AddQuestionTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    }
}

//MARK: - AddQuestionViewControllerDataSource
extension AddQuestionTableView: AddQuestionViewControllerDataSource {
    func getCountOfQuestions() -> Int {
        cells.count
    }
    
    func collectQuestions() -> [Question] {
        collectQuestion()
    }
}

//MARK: - TableFooterViewDelegate
extension AddQuestionTableView: TableFooterViewDelegate {
    func didTapAddForm() {
        addNewCell()
    }
}
