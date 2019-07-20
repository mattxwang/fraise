//
//  ViewController.swift
//  fraise
//
//  Created by Matt Wang on 2019-07-19.
//  Copyright © 2019 Matthew Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
        "pineapple"
    ]
    var phraseCount = 0;
    
    @IBOutlet weak var currentPhrase: UILabel!
    @IBOutlet weak var newPhraseButton: UIButton!
    @IBAction func generateNewPhrase(_ sender: Any) {
        if phraseCount + 1 < phrases.count{
            phraseCount += 1
        }
        else{
            newPhrases()
        }
        currentPhrase.text = phrases[phraseCount];
    }
    func newPhrases(){
        phrases.shuffle();
        phraseCount = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newPhrases()
        currentPhrase.text = phrases[phraseCount];
    }


}

