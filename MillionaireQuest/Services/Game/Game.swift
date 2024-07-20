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
    
    let recordsKeeper = Keeper<RecordsOriginator>()
    private(set) var records = [RecordsOriginator]()
    
    let questionsKeeper = Keeper<Question>()
    var questionsMode: QuestionsMode = .sequential
    
    private init() {
        if questionsKeeper.load().isEmpty {
            questionsKeeper.save(defaultQuestions)
        }
        records = recordsKeeper.load()
        defaultQuestions = questionsKeeper.load()
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
