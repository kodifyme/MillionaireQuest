//
//  GameSession.swift
//  MillionaireQuest
//
//  Created by KOДИ on 04.04.2024.
//

import UIKit

protocol HintProvider {
    func callFriend() -> String
    func useAuditoryHelp() -> [Int]
    func use50to50Hint() -> [String]
}

class GameSession {
    
    private lazy var sessionQuestions: [Question] = {
        strategy.getQuestions(defaultQuestions)
    }()
    private lazy var totalQuestions = sessionQuestions.count
    private var score = 0
    
    private var currentQuestionIndex = 0
    var currentQuestion: Question {
        sessionQuestions[currentQuestionIndex]
    }
    
    private var strategy: QuestionStrategy
    
    var hintUsageFacade = HintUsageFacade()
    
    var currentQuestionNumber: Observable<Int>
    var correctAnswerPercentage: Observable<Double>
    
    init(mode: Game.QuestionsMode) {
        
        switch mode {
        case .sequential:
            strategy = SequentialQuestions()
        case .random:
            strategy = RandomQuestions()
        }
        
        currentQuestionNumber = Observable(currentQuestionIndex + 1)
        correctAnswerPercentage = Observable(0.0)
        updateHints()
    }
    
    func checkAnswer(at index: Int) -> Bool {
        let isCorrect = index == currentQuestion.correctAnswer
        if isCorrect {
            score += 1
        }
        updateStatistic()
        return isCorrect
    }
    
    func nextQuestion() -> Question? {
        if currentQuestionIndex + 1 < totalQuestions {
            currentQuestionIndex += 1
            updateStatistic()
            updateHints()
            return currentQuestion
        } else {
            return nil
        }
    }
    
    func calculateResult() -> Double {
        Double(score) / Double(totalQuestions) * 100
    }
    
    func updateStatistic() {
        correctAnswerPercentage.value = calculateResult()
        currentQuestionNumber.value = currentQuestionIndex + 1
    }
    
    func updateHints() {
        hintUsageFacade.currentQuestion = currentQuestion
    }
}

//MARK: - HintProvider
extension GameSession: HintProvider {
    func callFriend() -> String {
        hintUsageFacade.callFriend()
    }
    
    func useAuditoryHelp() -> [Int] {
        hintUsageFacade.useAuditoryHelp()
    }
    
    func use50to50Hint() -> [String] {
        hintUsageFacade.use50to50Hint()
    }
}
