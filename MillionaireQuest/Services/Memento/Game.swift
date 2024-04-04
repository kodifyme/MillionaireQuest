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
    var mementos: [GameMemento] = []
    
    private var memntosKey: String { "gameMementos" }
    
    private init() {}
    
    func startNewSession() {
        gameSession = GameSession()
    }
    
    func endSession() {
        guard let session = gameSession else { return }
        let memento = session.createMemento()
        mementos.append(memento)
        saveMementos()
    }
    
    private func saveMementos() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(mementos)
            UserDefaults.standard.set(data, forKey: memntosKey)
        } catch {
            print("Error save results \(error.localizedDescription)")
        }
    }
    
    func loadMementos() {
        guard let data = UserDefaults.standard.data(forKey: memntosKey),
              let savedMementos = try? JSONDecoder().decode([GameMemento].self, from: data) else { return }
                mementos = savedMementos
    }
}
