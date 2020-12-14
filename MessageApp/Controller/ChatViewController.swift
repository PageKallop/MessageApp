//
//  ChatViewController.swift
//  MessageApp
//
//  Created by Page Kallop on 12/11/20.
//

import UIKit
import Firebase


class ChatViewController : UIViewController {
    
    @IBOutlet weak var textTableView: UITableView!
    
    @IBOutlet weak var textBox: UITextView!
    
    
    let db = Firestore.firestore()
    
    // Creates and empty array from the array struct
    
    var messages: [Message] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textTableView.dataSource = self
        // edits to the nav bar
        navigationItem.hidesBackButton = true 
        
        self.textTableView.separatorStyle = .none
        
        //register message cell xib
        
        textTableView.register(UINib(nibName: Const.cellNibName, bundle: nil), forCellReuseIdentifier: Const.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages(){
        
        
        // call messages from Firebase ordered by most recent
        db.collection(Const.FStore.collectionName)
            .order(by: Const.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
             // emptys array so only new messages load
            self.messages = []
            
            if let e = error {
                print("error retrievingn error \(e)")
            } else {
                if let snapShotDoc = querySnapshot?.documents {
                    for doc in snapShotDoc {
                        let data = doc.data()
                        if let messageSender = data[Const.FStore.senderField] as? String, let messageBody = data[Const.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            //reloads table view
                            DispatchQueue.main.async {
                                self.textTableView.reloadData()
                                
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.textTableView.scrollToRow(at: indexPath, at: .top, animated: true )
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendTextButton(_ sender: UIButton) {
        
        // Authenticates user and saves data
        if let messageBody = textBox.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(Const.FStore.collectionName).addDocument(data: [Const.FStore.senderField: messageSender,
                Const.FStore.bodyField: messageBody,
                Const.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("Issue saving data \(e)")
                } else {
                    print("Saved data")
                    
                    //empty text field 
                    DispatchQueue.main.async {
                        self.textBox.text = ""
                    }
                }
            }
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        // allows user to log out
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            // returns user to root vc
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
//MARK: - TableView Protocal
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as! MessageCell
        cell.labelText.text = message.body
        
        //creates message cell for current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(red: 69.9/255.0, green: 61.2/255.0, blue: 85.1/255.0, alpha: 0.2)
            cell.labelText.textColor = .darkGray
            
        }
        
        //creates message cell for user they are talking to
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(red: 69.9/255.0, green: 61.2/255.0, blue: 85.1/255.0, alpha: 1)
            cell.labelText.textColor = .lightGray
        }
        
        return cell
    }
    
}



