//
//  GameView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 01.04.2024.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func didChooseAnswer(correct: Bool, at index: Int)
    func didFinishGame()
}

class GameView: UIView {
    
    var currentQuestion = 0
    weak var delegate: GameViewDelegate?
    
    //MARK: - UI
    private let questionCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let colletctionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        colletctionView.register(AnswerCollectionViewCell.self, forCellWithReuseIdentifier: AnswerCollectionViewCell.cellIndetifier)
        colletctionView.register(QuestionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: QuestionHeader.identifier)
        colletctionView.translatesAutoresizingMaskIntoConstraints = false
        return colletctionView
    }()
    
    private lazy var friendCallButton = CustomButton
        .createButton(title: "Звонок другу", type: .system, target: self, action: #selector(handleFriendCallButton))
    
    private lazy var audienceHelpButton = CustomButton
        .createButton(title: "Помощь зала", type: .system, target: self, action: #selector(handleFriendCallButton))
    
    private lazy var fiftyFiftyButton = CustomButton
        .createButton(title: "50/50", type: .system, target: self, action: #selector(handleFriendCallButton))
    
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
                                       spacing: 30)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let correctAnswerIndex = questions[currentQuestion].correctAnswer
        
        let isCorrect = indexPath.item == correctAnswerIndex
        delegate?.didChooseAnswer(correct: isCorrect, at: currentQuestion)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = isCorrect ? .systemGreen : . systemRed
       
        if isCorrect {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.currentQuestion += 1
                if self.currentQuestion < questions.count {
                    collectionView.reloadData()
                } else {
                    self.delegate?.didFinishGame()
                    print("Вы прошли игру")
                }
            }
        }
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
