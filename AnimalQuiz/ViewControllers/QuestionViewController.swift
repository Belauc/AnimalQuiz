//
//  QuestionViewController.swift
//  AnimalQuiz
//
//  Created by sergey on 18.11.2021.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answerCount
        }
    }
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var rangedStackView: UIStackView!
    
    
    @IBOutlet var signleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answerChosen: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
    }
    
    @IBAction func singleButtonActionPressed(_ sender: UIButton) {
        guard let currentIndex = signleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[currentIndex]
        answerChosen.append(currentAnswer)
        nextQuestion()
    }
    
    @IBAction func multipleButtonAnswerPressed() {
        for (answer, multipleSwitch) in zip(currentAnswers, multipleSwitches){
            if multipleSwitch.isOn {
                answerChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedButtonAnswerPressed() {
        let index = Int(rangedSlider.value)
        answerChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? FinalViewController else { return }
        destination.answers = answerChosen
    }
}

extension QuestionViewController {
    private func UpdateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView]{
            stackView?.isHidden = true
        }
        
        let currentQuesstion = questions[questionIndex]
        
        title = "Вопрос N\(questionIndex + 1)"
        
        questionLabel.text = currentQuesstion.text
        
        let totalProgres = Float(questionIndex) / Float(questions.count)
        
        progressView.setProgress(totalProgres, animated: true)
        
        showCurrentStackView(for: currentQuesstion.type)
    }
    
    private func showCurrentStackView(for type: ResponseType) {
        switch type {
        case .single:
            showSinglStackView(for: currentAnswers)
        case .multiple:
            showMultipleStackView(for: currentAnswers)
        case .range:
            showRangeStackView(for: currentAnswers)
        }
    }
    
    private func showSinglStackView(for answers: [Answer]){
        for (answer, button) in zip(answers, signleButtons){
            button.setTitle("\(answer.text)", for: .normal)
        }
        singleStackView.isHidden = false
    }
    
    private func showMultipleStackView(for answers: [Answer]){
        for (answer, label) in zip(answers, multipleLabels){
            label.text = answer.text
        }
        multipleStackView.isHidden = false
    }
    
    private func showRangeStackView(for answers: [Answer]){
        
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
            
        
        rangedStackView.isHidden = false
    }
    
    private func nextQuestion(){
        questionIndex += 1
        
        if questionIndex < questions.count {
            UpdateUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}


