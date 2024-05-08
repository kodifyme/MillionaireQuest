//
//  QuestionCaretaker.swift
//  MillionaireQuest
//
//  Created by KOДИ on 07.05.2024.
//

import UIKit

class QuestionCaretaker {
    private let key = "savedQuestions"
    
    func save(questions: [Question]) {
        do {
            let data = try JSONEncoder().encode(questions)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Ошибка при сохранении результатов \(error.localizedDescription)")
        }
    }
    
    func load() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([Question].self, from: data)) ?? []
    }
}
