//
//  AlertManager.swift
//  MillionaireQuest
//
//  Created by KOДИ on 12.04.2024.
//

import UIKit

class AlertManager {
    
    enum AlertType {
        case victory
        case failure
    }
    
    static let shared = AlertManager()
    
    private init() {}
    
    func showAlert(type: AlertType, from controller: UIViewController, score: Double, restartCompletion: @escaping () -> Void, exitCompletion: @escaping () -> Void) {
        switch type {
        case .victory:
            showVictoryAlert(from: controller, score: score, restartCompletion: restartCompletion, exitCompletion: exitCompletion)
        case .failure:
            showFailureAlert(from: controller, score: score, restartCompletion: restartCompletion, exitCompletion: exitCompletion)
        }
    }
    
    private func showVictoryAlert(from controller: UIViewController, score: Double, restartCompletion: @escaping () -> Void, exitCompletion: @escaping () -> Void) {
        let result = String(format: "%.0f", score)
        let alertController = UIAlertController(title: "Поздравляем", message: "Вы выиграли! Ваш результат \(result)%", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Начать заново", style: .default) { _ in
            restartCompletion()
        }
        
        let exitAction = UIAlertAction(title: "Выход", style: .cancel) { _ in
            exitCompletion()
        }
        alertController.addAction(restartAction)
        alertController.addAction(exitAction)
        controller.present(alertController, animated: true)
    }
    
    private func showFailureAlert(from controller: UIViewController, score: Double, restartCompletion: @escaping () -> Void, exitCompletion: @escaping () -> Void) {
        let result = String(format: "%.0f", score)
        let alertController = UIAlertController(title: "Вы проиграли", message: "Вы выиграли! Ваш результат \(result)%", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Начать заново", style: .default) { _ in
            restartCompletion()
        }
        
        let exitAction = UIAlertAction(title: "Выход", style: .cancel) { _ in
            exitCompletion()
        }
        alertController.addAction(restartAction)
        alertController.addAction(exitAction)
        controller.present(alertController, animated: true)
    }
}
