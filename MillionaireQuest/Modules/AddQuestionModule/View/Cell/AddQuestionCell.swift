//
//  AddQuestionCell.swift
//  MillionaireQuest
//
//  Created by KOДИ on 02.05.2024.
//

import UIKit

class AddQuestionCell: UITableViewCell {
    
    static let cellIdentifier = "AddQuestionCell"
    
    private lazy var questionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.font = .boldSystemFont(ofSize: 16)
        textView.layer.cornerRadius = 5.0
        textView.text = "Введите вопрос"
        textView.textColor = .lightGray
        textView.delegate = self
        return textView
    }()
    
    private lazy var optionATextField = CustomTextField(placeholder: "A: Введите ответ")
    private lazy var optionBTextField = CustomTextField(placeholder: "B: Введите ответ")
    private lazy var optionCTextField = CustomTextField(placeholder: "C: Введите ответ")
    private lazy var optionDTextField = CustomTextField(placeholder: "D: Введите ответ")

    private lazy var allstrackView: UIStackView = {
        UIStackView(arrangedSubviews: [questionTextView, optionATextField, optionBTextField, optionCTextField, optionDTextField],
                    axis: .vertical,
                    spacing: 20)
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
        contentView.addSubview(allstrackView)
    }
}

//MARK: - UITextViewDelegate
extension AddQuestionCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите вопрос"
            textView.textColor = UIColor.lightGray
        }
    }
}

//MARK: - Setup Constraints
private extension AddQuestionCell {
    func setupCellConstraints() {
        NSLayoutConstraint.activate([
            allstrackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            allstrackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            allstrackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            allstrackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
