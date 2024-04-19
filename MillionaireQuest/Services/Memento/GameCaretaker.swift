//
//  GameCaretaker.swift
//  MillionaireQuest
//
//  Created by KOДИ on 18.04.2024.
//

import Foundation

typealias GameMemento = Data

class GameCaretaker {
    
    func saveMementos(_ mementos: [RecordsOriginator], key: String) {
        do {
            let data = try JSONEncoder().encode(mementos)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Ошибка при сохранении результатов \(error.localizedDescription)")
        }
    }
    
    func loadMementos(for key: String) -> [RecordsOriginator] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([RecordsOriginator].self, from: data)) ?? []
    }
}
