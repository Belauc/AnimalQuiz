//
//  Answer.swift
//  AnimalQuiz
//
//  Created by sergey on 27.11.2021.
//

import Foundation

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rebbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Собака"
        case .cat:
            return "Кот"
        case .rebbit:
            return "Кролик"
        case .turtle:
            return "Черепаха"
        }
    }
}
