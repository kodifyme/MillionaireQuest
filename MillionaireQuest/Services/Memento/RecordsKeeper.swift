//
//  RecordsKeeper.swift
//  MillionaireQuest
//
//  Created by KOДИ on 19.04.2024.
//

import Foundation

class RecordsKeeper {
    private let caretaker = GameCaretaker()
    private let mementosKey = String(describing: RecordsKeeper.self)
    
    func save(_ mementos: [RecordsOriginator]) {
        caretaker.saveMementos(mementos, key: mementosKey)
    }
    
    func load() -> [RecordsOriginator] {
        caretaker.loadMementos(for: mementosKey)
    }
}
