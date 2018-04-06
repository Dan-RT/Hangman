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
    var end = false
    
    var letterToFind = 0
    
    init (word: String) {
        secret_word = word
        letterToFind = secret_word.count
    }
    
    func initializeGame () {
        end = false
        victory = false
        attempts = 7
        letterToFind = secret_word.count
    }
    
    func checkEndGame () -> Bool {
        if attempts == 1 || letterToFind == 0 {
            end = true
        }
        return end
    }
    
    func check(letter:Character) -> Bool {
        if secret_word.contains(letter) {
            letterToFind = letterToFind - 1
            return true
        } else {
            attempts = attempts - 1
            return false
        }
    }
    
    func replaceCharacter(_ str: String, _ index: Int, _ letter: Character) -> String {
        
        var tabChars = Array(str.characters)
        tabChars[index] = letter
        let newString = String(tabChars)
        
        return newString
    }

}
    




