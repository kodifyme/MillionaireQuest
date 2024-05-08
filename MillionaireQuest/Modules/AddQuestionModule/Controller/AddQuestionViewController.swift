//
//  AddQuestionViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.05.2024.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    let builder = QuestionBuilder()
    private let addQuestionTableView = AddQuestionTableView()
    
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
        addQuestionTableView.customDelegate = self
    }
    
    private func saveQuestion(_ question: Question) {
        questions.append(question)
        
        let caretaker = QuestionCaretaker()
        caretaker.save(questions: questions)
    }
    
    @objc private func addQuestionButtonTapped() {
        if let newQuestion = builder.build() {
            print(newQuestion)
                saveQuestion(newQuestion)
        } else {
            print("Error")
        }
    }
}

//MARK: - AddQuestionTableViewDelegate
extension AddQuestionViewController: AddQuestionTableViewDelegate {
    func receiveNewQuestion(question: String, options: [String], correctAnswerIndex: Int) {
        builder.setQuestionText(question)
            .addOptions(options[0])
            .addOptions(options[1])
            .addOptions(options[2])
            .addOptions(options[3])
            .setCorrectAnswer(correctAnswerIndex)
            
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
