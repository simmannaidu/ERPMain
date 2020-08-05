//
//  UpdateProfileViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/31/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var firstnameView: UIView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var lastnameTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var browserButton: UIButton!
    @IBOutlet weak var updateProfileButton: UIButton!
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Design()
    }
    
    
    func Design()
    {
        self.firstnameView.layer.borderWidth = 1
        self.firstnameView.layer.borderColor = UIColor.lightGray
        self.firstnameView.layer.cornerRadius = 8
        
        self.lastNameView.layer.borderWidth = 1
        self.lastNameView.layer.borderColor = UIColor.lightGray
        self.lastNameView.layer.cornerRadius = 8
        
        self.emailView.layer.borderWidth = 1
        self.emailView.layer.borderColor = UIColor.lightGray
        self.emailView.layer.cornerRadius = 8
        
        self.cameraView.layer.borderWidth = 1
        self.cameraView.layer.borderColor = UIColor.lightGray
        self.cameraView.layer.cornerRadius = 8
        
        self.browserButton.layer.cornerRadius = 8
        self.updateProfileButton.layer.cornerRadius = 8
        
    }
    

    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateBtnAction(_ sender: UIButton) {
    }
}
