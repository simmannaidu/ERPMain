//
//  CustomerSupportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class CustomerSupportViewController: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var productReturnView: UIView!
    @IBOutlet weak var productReturnTF: UITextField!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var transView: UIView!
    
    var pickerView = UIPickerView()
    var currentTextField = UITextField()
    var selectProyarity: String?
     var selectProyarityid: String?
     var productReturnId: String?
     let productReturnArray = ["Admin","User","Sales person"]
     let productReturnIdArray = ["1","2","4"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.transView.isHidden = true
        self.productReturnTF.delegate = self
        Design()
        dismissPickerView()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == self.productReturnTF{
            currentTextField.inputView = pickerView
        }
    }
   
    // MARK: - Design
    func Design(){
        
        self.productReturnView.layer.borderWidth = 1
        self.productReturnView.layer.borderColor = UIColor.customBlue
        self.productReturnView.layer.cornerRadius = 8
        
        self.messageView.layer.borderWidth = 1
        self.messageView.layer.borderColor = UIColor.customBlue
        self.messageView.layer.cornerRadius = 8
    }

    
    
    // MARK: - PickerView
       
       
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           if currentTextField == self.productReturnTF{
               return self.productReturnArray.count
           }
           else{
               return 0
           }
       }
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           if currentTextField == self.productReturnTF{
               self.selectProyarity = self.productReturnArray[row]
               self.selectProyarityid = self.productReturnIdArray[row]
               return self.productReturnArray[row]
           }
           else{
               return ""
           }
           
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           if currentTextField == self.productReturnTF{
               self.selectProyarity = self.productReturnArray[row]
                self.selectProyarityid = self.productReturnIdArray[row]
           }
       }
       
       
       
       
       func dismissPickerView()
       {
           
           let toolBar = UIToolbar()
           toolBar.sizeToFit()
           
           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
           let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           
           toolBar.setItems([flexibleSpace, doneButton], animated: false)
           toolBar.isUserInteractionEnabled = true
           
           self.productReturnTF.inputAccessoryView = toolBar
           
       }
       
       @objc func doneButtonAction()
       {
           if currentTextField == self.productReturnTF{
               self.productReturnTF.text =  self.selectProyarity
              self.productReturnId = self.selectProyarityid
                self.view.endEditing(true)
           }
       }

    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        
    }
}
