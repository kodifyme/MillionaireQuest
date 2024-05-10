//
//  MenuViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 13.03.2024.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let menuView = MenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationbar()
        setupView()
        setupConstraints()
    }
    
    private func setupNavigationbar() {
        title = "Меню"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupView() {
        menuView.delegate = self
        view.addSubview(menuView)
    }
}

extension MenuViewController: MenuViewDelegate {
    func handlePlayButton() {
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
    func handleResultsButton() {
        navigationController?.pushViewController(ResultsViewController(), animated: true)
    }
    
    func handleSettingsButton() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    func handleAddQuestionButton() {
        navigationController?.pushViewController(QuestionFormViewController(), animated: true)
    }
}

//MARK: - Setup Constraints
private extension MenuViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: view.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
