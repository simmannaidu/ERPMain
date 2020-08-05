//
//  MessageDetailsViewController.swift
//  DummyERP
//
//  Created by Kardas Veeresham on 1/8/20.
//  Copyright © 2020 infinity Smart Solutions. All rights reserved.
//

import UIKit

class MessageDetailsViewController: UIViewController {

    var messagedetailStr = String()
    var messageTitleStr = String()
    @IBOutlet weak var messagetitleLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

   self.messageTextView.isUserInteractionEnabled = false
        self.messageTextView.text = self.messagedetailStr
        self.messagetitleLabel.text = self.messageTitleStr
    }
    

   // MARK: - BackBtnAction
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
}
