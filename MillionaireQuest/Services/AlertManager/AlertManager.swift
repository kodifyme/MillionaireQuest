//
//  AlertManager.swift
//  MillionaireQuest
//
//  Created by KOДИ on 12.04.2024.
//

import UIKit

class AlertManager {
    
    static let shared = AlertManager()
    
    private init() {}
    
    func showVictoryAlert(from controller: UIViewController, score: Double, completion: @escaping () -> Void) {
        let result = String(format: "%.0f", score)
        let alertController = UIAlertController(title: "Поздравляем", message: "Вы выиграли! Ваш результат \(result)%", preferredStyle: .alert)
        let action = UIAlertAction(title: "Начать заново", style: .default) { _ in
            completion()
        }
        alertController.addAction(action)
        controller.present(alertController, animated: true)
    }
    
    func showFailureAlert(from controller: UIViewController, score: Double, completion: @escaping () -> Void) {
        let result = String(format: "%.0f", score)
        let alertController = UIAlertController(title: "Вы проиграли", message: "Вы выиграли! Ваш результат \(result)%", preferredStyle: .alert)
        let action = UIAlertAction(title: "Начать заново", style: .default) { _ in
            completion()
        }
        alertController.addAction(action)
        controller.present(alertController, animated: true)
    }
}
