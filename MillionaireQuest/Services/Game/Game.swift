//
//  Game.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.04.2024.
//

import UIKit

class Game {
    
    enum QuestionsMode {
        case sequential, random
    }
    
    static let shared = Game()
    private(set) var gameSession: GameSession?
    
    let recordsKeeper = RecordsKeeper()
    private(set) var records = [RecordsOriginator]()
    
    var questionsMode: QuestionsMode = .sequential
    
    private init() {
        records = recordsKeeper.load()
    }
    
    func startNewSession(_ session: GameSession) {
        gameSession = session
    }
    
    func endSession() {
        guard let session = gameSession else { return }
        let record = RecordsOriginator(scoredPercentage: session.calculateResult())
        records.append(record)
        recordsKeeper.save(records)
        gameSession = nil
    }
}
