//
//  QuestionCaretaker.swift
//  MillionaireQuest
//
//  Created by KOДИ on 07.05.2024.
//

import UIKit

class QuestionCaretaker {
    
    func saveQuestions(_ questions: [Question], key: String) {
        do {
            let data = try JSONEncoder().encode(questions)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Ошибка при сохранении результатов \(error.localizedDescription)")
        }
    }
    
    func loadQuestions(for key: String) -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([Question].self, from: data)) ?? []
    }
}
