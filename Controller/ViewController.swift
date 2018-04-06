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
    
    let game = Game(word: "Cobra")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.initializeGame()
        enable_all_buttons()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didPress(_ sender: Any) {
        let button = sender as! UIButton
        print(button.currentTitle!)
        let letter = button.currentTitle!.first!
        
        if button == gameStatus {
            game.initializeGame()
        } else if !game.end {
            //check(letter: letter)
            button.isEnabled = false
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
    
    func replaceCharacter(_ str: String, _ index: Int, _ letter: Character) -> String {
       
        var tabChars = Array(str.characters)
        tabChars[index] = letter
        let newString = String(tabChars)
        
        return newString
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

