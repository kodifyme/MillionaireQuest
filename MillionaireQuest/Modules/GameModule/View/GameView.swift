//
//  GameView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 01.04.2024.
//

import UIKit

class GameView: UIView {
    
    var currentQuestion = 0
    
    //MARK: - UI
    private let questionCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let colletctionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        colletctionView.register(AnswerCollectionViewCell.self, forCellWithReuseIdentifier: AnswerCollectionViewCell.cellIndetifier)
        colletctionView.register(QuestionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: QuestionHeader.identifier)
        colletctionView.translatesAutoresizingMaskIntoConstraints = false
        return colletctionView
    }()
    
    private lazy var friendCallButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Звонок другу", for: .normal)
        button.addTarget(self, action: #selector(handleFriendCallButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var audienceHelpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Помощь зала", for: .normal)
        button.addTarget(self, action: #selector(handleFriendCallButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var fiftyFiftyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("50 на 50", for: .normal)
        button.addTarget(self, action: #selector(handleFriendCallButton), for: .touchUpInside)
        return button
    }()
    
    private var buttonsStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setDelegates()
        setupConstraints()
    }
    
    //MARK: - Private Methods
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(questionCollectionView)
        
        buttonsStackView = UIStackView(arrangedSubviews: [friendCallButton, audienceHelpButton, fiftyFiftyButton],
                                       axis: .horizontal,
                                       spacing: 20)
        addSubview(buttonsStackView)
        
    }
    
    private func setDelegates() {
        questionCollectionView.dataSource = self
        questionCollectionView.delegate = self
    }
    
    @objc private func handleFriendCallButton() {
        print(#function)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionViewDataSource
extension GameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questions[currentQuestion].options.count
    }
    
    //MARK: - Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: QuestionHeader.identifier, for: indexPath) as? QuestionHeader else { return UICollectionReusableView() }
        
        let question = questions[currentQuestion].question
        header.configure(with: question)
        return header
    }
    
    //MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCollectionViewCell.cellIndetifier, for: indexPath) as? AnswerCollectionViewCell else { return UICollectionViewCell() }
        
        let answer = questions[currentQuestion].options[indexPath.row]
        cell.configure(with: answer)
        cell.backgroundColor = .systemGray5
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension GameView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            CGSize(width: 340 / 2, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 100)
    }
}

//MARK: - Constraints
private extension GameView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            questionCollectionView.topAnchor.constraint(equalTo: topAnchor),
            questionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            questionCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            questionCollectionView.heightAnchor.constraint(equalToConstant: 350),
            
            buttonsStackView.topAnchor.constraint(equalTo: questionCollectionView.bottomAnchor, constant: 50),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}