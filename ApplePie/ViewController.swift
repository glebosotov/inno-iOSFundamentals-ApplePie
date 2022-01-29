//
//  ViewController.swift
//  ApplePie
//
//  Created by Gleb Osotov on 1/26/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: UI Variables
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!

    //MARK: Game variables
    var currentGame: Game!
    var list0fWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLoss = 0 {
        didSet {
            newRound()
        }
    }
    
    
    //MARK: UI functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func enableLetterButtons(_ a: Bool) {
        for letterButton in letterButtons {
            letterButton.isEnabled = a
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        
        correctWordLabel.text = letters.joined(separator: " ")
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLoss)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    //MARK: Game functions
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLoss += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func newRound() {
        if !list0fWords.isEmpty {
            let newWord = list0fWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
}

