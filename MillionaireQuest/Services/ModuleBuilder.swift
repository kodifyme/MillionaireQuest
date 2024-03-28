//
//  ModuleBuilder.swift
//  MillionaireQuest
//
//  Created by KOДИ on 15.03.2024.
//

import UIKit

protocol Builder {
    func createMainModule(_ viewController: UIViewController) -> Self
    func createGameModule(_ viewController: UIViewController) -> Self
    func createResultsModule(_ viewController: UIViewController) -> Self
    func build() -> UINavigationController
}

class ModuleBuilder: Builder {
    
    private var rootViewController: UIViewController?
    
    func createMainModule(_ viewController: UIViewController) -> Self {
        self.rootViewController = viewController
        return self
    }
    
    func createGameModule(_ viewController: UIViewController) -> Self {
        return self
    }
    
    func createResultsModule(_ viewController: UIViewController) -> Self {
        return self
    }
    
    func build() -> UINavigationController {
        UINavigationController(rootViewController: rootViewController!)
    }
}
