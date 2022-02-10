//
//  FinalViewController.swift
//  AnimalQuiz
//
//  Created by sergey on 18.11.2021.
//

import UIKit

class FinalViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultDescription: UILabel!
    
    var answers: [Answer] = []
    var result: AnimalType = .dog

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        calculateResult()
        showResult()
    }
    
    
    

}

extension FinalViewController {
    
    private func calculateResult(){
        print(Dictionary(grouping: answers, by: {$0.type}).sorted(by: {$0.value.count > $1.value.count}))
        result = Dictionary(grouping: answers, by: {$0.type}).mapValues({$0.count}).max(by: {$0.value < $1.value})?.key ?? .dog
    }
    private func showResult(){
        resultLabel.text = String(result.rawValue)
        resultDescription.text = result.definition
    }
}
