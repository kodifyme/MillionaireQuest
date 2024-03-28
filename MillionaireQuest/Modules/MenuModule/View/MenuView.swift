//
//  MenuView.swift
//  MillionaireQuest
//
//  Created by KOДИ on 15.03.2024.
//

import UIKit

class MenuView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
