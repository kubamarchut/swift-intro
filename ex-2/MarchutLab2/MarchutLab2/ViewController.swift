//
//  ViewController.swift
//  MarchutLab2
//
//  Created by Jakub Marchut on 25/03/2024.
//

import Cocoa

class ViewController: NSViewController {
    
    var wordleModel = WordleModel(numberToGuess: "12345")
    
    @IBOutlet weak var numberFieldGrid: NSGridView!
    @IBOutlet weak var numberBtnsGrid: NSGridView!
    @IBOutlet weak var checkBtn: NSButton!
    
    var numberFields = [NSTextField]()
    var rowMarkers = [NSTextField]()
    var numberButtons = [NSButton]()
    var colButtons = [NSButton]()
    var results = [Int]()
    var currRow = 0
    
    
    func loadColMarkers(){
        for i in 0..<5 {
            let newRowMarker = numberFieldGrid.cell(atColumnIndex: i, rowIndex: 1).contentView as! NSTextField
            rowMarkers.append(newRowMarker)
        }
    }
    
    func loadColBtns(){
        for i in 0..<5 {
            let newColBtn = numberFieldGrid.cell(atColumnIndex: i, rowIndex: 2).contentView as! NSButton
            newColBtn.target = self
            newColBtn.action = #selector(buttonColPressed(_:))
            colButtons.append(newColBtn)
        }
    }
    
    func loadNumberFields(){
        for i in 0..<5 {
            let newNumberField = numberFieldGrid.cell(atColumnIndex: i, rowIndex: 0).contentView as! NSTextField
            numberFields.append(newNumberField)
        }
    }
    
    func loadNumberBtns(){
        for i in 0..<10 {
            let newNumberBtn = numberBtnsGrid.cell(atColumnIndex: i % 5, rowIndex: i / 5).contentView as! NSButton
            newNumberBtn.target = self
            newNumberBtn.action = #selector(buttonPressed(_:))
            numberButtons.append(newNumberBtn)
        }
    }
    func markRowMarker(_ rowN: Int){
        colButtons[rowN].layer?.backgroundColor = NSColor.red.cgColor
    }
    func resetRowMarkers(){
        for i in 0..<rowMarkers.count{
            colButtons[i].layer?.backgroundColor = NSColor.clear.cgColor
        }
    }
    func clearNumberFields(){
        for i in 0..<numberFields.count{
            numberFields[i].stringValue = ""
        }
    }
    func updateFields(guessedNumber: [String]){
        for (i, char) in guessedNumber.enumerated(){
            numberFields[i].stringValue = char
        }
    }
    func markFields(_ board: [WordleModel.WordleField]){
        for (i, state) in board.enumerated(){
            if state == WordleModel.WordleField.correct{
                numberFields[i].backgroundColor = NSColor.green
            }
            else if state == WordleModel.WordleField.incorrect{
                numberFields[i].backgroundColor = NSColor.lightGray
            }
            else if state == WordleModel.WordleField.misplaced{
                numberFields[i].backgroundColor = NSColor.orange
            }
        }
    }
    func resetMarkFields(){
        for field in numberFields{
            field.backgroundColor = NSColor.clear
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNumberFields()
        loadColMarkers()
        loadNumberBtns()
        loadColBtns()
    }
    
    @IBAction func buttonPressed(_ btn: NSButton){
        let guessedNumber = wordleModel.numberBtn(btn.title)
        
        updateFields(guessedNumber: guessedNumber)
    }
    @IBAction func buttonColPressed(_ btn: NSButton){
        if let choosenCol = colButtons.firstIndex(of: btn){
            wordleModel.changeCol(newColNumber: choosenCol)
            resetRowMarkers()
            markRowMarker(choosenCol)
        }
    }
    @IBAction func checkBtnPress(_ sender: Any) {
        let board = wordleModel.checkGuess()
        
        markFields(board)
    }
    @IBAction func clearBtnPressed(_ sender: Any) {
        wordleModel.resetRows()
        resetRowMarkers()
        resetMarkFields()
        clearNumberFields()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

