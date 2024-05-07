//
//  HintUsageFacade.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.05.2024.
//

import UIKit

class HintUsageFacade {
    
    var currentQuestion: Question?
    var friendCallUsed = false
    var audienceHelpUsed = false
    var fiftyFiftyUsed = false
    
    func callFriend() -> String {
        friendCallUsed = true
        guard let correctAnswerIndex = currentQuestion?.correctAnswer else { return "" }
        return "Друг думает, что правильный ответ: \(currentQuestion?.options[correctAnswerIndex] ?? "неизвестно")"
    }
    
    func useAuditoryHelp() -> [Int] {
        audienceHelpUsed = true
        guard let options = currentQuestion?.options,
              let correctAnswerIndex = currentQuestion?.correctAnswer else {
            return []
        }
        var votePercentages = [Int]()
        
        for (index, _) in options.enumerated() {
            index == correctAnswerIndex ? votePercentages.append(70) : votePercentages.append(10)
        }
        return votePercentages
    }
    
    func use50to50Hint() -> [String] {
        fiftyFiftyUsed = true
        guard let correctAnswerIndex = currentQuestion?.correctAnswer,
              var options = currentQuestion?.options else { return [] }
        
        var hints = [String]()
        hints.append(options[correctAnswerIndex])
        
        options.remove(at: correctAnswerIndex)
        hints.append(options.randomElement()!)
        return hints
    }
    
    func resetHints() {
        friendCallUsed = false
        audienceHelpUsed = false
        fiftyFiftyUsed = false
    }
}
