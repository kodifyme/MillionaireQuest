//
//  GameOriginator.swift
//  MillionaireQuest
//
//  Created by KOДИ on 04.04.2024.
//

import UIKit

class GameSession {
    var totalQuestions = questions.count
    var correctAnswer = 0
    
    func createMemento() -> GameMemento {
        GameMemento(scoredPercentage: calculateResult())
    }
    
    func calculateResult() -> Double {
        return Double(correctAnswer) / Double(totalQuestions) * 100
    }
}
