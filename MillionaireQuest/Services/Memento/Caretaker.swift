//
//  Caretaker.swift
//  MillionaireQuest
//
//  Created by KOДИ on 10.05.2024.
//

import UIKit

class Caretaker<T: Codable> {
    
    func save(_ items: [T], key: String) {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Ошибка при сохранении результатов \(error.localizedDescription)")
        }
    }
    
    func loadMementos(for key: String) -> [T] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([T].self, from: data)) ?? []
    }
}
