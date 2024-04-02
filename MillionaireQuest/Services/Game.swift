//
//  Game.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.04.2024.
//

import UIKit

class Game {
    static let shared = Game()
    private(set) var gameSession: GameSession?
    var gameResult: [Double] = []
    
    private init() {}
    
    func startNewSession() {
        gameSession = GameSession()
    }
    
    func endSession() {
        guard let result = gameSession?.calculateResult() else { return }
        gameResult.append(result)
        gameSession = nil
    }
}

class GameSession {
    var totalQuestions = questions.count
    var correctAnswer = 0
    
    func calculateResult() -> Double {
        return Double(correctAnswer) / Double(totalQuestions) * 100
    }
}
