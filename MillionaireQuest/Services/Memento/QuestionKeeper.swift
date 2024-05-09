//
//  QuestionKeeper.swift
//  MillionaireQuest
//
//  Created by KOДИ on 09.05.2024.
//

import Foundation

class QuestionKeeper {
    private let caretaker = QuestionCaretaker()
    private let key = String(describing: QuestionKeeper.self)
    
    func save(questions: [Question]) {
        caretaker.saveQuestions(questions, key: key)
    }
    
    func load() -> [Question] {
        caretaker.loadQuestions(for: key)
    }
}
