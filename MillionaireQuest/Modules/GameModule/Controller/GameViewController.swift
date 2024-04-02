//
//  GameViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 29.03.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    private var gameSession = Game.shared
    private let gameView = GameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameSession.startNewSession()
        setAppearance()
        setupView()
        setupConstraints()
    }
    
    private func setAppearance() {
        view.backgroundColor = .white
    }
    
    private func setupView() {
        view.addSubview(gameView)
        gameView.delegate = self
    }
}

extension GameViewController: GameViewDelegate {
    func didFinishGame() {
        gameSession.endSession()
        let alertController = UIAlertController(title: "Вы победили", message: "Ваш результат верных ответов \(gameSession.gameResult.last!)%", preferredStyle: .alert)
        let returnActiron = UIAlertAction(title: "Начать заново", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(returnActiron)
        present(alertController, animated: true)
        print(gameSession.gameResult)
    }
    
    func didChooseAnswer(correct: Bool, at index: Int) {
        if !correct {
            gameSession.endSession()
            let alertController = UIAlertController(title: "Вы проиграли", message: "Ваш результат верных ответов \(gameSession.gameResult.last!)%", preferredStyle: .alert)
            let returnActiron = UIAlertAction(title: "Начать заново", style: .default) { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alertController.addAction(returnActiron)
            present(alertController, animated: true)
            print(gameSession.gameResult)
        } else {
            if let session = gameSession.gameSession {
                session.correctAnswer += 1
            }
        }
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
