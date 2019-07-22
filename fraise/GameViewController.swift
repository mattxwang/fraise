//
//  ViewController.swift
//  fraise
//
//  Created by Matt Wang on 2019-07-19.
//  Copyright © 2019 Matthew Wang. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var phrases = [
        "death star",
        "salsa",
        "coffee mug",
        "hockey stick",
        "screw",
        "trampoline",
        "options",
        "airpods",
        "goggles",
        "pizza",
        "fried rice",
        "cutting board",
        "water bottles",
        "pineapple",
        "coffee bean",
        "dress shoe",
        "board game",
        "laser",
        "toilet bowl",
        "bluetooth speaker",
        "sugar cube"
    ]
    var phraseCount = 0
    let roundTime = 45
    var timeLeft = 0
    var teamAScore = 0
    var teamBScore = 0
    var gameStarted = false
    var gameTimer: Timer?
    var skipsAllowed = false
    
    @IBOutlet weak var currentPhrase: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var newPhraseButton: UIButton!
    @IBOutlet weak var teamAScoreLabel: UILabel!
    @IBOutlet weak var teamAScoreButton: UIButton!
    @IBOutlet weak var teamBScoreLabel: UILabel!
    @IBOutlet weak var teamBScoreButton: UIButton!
    @IBAction func generateNewPhrase(_ sender: Any) {
        if !gameStarted{
            startGame()
        }
        else{
            if phraseCount + 1 < phrases.count{
                phraseCount += 1
            }
            else{
                newPhrases()
            }
        }
        currentPhrase.text = phrases[phraseCount];
    }
    @IBAction func resetGameButton(_ sender: Any) {
        endGame()
        setupGame()
    }
    @IBAction func incrementAScore(_ sender: Any) {
        teamAScore += 1
        teamAScoreLabel.text = String(teamAScore)
    }
    @IBAction func incrementBScore(_ sender: Any) {
        teamBScore += 1
        teamBScoreLabel.text = String(teamBScore)
    }
    func newPhrases(){
        phrases.shuffle()
        phraseCount = 0
    }
    func setupGame(){
        currentPhrase.text = "welcome to fraise"
        timeLeftLabel.text = ""
        newPhraseButton.setTitle("start game", for: .normal)
        teamAScore = 0
        teamBScore = 0
        teamAScoreLabel.text = String(teamAScore)
        teamBScoreLabel.text = String(teamBScore)
        teamAScoreButton.setTitle("", for: .normal)
        teamBScoreButton.setTitle("", for: .normal)
    }
    func startGame(){
        newPhrases()
        newPhraseButton.setTitle("next fraise", for: .normal)
        teamAScoreButton.setTitle("+", for: .normal)
        teamBScoreButton.setTitle("+", for: .normal)
        timeLeft = roundTime
        timeLeftLabel.text = String(timeLeft)
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeLeft -= 1
            self.timeLeftLabel.text = String(self.timeLeft)
            if self.timeLeft == 0 {
                self.endGame()
            }
        }

        gameStarted = true;
    }
    func endGame(){
        gameTimer?.invalidate()
        currentPhrase.text = "game over!"
        newPhraseButton.setTitle("new game", for: .normal)
        if (teamAScore > teamBScore){
            timeLeftLabel.text = "Team A Won!"
        }
        else if (teamBScore > teamAScore){
            timeLeftLabel.text = "Team B Won!"
        }
        else {
            timeLeftLabel.text = "Tie"
        }
        teamAScoreButton.setTitle("", for: .normal)
        teamBScoreButton.setTitle("", for: .normal)
        gameStarted = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupGame()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let gameTimer = self.gameTimer{
            gameTimer.invalidate()
        }
    }
}

