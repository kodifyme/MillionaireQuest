//
//  GameViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 29.03.2024.
//

import UIKit

// hayk: continue from here

// check Results MVC
// *
// GameController-GameSession roles -> move calculations to GameSession?

protocol GameViewControllerDelegate: AnyObject {
    func colorAfter(isCorrect: Bool)
    func refreshWithQuestion(question: Question)
}

class GameViewController: UIViewController {
    
    private var game = Game.shared
    weak var delegate: GameViewControllerDelegate?
    
    private lazy var gameView: GameView = {
        GameView(question: currentQuestion)
    }()
    private var currentQuestionIndex = 0
    
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.startNewSession()
        setAppearance()
        setupView()
        setDelegates()
        setupConstraints()
    }
    
    private func setAppearance() {
        view.backgroundColor = .white
    }
    
    private func setupView() {
        view.addSubview(gameView)
    }
    
    private func setDelegates() {
        gameView.delegate = self
        delegate = gameView
    }
}

//MARK: - GameViewDelegate
extension GameViewController: GameViewDelegate {
    func gameViewDidUseFriendCall() {
    
    }
    
    func gameViewDidUseAudienceHelp() {
        
    }
    
    func gameViewDidUseFiftyFifty() {
        
    }
    
    func didFinishGame() {
        game.endSession()
        let score = game.gameSession?.calculateResult()
        AlertManager.shared.showVictoryAlert(from: self, score: score!) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func didChooseAnswer(at index: Int) {
        let isCorrect = index == currentQuestion.correctAnswer
        delegate?.colorAfter(isCorrect: isCorrect)
        
        if isCorrect {
            game.gameSession?.correctAnswer += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return }
                currentQuestionIndex += 1
                
                if currentQuestionIndex < questions.count {
                    delegate?.refreshWithQuestion(question: currentQuestion)
                } else {
                    didFinishGame()
                    print("Вы прошли игру")
                }
            }
        } else {
            game.endSession()
            let score = game.gameSession?.calculateResult()
            AlertManager.shared.showFailureAlert(from: self, score: score!) {
                self.navigationController?.popToRootViewController(animated: true)
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
