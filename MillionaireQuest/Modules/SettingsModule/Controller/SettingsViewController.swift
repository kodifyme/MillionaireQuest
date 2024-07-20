//
//  SettingsViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 23.04.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let settingsView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        title = "Настройки"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupView() {
        view.addSubview(settingsView)
    }
}

//MARK: - Setup Constraints
private extension SettingsViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
