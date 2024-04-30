//
//  ViewController.swift
//  guess the flag
//
//  Created by Zehra Coşkun on 29.04.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var flagTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var countries = [String()]
    var correctAnswer = 0
    var score = 0
    var numberOfQuestion = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        flagTitleLabel.text = countries[correctAnswer].uppercased()
        scoreLabel.text = "0"
        
        title = countries[correctAnswer].uppercased()
        
        numberOfQuestion += 1
        if numberOfQuestion == 3 {
              let finalAC = UIAlertController(title: "Final!", message: "Completed 10 question", preferredStyle: .alert)
              finalAC.addAction(UIAlertAction(title: "Let's continue", style: .default))
              present(finalAC, animated: true)
          }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message : String
        if sender.tag == correctAnswer{
            title = "Correct"
            message = "Congratulations"
            score += 10
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            message = "Don't be sad"
            score -= 10
        }
        scoreLabel.text = String(score)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    
    
    
}

