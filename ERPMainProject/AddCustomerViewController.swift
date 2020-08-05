//
//  AddCustomerViewController.swift
//  DummyERP
//
//  Created by Kardas Veeresham on 1/6/20.
//  Copyright © 2020 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class AddCustomerViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var customerNameView: UIView!
    @IBOutlet weak var customerNameTF: UITextField!
    @IBOutlet weak var customerEmailView: UIView!
    @IBOutlet weak var customerEmailTF: UITextField!
    @IBOutlet weak var customerMobileView: UIView!
    @IBOutlet weak var customerMobileTF: UITextField!
    @IBOutlet weak var customerPasswordView: UIView!
    @IBOutlet weak var customerPasswordTF: UITextField!
    @IBOutlet weak var customerAddressView: UIView!
    @IBOutlet weak var customerAddressTextView: UITextView!
    @IBOutlet weak var customerDOBView: UIView!
    @IBOutlet weak var customerDOBTF: UITextField!
    @IBOutlet weak var companyNameView: UIView!
    @IBOutlet weak var companyNameTF: UITextField!
    @IBOutlet weak var tradingNameView: UIView!
    @IBOutlet weak var tradingNameTF: UITextField!
    @IBOutlet weak var companyABNView: UIView!
    @IBOutlet weak var companyABNTF: UITextField!
    @IBOutlet weak var companyAddressTextView: UITextView!
    @IBOutlet weak var companyAddressView: UIView!
    @IBOutlet weak var companyTelephoneView: UIView!
    @IBOutlet weak var companyTelephoneTF: UITextField!
    @IBOutlet weak var companyMobileView: UIView!
    @IBOutlet weak var companyMobileTF: UITextField!
    @IBOutlet weak var postaladdressView: UIView!
    @IBOutlet weak var postalAddressTextView: UITextView!
    @IBOutlet weak var companyEmailView: UIView!
    @IBOutlet weak var companyEmailTF: UITextField!
    
    
     let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Design()
        showDatePicker()
        
        self.customerMobileTF.delegate = self
        self.customerMobileTF.tag = 11
        self.companyTelephoneTF.delegate = self
        self.companyTelephoneTF.tag = 12
        self.companyMobileTF.delegate = self
        self.companyMobileTF.tag = 13
    }
    
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //phone Number
        if textField.tag == 11 || textField.tag == 12 || textField.tag == 13  {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789").inverted
            let components = string.components(separatedBy: allowedCharacters)
            let filtered = components.joined(separator: "")
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return (newString.length <= maxLength && string == filtered)
            
        }
        return true
    }
    
    
    
    // MARK: - DatePicker
    func showDatePicker(){
        
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        self.customerDOBTF.inputAccessoryView = toolbar
        self.customerDOBTF.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.customerDOBTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    func Design(){
        self.customerNameView.layer.borderWidth = 1
        self.customerNameView.layer.borderColor = UIColor.lightGray
        self.customerNameView.layer.cornerRadius = 4
        self.customerEmailView.layer.borderWidth = 1
        self.customerEmailView.layer.borderColor = UIColor.lightGray
        self.customerEmailView.layer.cornerRadius = 4
        self.customerMobileView.layer.borderWidth = 1
        self.customerMobileView.layer.borderColor = UIColor.lightGray
        self.customerMobileView.layer.cornerRadius = 4
        self.customerPasswordView.layer.borderWidth = 1
        self.customerPasswordView.layer.borderColor = UIColor.lightGray
        self.customerPasswordView.layer.cornerRadius = 4
        self.customerAddressView.layer.borderWidth = 1
        self.customerAddressView.layer.borderColor = UIColor.lightGray
        self.customerAddressView.layer.cornerRadius = 4
        self.customerDOBView.layer.borderWidth = 1
        self.customerDOBView.layer.borderColor = UIColor.lightGray
        self.customerDOBView.layer.cornerRadius = 4
        self.companyNameView.layer.borderWidth = 1
        self.companyNameView.layer.borderColor = UIColor.lightGray
        self.companyNameView.layer.cornerRadius = 4
        self.tradingNameView.layer.borderWidth = 1
        self.tradingNameView.layer.borderColor = UIColor.lightGray
        self.tradingNameView.layer.cornerRadius = 4
        self.companyABNView.layer.borderWidth = 1
        self.companyABNView.layer.borderColor = UIColor.lightGray
        self.companyABNView.layer.cornerRadius = 4
        self.companyAddressView.layer.borderWidth = 1
        self.companyAddressView.layer.borderColor = UIColor.lightGray
        self.companyAddressView.layer.cornerRadius = 4
        self.companyTelephoneView.layer.borderWidth = 1
        self.companyTelephoneView.layer.borderColor = UIColor.lightGray
        self.companyTelephoneView.layer.cornerRadius = 4
        self.companyMobileView.layer.borderWidth = 1
        self.companyMobileView.layer.borderColor = UIColor.lightGray
        self.companyMobileView.layer.cornerRadius = 4
        self.postaladdressView.layer.borderWidth = 1
        self.postaladdressView.layer.borderColor = UIColor.lightGray
        self.postaladdressView.layer.cornerRadius = 4
        self.companyEmailView.layer.borderWidth = 1
        self.companyEmailView.layer.borderColor = UIColor.lightGray
        self.companyEmailView.layer.cornerRadius = 4
        if #available(iOS 13, *) {
                 self.companyNameTF.overrideUserInterfaceStyle = .light
                 self.tradingNameTF.overrideUserInterfaceStyle = .light
                 self.customerNameTF.overrideUserInterfaceStyle = .light
            self.companyEmailTF.overrideUserInterfaceStyle = .light
            self.companyMobileTF.overrideUserInterfaceStyle = .light
            self.companyTelephoneTF.overrideUserInterfaceStyle = .light
            
            
            
            self.customerNameTF.overrideUserInterfaceStyle = .light
                            self.customerDOBTF.overrideUserInterfaceStyle = .light
                            self.customerNameTF.overrideUserInterfaceStyle = .light
                       self.customerEmailTF.overrideUserInterfaceStyle = .light
                       self.customerMobileTF.overrideUserInterfaceStyle = .light
                       self.customerPasswordTF.overrideUserInterfaceStyle = .light
            self.customerAddressTextView.overrideUserInterfaceStyle = .light
                                       self.companyABNTF.overrideUserInterfaceStyle = .light
                                       self.companyAddressTextView.overrideUserInterfaceStyle = .light
                                  self.companyEmailTF.overrideUserInterfaceStyle = .light
             self.postaladdressView.overrideUserInterfaceStyle = .light
            
self.postalAddressTextView.overrideUserInterfaceStyle = .light
            
                 // use UICollectionViewCompositionalLayout
             } else {
                 // show sad face emoji
             }
    }
    
    // MARK: - ButtonActiones
    
   
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveBtnAction(_ sender: UIButton) {
        let messageSuccess = Validation()
        if messageSuccess == "" {
            if CheckInternet.Connection(){
                AddCustomerData()
            }else{
                Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
            }
        }
        else
        {
            Alert.showBasic(titte: "Alert", massage: messageSuccess, vc: self)
        }
        
    }
    
    // MARK: - Validation
    func Validation() -> String {
        var successMessage = ""
        if self.customerNameTF.text?.count == 0
        {
            successMessage = "Please Enter Customer Name"
            return successMessage
        }
        if self.customerEmailTF.text?.count == 0
        {
            successMessage = "Please Enter Customer Email"
            return successMessage
        }
        let email = self.customerEmailTF.text!
        if !email.isValidEmail  {
            successMessage = "Invalid Customer Email"
            return successMessage
        }
        if self.customerMobileTF.text?.count == 0
        {
            successMessage = "Please Enter Customer Mobile Number"
            return successMessage
        }
//        let customerMobile = self.customerMobileTF.text!
//        if !customerMobile.isValidPhoneNumber  {
//            successMessage = "Invalid Customer Mobile Number "
//            return successMessage
//        }
        if self.customerPasswordTF.text?.count == 0
        {
            successMessage = "Please Enter Customer Password"
            return successMessage
        }
        if self.customerAddressTextView.text?.count == 0
        {
            successMessage = "Please Enter Customer Address"
            return successMessage
        }
        if self.customerDOBTF.text?.count == 0
        {
            successMessage = "Please Enter Customer DOB"
            return successMessage
        }
        if self.companyNameTF.text?.count == 0
        {
            successMessage = "Please Enter Company Name"
            return successMessage
        }
        if self.tradingNameTF.text?.count == 0
        {
            successMessage = "Please Enter Company Trading Name"
            return successMessage
        }
        if self.companyABNTF.text?.count == 0
        {
            successMessage = "Please Enter Company ABN"
            return successMessage
        }
        if self.companyAddressTextView.text?.count == 0
        {
            successMessage = "Please Enter Company Address"
            return successMessage
        }
        if self.companyTelephoneTF.text?.count == 0
        {
            successMessage = "Please Enter Company telephone Number"
            return successMessage
        }
//        let companyTelephone = self.companyTelephoneTF.text!
//        if !companyTelephone.isValidPhoneNumber  {
//            successMessage = "Invalid Company telephone Number"
//            return successMessage
//        }
        if self.companyMobileTF.text?.count == 0
        {
            successMessage = "Please Enter Company Mobile Number"
            return successMessage
        }
//        let companyMobile = self.companyMobileTF.text!
//        if !companyMobile.isValidPhoneNumber  {
//            successMessage = "Invalid Company Mobile Number"
//            return successMessage
//        }
        if self.postalAddressTextView.text?.count == 0
        {
            successMessage = "Please Enter Company Postal Address"
            return successMessage
        }
        if self.companyEmailTF.text?.count == 0
        {
            successMessage = "Please Enter Company Email"
            return successMessage
        }
        let companyEmail = self.companyEmailTF.text!
        if !companyEmail.isValidEmail  {
            successMessage = "Invalid Company Email"
            return successMessage
        }
        return successMessage
    }
    
    
    
    
    // MARK: - Network
    
    func AddCustomerData(){
        
                let url : URL = URL(string: BaseUrl + "/add_customer")!
            let headerData = ["user_id":USERID,
            "user_type": USERTYPE,
            "customer_name": self.customerNameTF.text!,
            "customer_address": self.customerAddressTextView.text!,
            "customer_mobile":self.customerMobileTF.text!,
            "customer_email": self.customerEmailTF.text!,
            "user_password": self.customerPasswordTF.text!,
            "company_name":self.companyNameTF.text!,
            "trading_name": self.tradingNameTF.text!,
            "company_abn":self.companyABNTF.text!,
            "company_address":self.companyAddressTextView.text!,
            "company_telephone":self.companyTelephoneTF.text!,
            "company_mobile":self.companyMobileTF.text!,
            "postal_address":self.postalAddressTextView.text!,
            "company_email":self.companyEmailTF.text!,
            "customer_date_of_birth":self.customerDOBTF.text!,
            "comapny_logo":"0",
            "passport":"0",
            "electric":"0",
            "dl_front":"0",
        "dl_back":"0"]
               let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
             AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                                 print(response.request as Any)  // original URL request
                                 print(response.response as Any)// URL response
                                 let response1 = response.response
                                 if response1?.statusCode == 200
                                 {
                                      do{
                                          //categoryName
                                         let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                         print(jsonRespone)
                                        let item = jsonRespone as! NSDictionary
                                          let message = item["title"] as? String
                                        Alert.showBasic(titte: "Success", massage:  message ?? "" , vc: self)
                                    
                                         } catch let parsingError {
                                            print("Error", parsingError)
                                       }
                                    // let dataFromServer =
                                 }else{
                                    do{
                                          //categoryName
                                         let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                         print(jsonRespone)
                                        let item = jsonRespone as! NSDictionary
                                          let message = item["title"] as? String
//                                          Alert.showBasic(titte: "Alert", massage:  message ?? "" , vc: self)
                                        self.popUpAlert(title: "Success", message: message ?? "", actionTitle: ["OK"], actionStyle: [.default, .cancel ], action: [
                                                        { ok in
                                                            self.navigationController?.popViewController(animated: true)
                                                        },
                                                        { cancel in
                                        
                                                        }])
                                         } catch let parsingError {
                                            print("Error", parsingError)
                                       }
                                    
                }
                             }
                 }
}
