//
//  GameViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 29.03.2024.
//

import UIKit

// hayk: continue from here

// 1. Memento — split files/roles — memento+orifginator, split game/session
// 2. GameController-GameSe7ssion roles -> move calculations to GameSess8ion?
// connect with Game only bu funcs if possible
// dont change game/session directly from controller
// dont connect with session from controller

// 3. Results - Controller/View refactoring (MVC)
// 4. Do ClosurePlayground
// ux — change alert message or action
// *

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
        navigationItem.hidesBackButton = true
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
    
    func didFinishGame(type: AlertManager.AlertType) {
        game.endSession()
        guard let score = game.gameSession?.calculateResult() else { return }
        AlertManager.shared.showAlert(type: type, from: self, score: score) {
            self.currentQuestionIndex = 0
            self.game.startNewSession()
            self.delegate?.refreshWithQuestion(question: self.currentQuestion)
            
        } exitCompletion: {
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
                    didFinishGame(type: .victory)
                    print("Вы прошли игру")
                }
            }
        } else {
            didFinishGame(type: .failure)
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
