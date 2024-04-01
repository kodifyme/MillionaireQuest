//
//  GameViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 29.03.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    private let gameView = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppearance()
        setupView()
        setupConstraints()
    }
    
    private func setAppearance() {
        view.backgroundColor = .white
    }
    
    private func setupView() {
        view.addSubview(gameView)
    }
}

//MARK: - Constraints
private extension GameViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
