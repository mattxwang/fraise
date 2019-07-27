//
//  GameViewController.swift
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
        "sugar cube",
        "phrase",
        "running shoes",
        "lion king",
        "hawaiian shirt",
        "water filter",
        "pancake mix",
        "flip phone",
        "whole number",
        "rook",
        "melon",
        "outlet store",
        "microwave oven",
        "dog walker",
        "public speaking",
        "laptop charger",
        "variable",
        "sugar cube",
        "movie theater",
        "banana bread",
        "stir-fry",
        "recycling bin",
        "passenger door",
        "electric scooter",
        "blinds",
        "palm trees",
        "laundromat",
        "telephone pole",
        "spaghetti strainer",
        "bed frame",
        "chandelier",
        "tie clip",
        "the princess bride",
        "fire extinguisher",
        "small intestine",
        "water fountain",
        "cheese block",
        "milk carton",
        "suede",
        "bean burrito",
        "hair tie",
        "knife sharpener",
        "basketball hoop",
        "swing dance",
        "kale",
        "stranger things",
        "god's plan",
        "canal",
        "panama",
        "suspension bridge",
        "mop",
        "cereal box",
        "disinfectant",
        "succulent",
        "thermostat",
        "standing desk",
        "cookie mix",
        "cookie cutter",
        "snare drum",
        "blog",
        "ampersand",
        "bounce house",
        "get out",
        "converses",
        "grandfather clock",
        "angry react",
        "direct message",
        "laser cutter",
        "acorn",
        "aloe vera",
        "dam",
        "granola bar",
        "trail mix",
        "oatmeal",
        "hot pot",
        "dumbbell",
        "roller blades",
        "ice skating",
        "ceiling fan",
        "orange county",
        "racks"
    ]
    // game state
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
    func decrementTimer(){
        timeLeft -= 1
        if showTimer {
            timeLeftLabel.text = String(self.timeLeft)
        }
        if timeLeft == 0 {
            endGame()
        }
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
        timeLeft = roundTime
        if randomizeTimer {
            timeLeft += Int.random(in: 1..<30)
        }
        if showTimer {
            timeLeftLabel.text = String(timeLeft)
        }
    }
    func startGame(){
        newPhrases()
        newPhraseButton.setTitle("next fraise", for: .normal)
        teamAScoreButton.setTitle("+", for: .normal)
        teamBScoreButton.setTitle("+", for: .normal)
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.decrementTimer()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "SettingsSegue" {
            endGame()
            let settingsTableViewController = segue.destination as! SettingsTableViewController
            settingsTableViewController.setRandomizeTimer(randomizeTimer)
            settingsTableViewController.setShowTimer(showTimer)
        }
    }
    
    @IBAction func unwindToGame(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "unwindToGameSegue" {
            let settingsTableViewController = unwindSegue.source as! SettingsTableViewController
            randomizeTimer = settingsTableViewController.randomizeTimer
            showTimer = settingsTableViewController.showTimer
            setupGame()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let gameTimer = self.gameTimer{
            gameTimer.invalidate()
        }
    }
}

