//
//  QuestionBuilder.swift
//  MillionaireQuest
//
//  Created by KOДИ on 07.05.2024.
//

import UIKit

class QuestionBuilder {
    private var question: String?
    private var options: [String] = []
    private var correctAnswer: Int?
    
    func setQuestionText(_ text: String) -> QuestionBuilder {
        question = text
        return self
    }
    
    func addOptions(_ answer: String) -> QuestionBuilder {
        options.append(answer)
        return self
    }
    
    func setCorrectAnswer(_ index: Int) -> QuestionBuilder {
        correctAnswer = index
        return self
    }
    
    func build() -> Question? {
        guard let question = question,
              let correctAnswer = correctAnswer,
              options.count == 4 else {
            return nil
        }
        return Question(question: question, options: options, correctAnswer: correctAnswer)
    }
}
