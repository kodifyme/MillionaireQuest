//
//  AddQuestionViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.05.2024.
//

import UIKit

protocol AddQuestionViewControllerDataSource: AnyObject {
    func getCountOfQuestions() -> Int
    func collectQuestions() -> [Question]?
}

class AddQuestionViewController: UIViewController {
    
    let questionKeeper = QuestionKeeper()
    private lazy var addQuestionTableView: AddQuestionTableView = {
        var view = AddQuestionTableView()
        dataSource = view
        return view
    }()
    
    weak var dataSource: AddQuestionViewControllerDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        title = "Добавить вопрос"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(addQuestionButtonTapped))
    }
    
    private func setupView() {
        view.addSubview(addQuestionTableView)
    }
    
    private func saveQuestions(_ questions: [Question]) {
        defaultQuestions.append(contentsOf: questions)
        questionKeeper.save(questions: defaultQuestions)
    }
    
    @objc private func addQuestionButtonTapped() {
        guard let newQuestions = dataSource?.collectQuestions() else { return }
        saveQuestions(newQuestions)
        AlertManager.shared.showAddedQuestionAlert(from: self, count: dataSource?.getCountOfQuestions(), message: "") {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

//MARK: - Setup Constraints
private extension AddQuestionViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            addQuestionTableView.topAnchor.constraint(equalTo: view.topAnchor),
            addQuestionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addQuestionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addQuestionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
