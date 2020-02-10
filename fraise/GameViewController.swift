//
//  GameViewController.swift
//  fraise
//
//  Created by Matt Wang on 2019-07-19.
//  Copyright © 2019 Matthew Wang. All rights reserved.
//

import UIKit
import SwiftySound

class GameViewController: UIViewController {
    // game state
    var phrases = Fraises.general
    var phraseCount = 0
    let roundTime = 45
    var timeLeft = 0
    var teamAScore = 0
    var teamBScore = 0
    var gameStarted = false
    var gameTimer: Timer?
    
    // game settings
    var skipsAllowed = false
    var randomizeTimer = true
    var showTimer = false
    var inconsistentTimer = false
    
    // word groups
    var includeSongs = true
    var includeMovies = true
    var includeBooks = true
    var includeSports = true
    var includeFood = true
    
    @IBOutlet weak var currentPhrase: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var newPhraseButton: UIButton!
    @IBOutlet weak var teamAScoreLabel: UILabel!
    @IBOutlet weak var teamAScoreButton: UIButton!
    @IBOutlet weak var teamBScoreLabel: UILabel!
    @IBOutlet weak var teamBScoreButton: UIButton!
    @IBAction func generateNewPhrase(_ sender: Any) {
        if !gameStarted {
            resetGame()
            startGame()
        }
        else {
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
        phrases = Fraises.general
        if includeSongs {
            phrases += Fraises.songs
        }
        if includeMovies {
            phrases += Fraises.movies
        }
        if includeBooks {
            phrases += Fraises.books
        }
        if includeSports {
            phrases += Fraises.sports
        }
        if includeFood {
            phrases += Fraises.food
        }
        phrases.shuffle()
        phraseCount = 0
    }
    func decrementTimer(){
        timeLeft -= 1
        if !inconsistentTimer {
            Sound.play(file: "tick.mp3")
        }
        if showTimer {
            timeLeftLabel.text = String(self.timeLeft)
        }
        if timeLeft == 0 {
            endGame()
        }
    }
    func resetGame(){
        teamAScore = 0
        teamBScore = 0
        timeLeft = roundTime
        if randomizeTimer {
            timeLeft += Int.random(in: 1..<30)
        }
        if showTimer {
            timeLeftLabel.text = String(timeLeft)
        }
    }
    func setupGame(){
        currentPhrase.text = "welcome to fraise"
        timeLeftLabel.text = ""
        newPhraseButton.setTitle("start game", for: .normal)
        teamAScoreLabel.text = "-"
        teamBScoreLabel.text = "-"
        teamAScoreButton.setTitle("", for: .normal)
        teamBScoreButton.setTitle("", for: .normal)
    }
    func startGame(){
        resetGame()
        newPhrases()
        newPhraseButton.setTitle("next fraise", for: .normal)
        teamAScoreLabel.text = String(teamAScore)
        teamBScoreLabel.text = String(teamBScore)
        teamAScoreButton.setTitle("+", for: .normal)
        teamBScoreButton.setTitle("+", for: .normal)
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.decrementTimer()
        }
        gameStarted = true;
    }
    func endGame(){
        gameTimer?.invalidate()
        Sound.stopAll()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "SettingsSegue" {
            endGame()
            let settingsTableViewController = segue.destination as! SettingsTableViewController
            settingsTableViewController.setRandomizeTimer(randomizeTimer)
            settingsTableViewController.setShowTimer(showTimer)
            
            settingsTableViewController.setIncludeSongs(includeSongs)
            settingsTableViewController.setIncludeMovies(includeMovies)
            settingsTableViewController.setIncludeBooks(includeBooks)
            settingsTableViewController.setIncludeSports(includeSports)
            settingsTableViewController.setIncludeFood(includeFood)
        }
    }
    
    @IBAction func unwindToGame(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "unwindToGameSegue" {
            let settingsTableViewController = unwindSegue.source as! SettingsTableViewController
            randomizeTimer = settingsTableViewController.randomizeTimer
            showTimer = settingsTableViewController.showTimer
            includeSongs = settingsTableViewController.includeSongs
            includeMovies = settingsTableViewController.includeMovies
            includeBooks = settingsTableViewController.includeBooks
            includeSports = settingsTableViewController.includeSports
            includeFood = settingsTableViewController.includeFood
            setupGame()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let gameTimer = self.gameTimer{
            gameTimer.invalidate()
        }
    }
}

