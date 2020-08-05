//
//  CustomerReceiveViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class CustomerReceiveViewController: UIViewController {

    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var customerTF: UITextField!
    @IBOutlet weak var voucherView: UIView!
    @IBOutlet weak var voucherTF: UITextField!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var paymentMethodView: UIView!
    @IBOutlet weak var paymentTf: UITextField!
    @IBOutlet weak var remarkView: UIView!
    @IBOutlet weak var remarkTextView: UITextView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var transView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
  self.transView.isHidden = true
        desien()
    }
    

    // MARK: - Desien
    func desien(){
        
        self.customerView.layer.borderWidth = 1
        self.customerView.layer.borderColor = UIColor.lightGray
        self.customerView.layer.cornerRadius = 4
        
        self.voucherView.layer.borderWidth = 1
        self.voucherView.layer.borderColor = UIColor.lightGray
        self.voucherView.layer.cornerRadius = 4
        
        self.amountView.layer.borderWidth = 1
        self.amountView.layer.borderColor = UIColor.lightGray
        self.amountView.layer.cornerRadius = 4
        
        self.dateView.layer.borderWidth = 1
        self.dateView.layer.borderColor = UIColor.lightGray
        self.dateView.layer.cornerRadius = 4
        
        self.paymentMethodView.layer.borderWidth = 1
        self.paymentMethodView.layer.borderColor = UIColor.lightGray
        self.paymentMethodView.layer.cornerRadius = 4
        
        self.remarkView.layer.borderWidth = 1
        self.remarkView.layer.borderColor = UIColor.lightGray
        self.remarkView.layer.cornerRadius = 4
        
        self.submitButton.layer.cornerRadius = 4
    }
    
    
 // MARK: - ButtonActiones
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func customerPickerBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func datePickerBtnAction(_ sender: UIButton) {
    }
    @IBAction func paymentMethodPickerBtnAction(_ sender: UIButton) {
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
    }
}
