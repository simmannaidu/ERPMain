//
//  AddCategoryViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {

    @IBOutlet weak var categoryNameView: UIView!
    @IBOutlet weak var categoryNameTF: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var transView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        desien()
        
    }
    

    // MARK: - Desien
    func desien(){
        
        self.categoryNameView.layer.borderWidth = 1
        self.categoryNameView.layer.borderColor = UIColor.lightGray
        self.categoryNameView.layer.cornerRadius = 4

        self.saveButton.layer.cornerRadius = 4
    }
    
    
    
    // MARK: - ButtonActiones
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
    }
}
