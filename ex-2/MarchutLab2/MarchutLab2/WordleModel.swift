//
//  WordleModel.swift
//  MarchutLab2
//
//  Created by Jakub Marchut on 25/03/2024.
//

import Cocoa

class WordleModel : NSObject{
    
    private var numberToGuess = "12345"
    private var guessedNumber = [String]()
    enum WordleField {
        case empty
        case correct
        case misplaced
        case incorrect
    }
    private var boardState = [WordleField]()
    
    
    private var currRow: Int = -1
    
    
    init(numberToGuess: String){
        self.numberToGuess = numberToGuess
        let length = numberToGuess.count
        self.guessedNumber = Array(repeating: "", count: length)
        self.boardState = Array(repeating: WordleField.empty, count: length)
    }
    
    func checkGuess() -> [WordleField]{
        for (i, char) in self.numberToGuess.enumerated(){
            if String(char) == guessedNumber[i]{
                self.boardState[i] = WordleField.correct
            }
            else if self.numberToGuess.contains(guessedNumber[i]){
                self.boardState[i] = WordleField.misplaced
            }
            else{
                self.boardState[i] = WordleField.incorrect
            }
        }
        return self.boardState
    }
    
    func changeCol(newColNumber: Int){
        currRow = newColNumber
    }
    
    func numberBtn(_ numberPushed: String) -> [String]{
        if currRow != -1{
            guessedNumber[currRow] = numberPushed
        }
        
        return guessedNumber
    }
    
    func resetRows(){
        currRow = -1
        let length = self.numberToGuess.count
        self.guessedNumber = Array(repeating: "", count: length)
        self.boardState = Array(repeating: WordleField.empty, count: length)
    }
}
