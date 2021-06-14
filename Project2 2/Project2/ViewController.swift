//
//  ViewController.swift
//  Project2
//
//  Created by Carlos Barcelos on 06/06/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(showPoints))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
        
        button1.layer.borderWidth = 1.5
        button2.layer.borderWidth = 1.5
        button3.layer.borderWidth = 1.5
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " | pontuação: \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        questionsCount += 1
        if sender.tag == correctAnswer {
            title = "Correto"
            score += 1
            message = "Sua nova pontuação é: \(score)"
        } else {
            title = "Errado"
            score += (score > 0 ? -1 : 0)
            message = "Essa bandeira é: \(countries[sender.tag].uppercased())"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continuar", style: .default, handler: askQuestion))
        
        if questionsCount == 5 {
            ac.title = "Fim de jogo"
            ac.message = "Pontuação final: \(score)"
            present(ac, animated: true)
            score = 0
            questionsCount = 0
        } else {
            present(ac, animated: true)
        }
    }
    
    @objc func showPoints() {
        let ac = UIAlertController(title: "Pontuação atual", message: "\(score) pontos", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
}

