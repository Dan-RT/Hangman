//
//  ViewController.swift
//  Hangman
//
//  Created by Daniel Regnard on 28/03/2018.
//  Copyright © 2018 Daniel Regnard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameStatus: UIButton!
    @IBOutlet weak var word_label: UILabel!
    @IBOutlet weak var image_gallows: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var level_Label: UILabel!
   
    @IBOutlet weak var gameResult: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var indexProgressBar = 0
    var currentPoseIndex = 0
    
    var previousLevel = Int()
    let hangman_images = [#imageLiteral(resourceName: "Hangman0"), #imageLiteral(resourceName: "Hangman1"), #imageLiteral(resourceName: "Hangman2"), #imageLiteral(resourceName: "Hangman3"), #imageLiteral(resourceName: "Hangman4"), #imageLiteral(resourceName: "Hangman5"), #imageLiteral(resourceName: "Hangman6")]
    
    var timer = Timer()
    
    let game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.initializeGame(levelChosen: segmentedControl.selectedSegmentIndex)
        initializeView()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateProgressBar), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initializeView () {
        enable_all_buttons()
        gameResult.text = ""
        word_label.text = game.replaceLetterByDots()
        image_gallows.image = hangman_images[0]
        gameStatus.setTitle("", for: .normal)
        gameStatus.isEnabled = false
        progressBar.progress = 0.0
        previousLevel = segmentedControl.selectedSegmentIndex
        //JSonParser.retrieveJSon(urlString: "https://goo.gl/VGa6Xb")
        
        progressBar.isHidden = false
        indexProgressBar = 0
        getNextPoseData()
    }
    
    
    func getNextPoseData()
    {
        // do next pose stuff
        currentPoseIndex += 1
        print(currentPoseIndex)
    }
    
    @objc func updateProgressBar() {
        
        if indexProgressBar == game.interval {
            game.end = true
            defineGameStatus()
        }
        
        progressBar.progress = Float(indexProgressBar) / Float(game.interval - 1)
        
        indexProgressBar += 1
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        alertBox()
    }
    
    @IBAction func didPress(_ sender: Any) {
        let button = sender as! UIButton
        print(button.currentTitle!)
        let letter = button.currentTitle!.first!
        
        if button == gameStatus {   // "Try Again" button pressed
            game.initializeGame(levelChosen: segmentedControl.selectedSegmentIndex)
            initializeView()
        } else if !game.end {       //keyboard button pressed
            checkLetter(letter: letter)
            defineGameStatus()
            button.isEnabled = false
        }
    }
    
    func checkLetter (letter: Character) {
        if game.check(letter: letter) {     //if good letter
            word_label.text = game.replaceLetter(letter: letter, word: word_label.text!)
            indexProgressBar = 0
        } else {
            image_gallows.image = hangman_images[7-game.attempts]
        }
        
        if game.checkEndGame() {
            gameStatus.isEnabled = true
        }
    }
    
    func defineGameStatus () {
        if game.end {
            progressBar.isHidden = true
            if game.letterToFind == 0 {
                gameResult.text = "CONGRATS"
            } else {
                gameResult.text = "GAME OVER"
                word_label.text = game.secret_word
            }
            disable_all_buttons()
            gameStatus.isEnabled = true
            gameStatus.setTitle("Play Again", for: .normal)
        }
    }
    
    func alertBox() {
        
        let refreshAlert = UIAlertController(title: "Change level", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.previousLevel = self.segmentedControl.selectedSegmentIndex
            self.updateLevelLabel(index: self.segmentedControl.selectedSegmentIndex)
            self.game.initializeGame(levelChosen: self.segmentedControl.selectedSegmentIndex)
            self.initializeView()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.segmentedControl.selectedSegmentIndex = self.previousLevel
            self.updateLevelLabel(index: self.segmentedControl.selectedSegmentIndex)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func updateLevelLabel (index:Int) {
        level_Label.text = game.getLevel(index: index)
    }
    
    
    func disable_all_buttons () {
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.isEnabled = false
            }
        }
    }
    
    func enable_all_buttons () {
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.isEnabled = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

