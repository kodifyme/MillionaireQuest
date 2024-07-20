//
//  MenuView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 15.03.2024.
//

import UIKit

protocol MenuViewDelegate: AnyObject {
    func handlePlayButton()
    func handleResultsButton()
    func handleSettingsButton()
    func handleAddQuestionButton()
}

class MenuView: UIView {
    
    weak var delegate: MenuViewDelegate?
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Играть", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handlePlayButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var resultsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Результаты", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleResultsButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Настройки", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleSettingsButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var addQuestionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить вопрос", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleAddQuestionButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        UIStackView(arrangedSubviews: [playButton, resultsButton, settingsButton, addQuestionButton], axis: .vertical, spacing: 20)
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
        addSubview(buttonStackView)
    }
    
    @objc private func handlePlayButtonTap() {
        delegate?.handlePlayButton()
    }
    
    @objc private func handleResultsButtonTap() {
        delegate?.handleResultsButton()
    }
    
    @objc private func handleSettingsButtonTap() {
        delegate?.handleSettingsButton()
    }
    
    @objc private func handleAddQuestionButtonTap() {
        delegate?.handleAddQuestionButton()
    }
}

//MARK: - Setup Constraints
private extension MenuView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        ])
    }
}
