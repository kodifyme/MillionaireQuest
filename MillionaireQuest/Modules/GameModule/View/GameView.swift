//
//  GameView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 01.04.2024.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func didUseFriendCall()
    func didUseAudienceHelp()
    func didUseFiftyFifty()
    func didChooseAnswer(at index: Int)
    func setupObservers()
}

class GameView: UIView {
    
    weak var delegate: GameViewDelegate?
    
    var currentQuestion: Question
    var lastCellIndex: IndexPath?
    
    //MARK: - UI
    private let questionNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let correctPercentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        UIStackView(arrangedSubviews: [questionNumberLabel, correctPercentageLabel], axis: .vertical, spacing: 15)
    }()
    
    private let questionCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 25
        
        let colletctionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        colletctionView.register(AnswerCollectionViewCell.self, forCellWithReuseIdentifier: AnswerCollectionViewCell.cellIdentifier)
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
        UIStackView(arrangedSubviews: [friendCallButton, audienceHelpButton, fiftyFiftyButton], axis: .vertical, spacing: 30)
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
        
        addSubview(labelsStackView)
        addSubview(questionCollectionView)
        addSubview(buttonsStackView)
    }
    
    private func setDelegates() {
        questionCollectionView.dataSource = self
        questionCollectionView.delegate = self
    }
    
    func hideCells() {
        var incorrectAnswerIndexes = currentQuestion.options.indices.filter { $0 != currentQuestion.correctAnswer }
        incorrectAnswerIndexes.remove(at: 1)
        
        for i in incorrectAnswerIndexes {
            guard let cell = questionCollectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? AnswerCollectionViewCell else { return }
            cell.isHidden = true
        }
    }
    
    @objc private func handleFriendCallButton() {
        delegate?.didUseFriendCall()
        friendCallButton.isEnabled = false
        friendCallButton.backgroundColor = .systemGray2
    }
    
    @objc private func handleAudienceHelp() {
        delegate?.didUseAudienceHelp()
        audienceHelpButton.isEnabled = false
        audienceHelpButton.backgroundColor = .systemGray2
    }
    
    @objc private func handleFiftyFifty() {
        delegate?.didUseFiftyFifty()
        fiftyFiftyButton.isEnabled = false
        fiftyFiftyButton.backgroundColor = .systemGray2
        hideCells()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCollectionViewCell.cellIdentifier, for: indexPath) as? AnswerCollectionViewCell else { return UICollectionViewCell() }
        
        let answer = currentQuestion.options[indexPath.row]
        cell.configure(with: answer)
        cell.isHidden = false
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
    
    func setQuestionNumber(_ value: Int) {
        questionNumberLabel.text = "Вопрос: \(value)"
    }
    
    func setCorrectPercentage(_ value: Double) {
        correctPercentageLabel.text = "Процент правильных ответов: \(value.rounded()) %"
    }
    
    func resetHints() {
        friendCallButton.isEnabled = true
        friendCallButton.backgroundColor = .systemBlue
        audienceHelpButton.isEnabled = true
        audienceHelpButton.backgroundColor = .systemBlue
        fiftyFiftyButton.isEnabled = true
        fiftyFiftyButton.backgroundColor = .systemBlue
    }
}

//MARK: - Setup Constraints
private extension GameView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor),
            labelsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            questionCollectionView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor),
            questionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            questionCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            questionCollectionView.heightAnchor.constraint(equalToConstant: 400),
            
            buttonsStackView.topAnchor.constraint(equalTo: questionCollectionView.bottomAnchor, constant: 10),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40)
        ])
    }
}
