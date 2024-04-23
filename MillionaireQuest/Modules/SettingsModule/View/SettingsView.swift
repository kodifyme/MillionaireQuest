//
//  SettingsView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 23.04.2024.
//

import UIKit

class SettingsView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var questionTypeSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Последовательно", "Рандомно"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .touchUpInside)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundImageView)
        addSubview(questionTypeSegmentControl)
    }
    
    @objc private func segmentChanged() {
        
    }
}

//MARK: - Setup Constraints
private extension SettingsView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            questionTypeSegmentControl.topAnchor.constraint(equalTo: topAnchor, constant: 130),
            questionTypeSegmentControl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
