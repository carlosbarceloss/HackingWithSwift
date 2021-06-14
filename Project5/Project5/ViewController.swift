//
//  ViewController.swift
//  Project5
//
//  Created by Carlos Barcelos on 08/06/21.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["failed"]
        }
        
        startGame()
    }

   @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Insira a palavra", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Ok", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text?.lowercased() else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        if answer.utf16.count < 3 {
            showErrorMessage(title: "Palavra muito curta!", message: "Sua palavra precisa ter ao menos 3 caracteres.")
        } else if answer == title {
            showErrorMessage(title: "A palavra deve ser diferente!", message: "Sua palavra não pode ser igual à fornecida")
        } else {
            if isPossible(word: answer) {
                if isOriginal(word: answer) {
                    if isReal(word: answer) {
                        usedWords.insert(answer, at: 0)
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        return
                    } else {
                        showErrorMessage(title: "Palavra não reconhecida", message: "Obs: não é válido inventar palavras!")
                    }
                } else {
                    showErrorMessage(title:  "Palavra já utilizada", message: "Utilize uma palavra diferente.")
                }
            } else {
                guard let title = title else { return }
                showErrorMessage(title: "Essa palavra não é possível", message: "Não é possível formar essa palavra a partir de \(title.lowercased()).")
            }
        }
    }
    
    func showErrorMessage(title: String, message: String){
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible (word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal (word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal (word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

