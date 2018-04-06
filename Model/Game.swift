//
//  Game.swift
//  Hangman
//
//  Created by Daniel Regnard on 06/04/2018.
//  Copyright © 2018 Daniel Regnard. All rights reserved.
//

import Foundation


class Game {
    
    var attempts = 7
    var victory = false
    var secret_word = ""
    
    var end:Bool {
        get {
            return attempts == 1
        }
        set {
            self.end = attempts == 1
        }
    }
    var letterToFind: Int {
        get {
            return secret_word.count
        }
        set {
            self.letterToFind = secret_word.count
        }
    }
    
    //let hangman_images = [#imageLiteral(resourceName: "Hangman0"), #imageLiteral(resourceName: "Hangman1"), #imageLiteral(resourceName: "Hangman2"), #imageLiteral(resourceName: "Hangman3"), #imageLiteral(resourceName: "Hangman4"), #imageLiteral(resourceName: "Hangman5"), #imageLiteral(resourceName: "Hangman6")]
    
    init (word: String) {
        secret_word = word
    }
    
    func initializeGame () {
        //word_label.text = "....."
        //image_gallows.image = hangman_images[0]
        end = false
        victory = false
        //gameStatus.setTitle("", for: .normal)
        //gameStatus.isEnabled = false
        attempts = 7
    }
    
}



