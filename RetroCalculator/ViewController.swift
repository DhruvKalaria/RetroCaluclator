//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Dhruv Kalaria on 8/21/17.
//  Copyright © 2017 Dhruv Kalaria. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!
    
    var currentOperation = Operator.Empty
    var runningNumber = ""
    var leftNumberStr = ""
    var rightNumberStr = ""
    var resultStr = ""
    
    enum Operator:String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLbl.text = ""
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let url = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: url)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.description)
        }
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operator) {
        playSound()
        
        if currentOperation != Operator.Empty {
            if runningNumber != "" {
                rightNumberStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operator.Multiply {
                    resultStr = "\(Double(leftNumberStr)! * Double(rightNumberStr)!)"
                } else if currentOperation == Operator.Divide {
                    resultStr = "\(Double(leftNumberStr)! / Double(rightNumberStr)!)"
                } else if currentOperation == Operator.Subtract {
                    resultStr = "\(Double(leftNumberStr)! - Double(rightNumberStr)!)"
                } else if currentOperation == Operator.Add {
                    resultStr = "\(Double(leftNumberStr)! + Double(rightNumberStr)!)"
                }
                leftNumberStr = resultStr
                outputLbl.text = resultStr
            }
        } else {
            leftNumberStr = runningNumber
            runningNumber = ""
        }
        currentOperation = operation
    }
}

