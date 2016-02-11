//
//  ViewController.swift
//  Project8
//
//  Created by Jacques on 11/02/16.
//  Copyright © 2016 J4SOFT. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!

    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: "letterTapped:", forControlEvents: .TouchUpInside)
        }
        
        loadLevel(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitTapped(sender: AnyObject) {
        if let solutionPosition = solutions.indexOf(currentAnswer.text!) {
            activatedButtons.removeAll()
            
            var splitCues = answerLabel.text!.componentsSeparatedByString("\n")
            
            splitCues[solutionPosition] = currentAnswer.text!
            answerLabel.text = splitCues.joinWithSeparator("\n")
            
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let alertController = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "Let's go", style: .Default, handler:
                    { [unowned self] (action: UIAlertAction) -> Void in
                        self.loadLevel(action)
                    }))
                presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }

    @IBAction func clearTapped(sender: AnyObject) {
        currentAnswer.text = ""
        for button in activatedButtons {
            button.hidden = false
        }
        activatedButtons.removeAll()
    }
    
    func loadLevel(action: UIAlertAction?) {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFilePath = NSBundle.mainBundle().pathForResource("Level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath, usedEncoding: nil) {
                var lines = levelContents.componentsSeparatedByString("\n")
                
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(lines) as! [String]
                
                for (index, line) in lines.enumerate() {
                    let parts = line.componentsSeparatedByString(": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.stringByReplacingOccurrencesOfString("|", withString: "")
                    solutionString += "\(solutionWord.characters.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.componentsSeparatedByString("|")
                    letterBits += bits
                }
            }
        }
        
        // Now configure the buttons and labels
        
        cluesLabel.text = clueString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        answerLabel.text = solutionString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterBits) as! [String]
        letterButtons = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterButtons) as! [UIButton]
        
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], forState: .Normal)
            }
        }
    }
    
    func letterTapped(button: UIButton) {
        currentAnswer.text = currentAnswer.text! + button.titleLabel!.text!
        activatedButtons.append(button)
        button.hidden = true
    }
    
    func levelUp() {
        level += 1
        solutions.removeAll(keepCapacity: true)
        
        loadLevel(nil)
        
        for button in letterButtons {
            button.hidden = false
        }
    }
}

