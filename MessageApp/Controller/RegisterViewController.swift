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
        // creates a new user
        if let email = emailRegister.text, let password = passwordRegister.text {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        
            if let e = error {
                // creartes alert if user doesn't use the correct legnth password
                let alert = UIAlertController(title: "Alert", message: "Password must be six characters long", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Re-enter", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print(e.localizedDescription)
            }  else {
                
                self.performSegue(withIdentifier: Const.registerSegue, sender: self)
            }
          }
        }
    }
    

}

