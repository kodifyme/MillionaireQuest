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
    
    func showCallFriendAlert(from controller: UIViewController, message: String) {
        let alertController = UIAlertController(title: "Ответ друга", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true)
    }
    
    func showAddedQuestionAlert(from controller: UIViewController, count: Int?, message: String, exitCompletion: @escaping () -> Void) {
        guard let count else { return }
        let alertController = UIAlertController(title: "Вопросов добавлено: \(count)", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
            exitCompletion()
        }
        alertController.addAction(okAction)
        controller.present(alertController, animated: true)
    }
}
