//
//  GameSession.swift
//  MillionaireQuest
//
//  Created by KOДИ on 04.04.2024.
//

import UIKit

class GameSession {
    var totalQuestions = questions.count
    var correctAnswer = 0
    
    func checkAnswer(at index: Int, for question: Question) -> Bool {
        let isCorrect = index == question.correctAnswer
        if isCorrect {
            correctAnswer += 1
        }
        return isCorrect
    }
    
    func calculateResult() -> Double {
        return Double(correctAnswer) / Double(totalQuestions) * 100
    }
}
