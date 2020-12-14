//
//  ViewController.swift
//  MessageApp
//
//  Created by Page Kallop on 12/11/20.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var realTalkLabel: UILabel!
    
    
    //hides root vc navbar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // allows the navbar to appear on next screeen
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
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

