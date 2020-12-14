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
    
    @IBOutlet weak var textBox: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textTableView.dataSource = self
        
        navigationItem.hidesBackButton = true 
        
        self.textTableView.separatorStyle = .none
        
        textTableView.register(UINib(nibName: Const.cellNibName, bundle: nil), forCellReuseIdentifier: Const.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages(){
        
        db.collection(Const.FStore.collectionName)
            .order(by: Const.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
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
                            
                            DispatchQueue.main.async {
                                self.textTableView.reloadData()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendTextButton(_ sender: UIButton) {
        
        if let messageBody = textBox.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(Const.FStore.collectionName).addDocument(data: [Const.FStore.senderField: messageSender,
                Const.FStore.bodyField: messageBody,
                Const.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("Issue saving data \(e)")
                } else {
                    print("Saved data")
                }
            }
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.cellIdentifier, for: indexPath) as! MessageCell
        cell.labelText.text = messages[indexPath.row].body
        
        return cell
    }
    
}



