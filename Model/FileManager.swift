//
//  FileManager.swift
//  Hangman
//
//  Created by Daniel Regnard on 06/04/2018.
//  Copyright © 2018 Daniel Regnard. All rights reserved.
//

import Foundation

class FileManager {
    
    static func arrayFromContentsOfFileWithName(fileName: String) -> String? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            return content
        } catch _ as NSError {
            return nil
        }
    }
    
}
