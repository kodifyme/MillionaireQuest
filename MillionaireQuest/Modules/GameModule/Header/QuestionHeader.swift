//
//  QuestionHeader.swift
//  MillionaireQuest
//
//  Created by KOДИ on 01.04.2024.
//

import UIKit

class QuestionHeader: UICollectionReusableView {
    
    static let identifier = "QuestionHeader"
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLabelConstraints()
    }
    
    private func setupView() {
        addSubview(questionLabel)
    }
    
    func configure(with question: String) {
        questionLabel.text = question
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Constraints
private extension QuestionHeader {
    func setupLabelConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: topAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
