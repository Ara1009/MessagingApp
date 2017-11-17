//
//  SearchCell.swift
//  Messaging
//
//  Created by Aravind Subramanian on 11/17/17.
//  Copyright © 2017 Aravind Subramanian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper


class SearchCell: UITableViewCell {

    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var nameLbl:UILabel!
    
    var searchDetail: Search!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(searchDetail: Search) {
        
        self.searchDetail = searchDetail
        
        
        
    }

}







