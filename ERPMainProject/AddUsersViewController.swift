//
//  AddUsersViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 12/2/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire

class AddUsersViewController: UIViewController, UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var userTypeView: UIView!
    @IBOutlet weak var userTypeTF: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addAnotherButton: UIButton!
    @IBOutlet weak var transView: UIView!
    
    var pickerView = UIPickerView()
    var currentTextField = UITextField()
    var selectProyarity: String?
     var selectProyarityid: String?
     var usertypeId: String?
     let userTypes = ["Admin","User","Sales person"]
     let userTypesId = ["1","2","4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.transView.isHidden = true
        self.userTypeTF.delegate = self
        desien()
        dismissPickerView()
    }
    
    
    func desien(){
        
        self.firstNameView.layer.borderWidth = 1
        self.firstNameView.layer.borderColor = UIColor.lightGray
        self.firstNameView.layer.cornerRadius = 4
        
        self.lastNameView.layer.borderWidth = 1
        self.lastNameView.layer.borderColor = UIColor.lightGray
        self.lastNameView.layer.cornerRadius = 4
        
        self.emailView.layer.borderWidth = 1
        self.emailView.layer.borderColor = UIColor.lightGray
        self.emailView.layer.cornerRadius = 4
        
        self.passwordView.layer.borderWidth = 1
        self.passwordView.layer.borderColor = UIColor.lightGray
        self.passwordView.layer.cornerRadius = 4
        
        self.userTypeView.layer.borderWidth = 1
        self.userTypeView.layer.borderColor = UIColor.lightGray
        self.userTypeView.layer.cornerRadius = 4
        
        
        
        self.saveButton.layer.cornerRadius = 4
        self.addAnotherButton.layer.cornerRadius = 4
    }
    
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == self.userTypeTF{
            currentTextField.inputView = pickerView
        }
    }
    
    
    
    // MARK: - PickerView
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == self.userTypeTF{
            return self.userTypes.count
        }
        else{
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == self.userTypeTF{
            self.selectProyarity = self.userTypes[row]
            self.selectProyarityid = self.userTypesId[row]
            return self.userTypes[row]
        }
        else{
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == self.userTypeTF{
            self.selectProyarity = self.userTypes[row]
             self.selectProyarityid = self.userTypesId[row]
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
        
        self.userTypeTF.inputAccessoryView = toolBar
        
    }
    
    @objc func doneButtonAction()
    {
        if currentTextField == self.userTypeTF{
            self.userTypeTF.text =  self.selectProyarity
           self.usertypeId = self.selectProyarityid
             self.view.endEditing(true)
        }
    }

    // MARK: - ButtonActiones
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        let successMsg = self.Validation()
        if successMsg.isEmpty {
            
            if CheckInternet.Connection(){
                DataInAddUser()
            }else{
                Alert.showBasic(titte: "Alert", massage: "Your Device is not connected with internet", vc: self)
            }
        }
        else{
            self.popUpAlert(title: "Validation Fail", message: successMsg, actionTitle: ["OK"], actionStyle: [.default, .cancel ], action: [
                            { ok in
            
                            },
                            { cancel in
            
                            }])
        }
    }
    
    @IBAction func addAnotherbtnAction(_ sender: Any) {
        
    }
    
    
    
    // MARK: - Validation
    func Validation() -> String {
        
        var successMessage = String()
        if firstNameTF.text == ""
        {
            successMessage = "Please Enter First Name"
            return successMessage
        }
        if lastNameTF.text == ""
        {
            successMessage = "Please Enter Last Name"
            return successMessage
        }
        let email = emailTF.text!
        if !email.isValidEmail  {
            successMessage = "Invalid Email"
            return successMessage
        }
        
        if passwordTf.text == ""
        {
            successMessage = "Please Enter Password"
            return successMessage
        }
        if userTypeTF.text == ""
        {
            successMessage = "Please Enter User Type"
            return successMessage
        }
        
        return successMessage
        }
    
    
    
    // MARK: - Network
    //sudhakar nayak 5:38 PM
    //https://ayersfood.com/erpapi/api/Rolelist
    
    func DataInAddUser(){
        
        showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string:"https://ayersfood.com/erpapi/api/Adduser")!
            //BaseUrl + "/Adduser")!
        let headerData = ["user_type":"1","customer_id" : USERID,"first_name":self.firstNameTF.text as Any, "last_name":self.lastNameTF.text as Any, "email":self.emailTF.text as Any, "password":self.passwordTf.text as Any, "user_typeVal":self.usertypeId as Any] as [String : Any]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
            
            DispatchQueue.main.async {
                self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                let response1 = response.response
                if response1?.statusCode == 200
                {
                    do{
                        let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                        print(jsonRespone)
                        
                     Alert.showBasic(titte: "Success", massage: "Successfully Added.", vc: self)
                        
                        
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                    
                }
                else
                {
                   Alert.showBasic(titte: "Sorry", massage: "Try Again", vc: self)
                }
            }
        }
    }
/*sudhakar nayak [5:17 PM]
https://ayersfood.com/erpapi/api/Addusersudhakar nayak [5:31 PM]
{"user_type":"1",
"customer_id":"ZPYJ2DYWK43MDIF",
"user_typeVal":"2",
"first_name":"smithdev",
"last_name":"ching",
"email":"smith00652@gmail.com",
"password":"123456"}*/
    
}
