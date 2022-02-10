//
//  Question.swift
//  AnimalQuiz
//
//  Created by sergey on 27.11.2021.
//

import Foundation

enum ResponseType {
    case single
    case multiple
    case range
}

struct Question {
    let text: String
    let type: ResponseType
    let answers: [Answer]
}

extension Question {
    static func getQuestions() -> [Question] {
        return [Question(text: "Какую пищу вы предпочитаете?",
                         type: .single,
                         answers: [
                            Answer(text: "Стейк", type: .dog),
                            Answer(text: "Рыба", type: .cat),
                            Answer(text: "Морковь", type: .rebbit),
                            Answer(text: "Кукуруза", type: .turtle)]),
                Question(text: "Что вы любите делать?",
                         type: .multiple,
                         answers: [
                                    Answer(text: "Плавать", type: .dog),
                                    Answer(text: "Спать", type: .cat),
                                    Answer(text: "Обниматься", type: .rebbit),
                                    Answer(text: "Есть", type: .turtle)]),
                Question(text: "Любите ли вы поездки на машине?",
                         type: .range,
                         answers: [
                                    Answer(text: "Ненавижу", type: .dog),
                                    Answer(text: "Нейтрально", type: .cat),
                                    Answer(text: "Более менее", type: .rebbit),
                                    Answer(text: "Обожаю", type: .turtle)])
        ]
    }
}
