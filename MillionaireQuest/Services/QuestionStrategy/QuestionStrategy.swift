//
//  QuestionStrategy.swift
//  MillionaireQuest
//
//  Created by KOДИ on 03.05.2024.
//

import Foundation

protocol QuestionStrategy: AnyObject {
    func getQuestions(_ questions: [Question]) -> [Question]
}

class SequentialQuestions: QuestionStrategy {
    func getQuestions(_ questions: [Question]) -> [Question] {
        questions
    }
}

class RandomQuestions: QuestionStrategy {
    func getQuestions(_ questions: [Question]) -> [Question] {
        questions.shuffled()
    }
}
