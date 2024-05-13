//
//  ViewController.swift
//  Hangman Game
//
//  Created by Zehra Coşkun on 10.05.2024.
//

import UIKit

class ViewController: UIViewController {

    var titleLabel: UILabel!
    var charLabels = [UILabel]()
    var answerTextField : UITextField!
    var charViews : UIView!
    
    
    var allWords = [String]()
    var selectedWord : String! = "APPLE"
    var usersWords = ["     ","     ","     ","     ","     ","     ","     "]{
        didSet{
            setCharViews()
        }
    }
    var count = 0
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGray2
        
        setTitleLabel()
        setAnswerTextField()
        
        charViews = UIView()
        charViews.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(charViews)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            charViews.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            charViews.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            charViews.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            //answerTextField.topAnchor.constraint(equalTo: charViews.bottomAnchor, constant: 8),
            answerTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            answerTextField.heightAnchor.constraint(equalToConstant: 32),
            answerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        

        ])


    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeKeyboard()
        getWords()
        setCharViews()
        
    }
    
    func setCharViews(){
        let buttonSpacing: CGFloat = 2.0
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - 50)/5
        let height = (screenWidth - 40)/10
                for row in 0..<7 {
                    for col in 0..<5 {
                        let charLabel = UILabel()
                        charLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
                        charLabel.textAlignment = .center
                        let x = CGFloat(col) * (width + buttonSpacing)
                        let y = CGFloat(row) * (height + buttonSpacing)
                        let frame = CGRect(x: x, y: y, width: width, height: height)
                        charLabel.frame = frame
                        charLabel.layer.cornerRadius = 4.0
                        charLabel.layer.borderWidth = 0.5
                        charLabel.layer.borderColor = UIColor.systemGray.cgColor
                    
                        let labelText = String(usersWords[row].prefix(col+1).suffix(1))

                        if labelText == selectedWord!.prefix(col+1).suffix(1) {
                            charLabel.layer.backgroundColor = UIColor.systemGreen.cgColor
                       
                        }
                        else if(selectedWord.contains(labelText)){
                            charLabel.layer.backgroundColor = UIColor.systemYellow.cgColor
                           
                        }
                        charLabel.text = labelText
                        charViews.addSubview(charLabel)
                        charLabels.append(charLabel)
                    }
                }
    }
    
    func getWords(){
        if let startWordsURL = Bundle.main.url(forResource: "hangman", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
            selectedWord = allWords.randomElement()?.uppercased()
        }
    }
    
    func startGame(didWin : Bool){
        if !didWin {
            let ac = UIAlertController(title: "Game Over",
                                       message: "Your word : \(selectedWord ?? "hello")",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
        usersWords = ["     ","     ","     ","     ","     ","     ","     "]
        selectedWord = allWords.randomElement()?.uppercased()
        charViews.subviews.forEach { $0.removeFromSuperview() }
        setCharViews()
        count = 0
        
    }
    
    func checkAnswer(selectedWord : String, usersAnswer : String){
        if selectedWord == usersAnswer {
            let ac = UIAlertController(title: "Congratulations !", 
                                       message: "That's the right word",
                                       preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Thank you <3", 
                                       style: .default){[weak self] _ in
                self?.startGame(didWin: true)
            })
            present(ac, animated: true)
        }
    }
    
    func setTitleLabel(){
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Hangman Game"
        titleLabel.font = UIFont.systemFont(ofSize: 32)
        titleLabel.tintColor = .systemGray
        view.addSubview(titleLabel)
    }
    func setAnswerTextField(){
        answerTextField = UITextField()
        answerTextField.translatesAutoresizingMaskIntoConstraints = false
        answerTextField.placeholder = "Enter your answer"
        answerTextField.font = UIFont.systemFont(ofSize: 18)
        answerTextField.keyboardType = .alphabet
        answerTextField.layer.borderWidth = 0.5
        answerTextField.layer.borderColor = UIColor.systemGray.cgColor
        answerTextField.layer.cornerRadius = 6.0
        answerTextField.delegate = self
        view.addSubview(answerTextField)
    }
    
    func closeKeyboard(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }

}
extension ViewController : UITextFieldDelegate{
    //enter tuşuna basıldığında kullanılan metod
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if var answerTextFieldText =  answerTextField.text?.uppercased(){
            answerTextFieldText = answerTextFieldText.components(separatedBy: .whitespaces).joined()
            if answerTextFieldText.count != 5{
                let ac = UIAlertController(title: "Opss!", 
                                           message: "You must write a word of only 5 letters",
                                           preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                present(ac, animated: true)
            } else if answerTextFieldText.count == 5 {
                usersWords.insert(answerTextFieldText, at: count)
                usersWords.remove(at: count+1)
                checkAnswer(selectedWord: selectedWord, usersAnswer: answerTextFieldText)
                count += 1
                if count == 7 {
                    startGame(didWin: false)
                }
            }
        }
           textField.text = ""
           textField.resignFirstResponder()
           return false
       }
}

