//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Ken Porter on 2016-11-18.
//  Copyright © 2016 Ken Porter. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
    
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
        
        outputLabel.text = "0"
    }

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed( sender: UIButton) {
        processOperation(operation: Operation.Divide)
        
    }
    
    @IBAction func onMulitplePressed( sender: UIButton) {
        processOperation(operation: Operation.Multiply)
        
    }
    
    @IBAction func onAddPressed( sender: UIButton) {
        processOperation(operation: Operation.Add)
        
    }
    
    @IBAction func onSubtractPressed( sender: UIButton) {
        processOperation(operation: Operation.Subtract)
        
    }
    
    @IBAction func onEqualPressed( sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    
    
    @IBAction func onClearPressed(_ sender: UIButton) {
    }
    
    
    
    
    
    
    
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
    func processOperation(operation: Operation){
        
        playSound()
        
        if currentOperation != Operation.Empty {
            
            // runnign number can be "" if two oerators are hit in a row
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    
                }
                
                leftValStr = result
                outputLabel.text = result
                
            }
            
            currentOperation = operation
            
        } else {
            // the first time operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation

        }

    }
    
}

