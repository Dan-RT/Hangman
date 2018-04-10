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
    
    
    let hangman_images = [#imageLiteral(resourceName: "Hangman0"), #imageLiteral(resourceName: "Hangman1"), #imageLiteral(resourceName: "Hangman2"), #imageLiteral(resourceName: "Hangman3"), #imageLiteral(resourceName: "Hangman4"), #imageLiteral(resourceName: "Hangman5"), #imageLiteral(resourceName: "Hangman6")]
    
    let game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.initializeGame()
        initializeView()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    func initializeView () {
        enable_all_buttons()
        word_label.text = game.replaceLetterByDots()
        image_gallows.image = hangman_images[0]
        gameStatus.setTitle("", for: .normal)
        gameStatus.isEnabled = false
        //JSonParser.retrieveJSon(urlString: "https://goo.gl/VGa6Xb")
    }

    
    @IBAction func indexChanged(_ sender: Any) {
        //alertBox()
        
        /*
         switch segmentedControl.selectedSegmentIndex {
         case 0:
         
         break
         case 1:
         
         break
         case 2:
         
         break
         default:
         <#code#>
         }
         */
    }
    
    func alertBox() {
        /*
        var refreshAlert = UIAlertController(title: "Change level", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)*/
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
            defineGameStatus()
            button.isEnabled = false
        }
    }
    
    func checkLetter (letter: Character) {
        if game.check(letter: letter) {     //if good letter
            word_label.text = game.replaceLetter(letter: letter, word: word_label.text!)
           
            /*let word_tmp = word_label.text
            let index_tmp = game.secret_word.index(of: letter)
            let index = game.secret_word.distance(from: game.secret_word.startIndex, to: index_tmp!)
            word_label.text = game.replaceCharacter(word_tmp!, index, letter)*/
        
        } else {
            image_gallows.image = hangman_images[7-game.attempts]
        }
        
        if game.checkEndGame() {
            gameStatus.isEnabled = true
        }
    }
    
    func defineGameStatus () {
        if game.end {
            if game.attempts == 1 {
                word_label.text = "GAME OVER"
            } else if game.letterToFind == 0 {
                word_label.text = "CONGRATS"
            }
            disable_all_buttons()
            gameStatus.isEnabled = true
            gameStatus.setTitle("Play Again", for: .normal)
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

