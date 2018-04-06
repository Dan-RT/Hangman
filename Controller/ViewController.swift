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
    
    let hangman_images = [#imageLiteral(resourceName: "Hangman0"), #imageLiteral(resourceName: "Hangman1"), #imageLiteral(resourceName: "Hangman2"), #imageLiteral(resourceName: "Hangman3"), #imageLiteral(resourceName: "Hangman4"), #imageLiteral(resourceName: "Hangman5"), #imageLiteral(resourceName: "Hangman6")]
    
    let game = Game(word: "Cobra")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.initializeGame()
        initializeView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initializeView () {
        enable_all_buttons()
        word_label.text = "....."
        image_gallows.image = hangman_images[0]
        gameStatus.setTitle("", for: .normal)
        gameStatus.isEnabled = false
    }

    @IBAction func didPress(_ sender: Any) {
        let button = sender as! UIButton
        print(button.currentTitle!)
        let letter = button.currentTitle!.first!
        
        if button == gameStatus {   // "Try Again" button pressed
            game.initializeGame()
            initializeView()
        } else if !game.end {       //keyboard button pressed
            checkLetter(letter: letter)
            gameStatus()
        }
    }
    
    func checkLetter (letter: String) {
        
        if game.check(letter: letter) {     //if good letter
            let word_tmp = wordLabel
            let index_tmp = secret_word.index(of: letter)
            let index = secret_word.distance(from: secret_word.startIndex, to: index_tmp!)
            word_label.text = game.replaceCharacter(word_tmp!, index, letter)
        
        } else {
            image_gallows.image = hangman_images[7-game.attempts]
        }
        button.isEnabled = false
    }
    
    func gameStatus () {
        if game.end {
            if game.attempts == 1 {
                word_label.text = "GAME OVER"
            } else if game.letterToFind == 0 {
                word_label.text = "CONGRATS"
            }
            gameStatus.isEnabled = true
            gameStatus.setTitle("Play Again", for: .normal)
            disable_all_buttons()
        }
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

