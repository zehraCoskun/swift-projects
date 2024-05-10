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
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGray2
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Hangman Game"
        titleLabel.font = UIFont.systemFont(ofSize: 32)
        titleLabel.tintColor = .systemGray
        view.addSubview(titleLabel)
        
        let charViews = UIView()
        charViews.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(charViews)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            charViews.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            charViews.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            charViews.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)

        ])
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - 40)/5
        let height = (screenWidth - 40)/5
                for row in 0..<5 {
                    for col in 0..<5 {
                        let charLabel = UILabel()
                        charLabel.layer.backgroundColor = UIColor.red.cgColor
                        charLabel.font = UIFont.systemFont(ofSize: 18)
                        let frame = CGRect(x: CGFloat(col) * width, y: CGFloat(row) * height, width: width, height: height)
                        charLabel.frame = frame
                        charLabel.layer.cornerRadius = 12.0
                        charLabel.layer.borderWidth = 1.0
                        charLabel.layer.borderColor = UIColor.darkGray.cgColor
                        charViews.addSubview(charLabel)
                        charLabels.append(charLabel)
                    }
                }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

