//
//  GameSession.swift
//  MillionaireQuest
//
//  Created by KOДИ on 04.04.2024.
//

import UIKit

class GameSession {
    var totalQuestions = questions.count
    var score = 0
    
    private var currentQuestionIndex = 0
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
    
    var currentQuestionNumber: Observable<Int>
    var correctAnswerPercentage: Observable<Double>
    
    init() {
        currentQuestionNumber = Observable(currentQuestionIndex + 1)
        correctAnswerPercentage = Observable(0.0)
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
        currentQuestionIndex += 1
        updateStatistic()
        if currentQuestionIndex < totalQuestions {
            return currentQuestion
        } else {
            return nil
        }
    }
    
    func calculateResult() -> Double {
        Double(score) / Double(totalQuestions) * 100
    }
    
    func updateStatistic() {
        let percentage = Double(score) / Double(totalQuestions) * 100
        correctAnswerPercentage.value = percentage
        currentQuestionNumber.value = currentQuestionIndex + 1
    }
}
