//
//  SearchVC.swift
//  Messaging
//
//  Created by Aravind Subramanian on 11/17/17.
//  Copyright © 2017 Aravind Subramanian. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SearchVC: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func goBack(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
    }

}
