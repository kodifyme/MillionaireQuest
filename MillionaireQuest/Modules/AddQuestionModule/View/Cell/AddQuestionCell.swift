//
//  AddQuestionCell.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.05.2024.
//

import UIKit

class AddQuestionCell: UITableViewCell {
    
    static let cellIdentifier = "AddQuestionCell"
    
    private let questionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Введите новый вопрос"
        textView.textColor = .gray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(questionTextView)
    }
}

//MARK: - Setup Constraints
private extension AddQuestionCell {
    func setupCellConstraints() {
        NSLayoutConstraint.activate([
            questionTextView.topAnchor.constraint(equalTo: topAnchor),
            questionTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            questionTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            questionTextView.heightAnchor.constraint(equalTo: heightAnchor, constant: 50)
        ])
    }
}
