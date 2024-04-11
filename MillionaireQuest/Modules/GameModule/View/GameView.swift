//
//  GameView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 01.04.2024.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func gameViewDidUseFriendCall()
    func gameViewDidUseAudienceHelp()
    func gameViewDidUseFiftyFifty()
    func didChooseAnswer(at index: Int)
}

class GameView: UIView {
    
    weak var delegate: GameViewDelegate?
    
    var currentQuestion: Question
    var lastCellIndex: IndexPath?
    
    //MARK: - UI
    private let questionCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 25
        //Пошарить высоту
        collectionViewLayout.minimumInteritemSpacing = 10
        
        let colletctionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        colletctionView.register(AnswerCollectionViewCell.self, forCellWithReuseIdentifier: AnswerCollectionViewCell.cellIndetifier)
        colletctionView.register(QuestionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: QuestionHeader.identifier)
        colletctionView.translatesAutoresizingMaskIntoConstraints = false
        return colletctionView
    }()
    
    private lazy var friendCallButton = CustomButton
        .createButton(title: "Звонок другу", type: .system, target: self, action: #selector(handleFriendCallButton))
    
    private lazy var audienceHelpButton = CustomButton
        .createButton(title: "Помощь зала", type: .system, target: self, action: #selector(handleAudienceHelp))
    
    private lazy var fiftyFiftyButton = CustomButton
        .createButton(title: "50/50", type: .system, target: self, action: #selector(handleFiftyFifty))
    
    private lazy var buttonsStackView: UIStackView = {
        UIStackView(arrangedSubviews: [friendCallButton, audienceHelpButton, fiftyFiftyButton], axis: .horizontal, spacing: 30)
    }()
    
    init(question: Question) {
        currentQuestion = question
        super.init(frame: .zero)
        
        setupView()
        setDelegates()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(questionCollectionView)
        addSubview(buttonsStackView)
    }
    
    private func setDelegates() {
        questionCollectionView.dataSource = self
        questionCollectionView.delegate = self
    }
    
    @objc private func handleFriendCallButton() {
        delegate?.gameViewDidUseFriendCall()
    }
    
    @objc private func handleAudienceHelp() {
        delegate?.gameViewDidUseAudienceHelp()
    }
    
    @objc private func handleFiftyFifty() {
        delegate?.gameViewDidUseFiftyFifty()
    }
}

//MARK: - UICollectionViewDataSource
extension GameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentQuestion.options.count
    }
    
    //MARK: - Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: QuestionHeader.identifier, for: indexPath) as? QuestionHeader else { return UICollectionReusableView() }
        
        header.configure(with: currentQuestion.question)
        return header
    }
    
    //MARK: - Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCollectionViewCell.cellIndetifier, for: indexPath) as? AnswerCollectionViewCell else { return UICollectionViewCell() }
        
        let answer = currentQuestion.options[indexPath.row]
        cell.configure(with: answer)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension GameView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = collectionView.frame.width * 0.9 / 2
        return CGSize(width: widht, height: widht * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        lastCellIndex = indexPath
        delegate?.didChooseAnswer(at: indexPath.item)
    }
}

//MARK: - GameViewControllerDelegate
extension GameView: GameViewControllerDelegate {
    func colorAfter(isCorrect: Bool) {
        guard let lastCellIndex else { return }
        let cell = questionCollectionView.cellForItem(at: lastCellIndex)
        cell?.backgroundColor = isCorrect ? .systemGreen : .systemRed
    }
    
    func refreshWithQuestion(question: Question) {
        currentQuestion = question
        questionCollectionView.reloadData()
    }
}

//MARK: - Constraints
private extension GameView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            questionCollectionView.topAnchor.constraint(equalTo: topAnchor),
            questionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            questionCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            questionCollectionView.heightAnchor.constraint(equalToConstant: 350),
            
            buttonsStackView.topAnchor.constraint(equalTo: questionCollectionView.bottomAnchor, constant: 50),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
