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
    
    func checkAnswer(at index: Int) -> Bool {
        let isCorrect = index == currentQuestion.correctAnswer
        if isCorrect {
            score += 1
        }
        return isCorrect
    }
    
    func nextQuestion() -> Question? {
        currentQuestionIndex += 1
        if currentQuestionIndex < totalQuestions {
            return currentQuestion
        } else {
            return nil
        }
    }
    
    func calculateResult() -> Double {
        Double(score) / Double(totalQuestions) * 100
    }
}
