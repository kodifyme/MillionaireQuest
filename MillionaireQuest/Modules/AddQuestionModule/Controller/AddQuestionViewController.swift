//
//  AddQuestionViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.05.2024.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    private let addQuestionTableView = AddQuestionTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        title = "Добавьте свой вопрос"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupView() {
        view.addSubview(addQuestionTableView)
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
