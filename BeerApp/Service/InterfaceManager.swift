//
//  InterfaceManager.swift
//  BeerApp
//
//  Created by Павел Градов on 04.11.2024.
//

import Foundation
import UIKit

enum OperatorSymbol: String {
    case plus = "plus"
    case minus = "minus"
}

final class InterfaceManager {
    func createTitleLabel(withText text: String) -> UILabel {
        {
            $0.text = text
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            return $0
        }(UILabel())
    }
    
    func createOperatorButton(with symbol: OperatorSymbol) -> UIButton {
        {
            $0.setImage(UIImage(systemName: symbol.rawValue), for: .normal)
            $0.tintColor = .black
            return $0
        }(UIButton())
    }
    
    func createCounterLabel() -> UILabel {
        {
            $0.text = "0"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 32)
            return $0
        }(UILabel())
    }
    
    func createHStackView() -> UIStackView {
        {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.alignment = .center
            return $0
        }(UIStackView())
    }
    
    func createVStackView() -> UIStackView {
        {
            $0.axis = .vertical
            $0.distribution = .fill
            return $0
        }(UIStackView())
    }
    
    func createButton(withTitle title: String, font: UIFont = .systemFont(ofSize: 16), textColor: UIColor = .black) -> UIButton {
        {
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 15
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(textColor, for: .normal)
            $0.titleLabel?.font = font
            return $0
        }(UIButton())
    }
}
