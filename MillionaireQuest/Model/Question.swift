//
//  Question.swift
//  MillionaireQuest
//
//  Created by KOДИ on 15.03.2024.
//

import UIKit

struct Question {
    let question: String
    let options: [String]
    let correctAnswer: Int
//    var friendCall: String?
//    var votePercentage: [Int: Int]?
}

let questions: [Question] = [
    Question(question: "Какой праздник отмечается в мире 1 сентября?", 
             options: ["День Святого Валентина", "Всемирный День мира", "Новый Год", "День борьбы со СПИДом"],
             correctAnswer: 1),
    Question(question: "Что обозначает красный сигнал светофора?",
             options: ["Идите", "Обгон разрешен", "Расслабьтесь", "Стойте и ждите"],
             correctAnswer: 3),
    Question(question: "Какой город является столицей Таиланда?",
             options: ["Бангкок", "Паттайя", "Манила", "Пхукет"],
             correctAnswer: 0),
    Question(question: "Из какого сырья делают большинство пакетов?",
             options: ["Пластик", "Резина", "Нефть", "Бумага"],
             correctAnswer: 2),
    Question(question: "В какой стране мира самая высокая плотность населения?",
             options: ["США", "Индия", "Тайвань", "Народная Республика Китай"],
             correctAnswer: 3)
]
