//
//  ChangePasswordViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/31/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var oldPasswordView: UIView!
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordView: UIView!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var reTypePasswordView: UIView!
    @IBOutlet weak var reTypePasswordTF: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Design()
    }
    
    // MARK: - Design
    func Design()
    {
        self.emailView.layer.borderWidth = 1
        self.emailView.layer.borderColor = UIColor.lightGray
        self.emailView.layer.cornerRadius = 8
        
        self.oldPasswordView.layer.borderWidth = 1
        self.oldPasswordView.layer.borderColor = UIColor.lightGray
        self.oldPasswordView.layer.cornerRadius = 8
        
        self.newPasswordView.layer.borderWidth = 1
        self.newPasswordView.layer.borderColor = UIColor.lightGray
        self.newPasswordView.layer.cornerRadius = 8
        
        self.reTypePasswordView.layer.borderWidth = 1
        self.reTypePasswordView.layer.borderColor = UIColor.lightGray
        self.reTypePasswordView.layer.cornerRadius = 8
        
        
        self.saveButton.layer.cornerRadius = 8
        
    }

    // MARK: - ButtonActions
    @IBAction func BackBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
    }
}
