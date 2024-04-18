//
//  GameCaretaker.swift
//  MillionaireQuest
//
//  Created by KOДИ on 18.04.2024.
//

import Foundation

class GameCaretaker {
    private(set) var mementos: [GameMemento] = []
    private var mementosKey: String { "gameMementos" }
    
    init() {
        loadMementos()
    }
    
    func createMemento(for session: GameSession) {
        let memento = GameMemento(scoredPercentage: session.calculateResult())
        saveMemento(memento)
    }
    
    private func saveMemento(_ memento: GameMemento) {
        mementos.append(memento)
        saveMementos()
    }
    
    private func saveMementos() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(mementos)
            UserDefaults.standard.set(data, forKey: mementosKey)
        } catch {
            print("Ошибка при сохранении результатов \(error.localizedDescription)")
        }
    }
    
    func loadMementos() {
        guard let data = UserDefaults.standard.data(forKey: mementosKey),
              let savedMementos = try? JSONDecoder().decode([GameMemento].self, from: data) else { return }
        mementos = savedMementos
    }
}
