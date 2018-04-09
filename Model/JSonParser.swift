//
//  JSonParser.swift
//  Hangman
//
//  Created by Daniel Regnard on 06/04/2018.
//  Copyright © 2018 Daniel Regnard. All rights reserved.
//

import Foundation

class JSonParser {

    static func retrieveJSon (urlString: String) {
        
        if let url = URL (string: urlString)
        {
            URLSession.shared.dataTask(with: url)
            { (myData, response, error) in
                
                //Plus ou moins un inverse de if, permet de "garder" une fonction
                guard let myData = myData , error == nil else
                {
                    print("error")
                    return
                }
                
                do
                {
                    let root = try JSONSerialization.jsonObject(with: myData, options: .allowFragments)
                    if let json = root as? [[String: AnyObject]]
                    {
                        print("Il y a \(json.count) mots dans la liste")
                        for item in json
                        {
                            if let word = item["values"]
                            {
                                print("\(word)")
                            }
                        }
                    }
                }
                catch
                {
                    print("Erreur parse")
                }
                
                }.resume()
        }
        
    }
    
}

