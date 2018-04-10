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
    
    let dictionnary = ["COBRA", "ANGLE", "ARMOIRE", "BANC", "BUREAU", "CABINET", "CARREAU", "CHAISE", "CLASSE", "CLEF", "COIN"]
    
    var letterToFind = 0
    
    func initializeGame () {
        secret_word = "AAABCC" //chooseRandomWord()
        print("Secret word : \(secret_word)")
        letterToFind = secret_word.count
        end = false
        victory = false
        attempts = 7
        letterToFind = secret_word.count
    }
    
    func chooseRandomWord() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(dictionnary.count)))
        
        return dictionnary[randomIndex]
    }
    
    func replaceLetterByDots () -> String {
        var word_tmp = secret_word
        for i in word_tmp {
            word_tmp = word_tmp.replacingOccurrences(of: String(i), with: ".")
        }
        return word_tmp
    }
    
    func checkEndGame () -> Bool {
        if attempts == 1 || letterToFind == 0 {
            end = true
        }
        return end
    }
    
    func check(letter:Character) -> Bool {
        if secret_word.contains(letter) {
            return true
        } else {
            attempts = attempts - 1
            return false
        }
    }
    
    func replaceLetter(letter:Character, word:String) -> String {
        var index:Int = 0
        var word_tmp = word
        for char in secret_word {
            if char == letter {
                word_tmp = replaceCharacter(word_tmp, index, letter)
                letterToFind-=1
            }
            index+=1
        }
        return word_tmp
    }
    
    func replaceCharacter(_ str: String, _ index: Int, _ letter: Character) -> String {
        
        var tabChars = Array(str.characters)
        tabChars[index] = letter
        let newString = String(tabChars)
        
        return newString
    }

}
    




