//
//  RegisterViewController.swift
//  MessageApp
//
//  Created by Page Kallop on 12/11/20.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailRegister: UITextField!
    
    @IBOutlet weak var passwordRegister: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        if let email = emailRegister.text, let password = passwordRegister.text {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            //CREATE POPUP FOR ERROR
            if let e = error {
                print(e.localizedDescription)
            }  else {
                
                self.performSegue(withIdentifier: Const.registerSegue, sender: self)
            }
          }
        }
    }
    

}

