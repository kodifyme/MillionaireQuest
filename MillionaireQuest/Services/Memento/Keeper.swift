//
//  Keeper.swift
//  MillionaireQuest
//
//  Created by KOДИ on 10.05.2024.
//

import UIKit

class Keeper<T: Codable> {
    
    private let caretaker = Caretaker<T>()
    private let key = String(describing: T.self)
    
    func save(_ items: [T]) {
        caretaker.save(items, key: key)
    }
    
    func load() -> [T] {
        caretaker.loadMementos(for: key)
    }
}
