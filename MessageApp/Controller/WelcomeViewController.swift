//
//  ViewController.swift
//  MessageApp
//
//  Created by Page Kallop on 12/11/20.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var realTalkLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        // animated title 
        realTalkLabel.text = ""
        
        var characterIndex = 0.0
        
        let titleText = "Real Talk"
        
        for letter in titleText {
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * characterIndex, repeats: false) { (timer) in
                self.realTalkLabel.text?.append(letter)
            }
            
            characterIndex += 1
    
        }
        
    }
    
    


}

