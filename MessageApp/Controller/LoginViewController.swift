//
//  LoginViewController.swift
//  MessageApp
//
//  Created by Page Kallop on 12/11/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

   
    @IBOutlet weak var emailLogin: UITextField!
    
    @IBOutlet weak var passwordLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
       
        // allows user to log in
        if let email = emailLogin.text, let password = passwordLogin.text {
            
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            //CREATE ALERT
            if let e = error {
                //creates an alert if user enters incorrect email or password
                let alert = UIAlertController(title: "Alert", message: "Email or Password is incorrect", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Re-Enter User Info", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(e)
            } else {
                self.performSegue(withIdentifier: Const.loginSegue, sender: self)
            }
            
        }
    }
 }

}
