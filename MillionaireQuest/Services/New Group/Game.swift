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
    let caretaker = GameCaretaker()
    
    private init() {}
    
    func startNewSession() {
        gameSession = GameSession()
    }
    
    func endSession() {
        guard let session = gameSession else { return }
        caretaker.createMemento(for: session)
        gameSession = nil
    }
}
