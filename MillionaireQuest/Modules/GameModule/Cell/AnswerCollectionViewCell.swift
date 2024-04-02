//
//  AnswerCollectionViewCell.swift
//  MillionaireQuest
//
//  Created by KOДИ on 01.04.2024.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {
    
    static let cellIndetifier = "AnswerCollectionViewCell"
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupCellConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundColor = .systemGray5
    }
    
    private func setupCell() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        contentView.addSubview(answerLabel)
    }
    
    func configure(with answer: String) {
        answerLabel.text = answer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Constraints
private extension AnswerCollectionViewCell {
    func setupCellConstraints() {
        NSLayoutConstraint.activate([
            answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            answerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
