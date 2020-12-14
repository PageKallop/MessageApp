//
//  MessageCell.swift
//  MessageApp
//
//  Created by Page Kallop on 12/13/20.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    
    @IBOutlet weak var labelText: UILabel!
    
  
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // rounds corners of message cell
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 9
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
