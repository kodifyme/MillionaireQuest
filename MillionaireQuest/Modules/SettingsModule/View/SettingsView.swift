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
    
    private let questionTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Порядок вопросов"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 19)
        return label
    }()
    
    lazy var questionTypeSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Последовательно", "Рандомно"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentControl.backgroundColor = .white
        segmentControl.selectedSegmentTintColor = .systemGreen
        return segmentControl
    }()
    
    private lazy var questionTypeStackView: UIStackView = {
        UIStackView(arrangedSubviews: [questionTypeLabel, questionTypeSegmentControl], axis: .vertical, spacing: 20)
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
        addSubview(questionTypeStackView)
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
            
            questionTypeStackView.topAnchor.constraint(equalTo: topAnchor, constant: 130),
            questionTypeStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
