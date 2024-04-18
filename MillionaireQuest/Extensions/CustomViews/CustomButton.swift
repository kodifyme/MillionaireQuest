//
//  CustomButton.swift
//  MillionaireQuest
//
//  Created by KOДИ on 04.04.2024.
//

import UIKit

class CustomButton: UIButton {
    
    static func createButton(title: String, type: UIButton.ButtonType, target: Any?, action: Selector) -> CustomButton {
        let button: CustomButton = CustomButton(type: type)
        button.setTitle(title, for: .normal)
        button.setupButton()
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        layer.cornerRadius = 10
    }
}
