//
//  Const.swift
//  MessageApp
//
//  Created by Page Kallop on 12/13/20.
//

import Foundation

struct Const {
    
   static let cellIdentifier = "textCell"
   static let cellNibName = "MessageCell"
   static let registerSegue = "RegisterToChat"
   static let loginSegue = "LoginToChat"
    
    struct FStore {
        static let collectionName = "message"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date" 
    }
}
