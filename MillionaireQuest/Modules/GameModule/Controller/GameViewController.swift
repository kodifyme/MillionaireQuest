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
        let alertController = UIAlertController(title: "Вы победили", message: "Ваш результат верных ответов \(String(format: "%.0f", game.mementos.last!.scoredPercentage))%", preferredStyle: .alert)
        let returnActiron = UIAlertAction(title: "Начать заново", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(returnActiron)
        present(alertController, animated: true)
    }
    
    func didChooseAnswer(at index: Int) {
        let correctAnswerIndex = currentQuestion.correctAnswer
        
        let isCorrect = index == correctAnswerIndex
        delegate?.colorAfter(isCorrect: isCorrect)
        
        if isCorrect {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //weak self
                self.currentQuestionIndex += 1
                if self.currentQuestionIndex < questions.count {
                    self.delegate?.refreshWithQuestion(question: self.currentQuestion)
                } else {
                    self.didFinishGame()
                    print("Вы прошли игру")
                }
            }
        }
       
        if !isCorrect {
            game.endSession()
            let alertController = UIAlertController(title: "Вы проиграли", message: "Ваш результат верных ответов \(String(format: "%.0f", game.mementos.last!.scoredPercentage))%", preferredStyle: .alert)
            let returnActiron = UIAlertAction(title: "Начать заново", style: .default) { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alertController.addAction(returnActiron)
            present(alertController, animated: true)
        } else {
            if let session = game.gameSession {
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
