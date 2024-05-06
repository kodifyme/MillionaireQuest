//
//  TableFooterView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 06.05.2024.
//

import UIKit

class TableFooterView: UIView {
    
    private lazy var addInputFormButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "addForm"), for: .normal)
        button.addTarget(self, action: #selector(addFormButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(addInputFormButton)
    }
    
    @objc private func addFormButtonTapped() {
        print(#function)
    }
}

//MARK: - Setup Constraints
extension TableFooterView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            addInputFormButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addInputFormButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addInputFormButton.widthAnchor.constraint(equalToConstant: 50),
            addInputFormButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
