//
//  GameViewController.swift
//  MillionaireQuest
//
//  Created by KOДИ on 29.03.2024.
//

import UIKit

// 1. move some states(calculations) to Session – check?
// 4. GameSession(mode: game.questionsMode) duplicating issue — fix – optional

// 2. Setttings: select choosed mode, UserDefaults – optional
// 3. Do not access HintUsageFacade directly – make Protocol for access to GameSession
// w5: custom cell with 5 fields and control

protocol GameViewControllerDelegate: AnyObject {
    func colorAfter(isCorrect: Bool)
    func refreshWithQuestion(question: Question)
    func setQuestionNumber(_ value: Int)
    func setCorrectPercentage(_ value: Double)
}

class GameViewController: UIViewController {
    
    private var game = Game.shared
    weak var delegate: GameViewControllerDelegate?
    
    private lazy var gameSession: GameSession = {
        GameSession(mode: game.questionsMode)
    }()
    
    private lazy var gameView: GameView = {
        GameView(question: gameSession.currentQuestion)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        startNewSession()
        setAppearance()
        setupView()
        setupConstraints()
    }
    
    private func setAppearance() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupView() {
        view.addSubview(gameView)
    }
    
    private func setDelegates() {
        gameView.delegate = self
        delegate = gameView
    }
    
    private func startNewSession() {
        gameSession = GameSession(mode: game.questionsMode)
        game.startNewSession(gameSession)
        setupObservers()
    }
}

//MARK: - GameViewDelegate
extension GameViewController: GameViewDelegate {
    
    func didUseFriendCall() {
        AlertManager.shared.showCallFriendAlert(from: self, message: gameSession.callFriend())
    }
    
    func didUseAudienceHelp() {
        print(gameSession.useAuditoryHelp())
    }
    
    func didUseFiftyFifty() {
        print(gameSession.use50to50Hint())
    }
    
    func didFinishGame(type: AlertManager.AlertType) {
        let score = gameSession.calculateResult()
        game.endSession()
        AlertManager.shared.showAlert(type: type, from: self, score: score) {
            self.startNewSession()
            self.delegate?.refreshWithQuestion(question: self.gameSession.currentQuestion)
        } exitCompletion: {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func didChooseAnswer(at index: Int) {
        let isCorrect = gameSession.checkAnswer(at: index)
        delegate?.colorAfter(isCorrect: isCorrect)
        
        if isCorrect {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self,
                      let nextQuestion = gameSession.nextQuestion() else {
                    
                    self?.didFinishGame(type: .victory)
                    print("Вы прошли игру")
                    return
                }
                self.delegate?.refreshWithQuestion(question: nextQuestion)
            }
        } else {
            didFinishGame(type: .failure)
        }
    }
    
    func setupObservers() {
        gameSession.currentQuestionNumber.bind { [weak self] number in
            self?.delegate?.setQuestionNumber(number)
        }
        
        gameSession.correctAnswerPercentage.bind { [weak self] number in
            self?.delegate?.setCorrectPercentage(number)
        }
    }
}

//MARK: - Setup Constraints
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
