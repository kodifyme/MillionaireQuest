//
//  Observable.swift
//  MillionaireQuest
//
//  Created by KOДИ on 01.05.2024.
//

import Foundation

class Observable<T> {
    private var observers: [(T) -> Void] = []
    
    var value: T {
        didSet {
            observers.forEach { $0(value) }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(observer: @escaping (T) -> Void) {
        observers.append(observer)
        observer(value)
    }
}
