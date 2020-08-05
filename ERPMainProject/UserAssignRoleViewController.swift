//
//  UserAssignRoleViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/31/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class UserAssignRoleViewController: UIViewController , UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
var roleList = [NSDictionary]()
    var dataForUser = [NSDictionary]()
    var dataForRoles1 = [NSDictionary]()
    var dataForUserName = [String]()
     var dataForUserRole = [String]()
    var pickerView = UIPickerView()
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var roleNameView: UIView!
    @IBOutlet weak var roleNameTF: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var currentTextField = UITextField()
       var selectProyarity: String?
        var selectProyarityid: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        Design()
        self.roleNameTF.delegate = self
        self.pickerView.delegate = self
        self.userTF.delegate = self
       
        self.getMessageUsersData()
        dismissPickerView()
    }
    

    // MARK: - Design
    func Design()
    {
        self.userView.layer.borderWidth = 1
        self.userView.layer.borderColor = UIColor.lightGray
        self.userView.layer.cornerRadius = 8
        
        self.roleNameView.layer.borderWidth = 1
        self.roleNameView.layer.borderColor = UIColor.lightGray
        self.roleNameView.layer.cornerRadius = 8
        
        self.resetButton.layer.cornerRadius = 8
        self.saveButton.layer.cornerRadius = 8
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == self.userTF{
            currentTextField.inputView = pickerView
        }
        else
        {
            self.currentTextField.inputView = pickerView
        }
    }
    // MARK: - PickerView
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == self.userTF{
            return self.dataForUserName.count
        }
        else{
            return self.dataForUserRole.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == self.userTF{
            self.selectProyarity = self.dataForUserName[row]
            self.selectProyarityid = self.dataForUserName[row]
            return self.dataForUserName[row]
            
        }
        else{
            self.selectProyarity = self.dataForUserRole[row]
            self.selectProyarityid = self.dataForUserRole[row]
            return self.dataForUserRole[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == self.userTF{
            self.selectProyarity = self.dataForUserName[row]
            self.selectProyarityid = self.dataForUserName[row]
        
        }
        else
        {
            self.selectProyarity = self.dataForUserRole[row]
            self.selectProyarityid = self.dataForUserRole[row]
           
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
        
        self.roleNameTF.inputAccessoryView = toolBar
        self.userTF.inputAccessoryView = toolBar
        
    }
    
    @objc func doneButtonAction()
    {
        if currentTextField == self.userTF{
            self.userTF.text =  self.selectProyarity
            // self.usertypeId = self.selectProyarityid
               self.view.endEditing(true)
        }
        else
        {
            self.roleNameTF.text =  self.selectProyarity
            // self.usertypeId = self.selectProyarityid
               self.view.endEditing(true)
            
        }
    }

    
     // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func resetBtnAction(_ sender: UIButton) {
        
    }
    @IBAction func saveBtnAction(_ sender: UIButton) {
        let successMsg = self.Validation()
               if successMsg.isEmpty {
                   
                   if CheckInternet.Connection(){
                      assienRoleData()
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
    // MARK: - Validation
       func Validation() -> String {
           
           var successMessage = String()
           if userTF.text == ""
           {
               successMessage = "Please Select User Name"
               return successMessage
           }
           if roleNameTF.text == ""
           {
               successMessage = "Please Select User Role "
               return successMessage
           }
               return successMessage
           }
       
    
    //MARK: - Network
    func getRoleListing()
    {
      // showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/manageuser")!
let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
            
            DispatchQueue.main.async {
                //self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                let response1 = response.response
                if response1?.statusCode == 200
                {
                    do{
                        let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                        print(jsonRespone)
                        self.dataForUser = jsonRespone["user_list"] as! [NSDictionary]
                        self.dataForUserName.removeAll()
                        for item in self.dataForUser
                        {
                            let name = "\(item["first_name"] ?? "") \(item["last_name"] ?? "")"
                            self.dataForUserName.append(name)
                        }
                       /* date_of_birth" = 0;
                        "first_name" = "Ayers Rock ";
                        gender = 0;
                        "last_name" = Trading;
                        logo = "http://lanciusit.com/erpretail/assets/dist/img/profile_picture/ac88790a2b1efe27af17459e7588df08.png";
                        status = 0;
                        "user_id" = 1;*/
                        self.pickerView.reloadAllComponents()
                   //  Alert.showBasic(titte: "Success", massage: "", vc: self)
                        
                        
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                    
                }
            }
        }
    }
    
    func getMessageUsersData(){
          // showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
           let url : URL = URL(string: BaseUrl + "/Rolelist")!
          let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
               
               DispatchQueue.main.async {
            //   self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
               let response1 = response.response
               if response1?.statusCode == 200
               {
                   do{
                     self.getRoleListing()
                    let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                       print(jsonRespone)
                      // var items12 = NSDictionary()
                     //  items12 = jsonRespone as! NSDictionary
                       self.dataForRoles1 = jsonRespone["user_list"] as! [NSDictionary]
                    self.dataForUserRole.removeAll()
                    /*{
                        id = 16;
                        type = bbbb;
                    }*/
                    for item in self.dataForRoles1
                    {
                        let name = "\(item["type"] ?? "")"
                        self.dataForUserRole.append(name)
                    }
                     self.pickerView.reloadAllComponents()
                       //dataForUserRole
//                      if self.dataForTableView.count == 0
//                      {
//                       self.ManageUsersTableView.isHidden = true
//                       self.noRecordsLabel.isHidden = false
//                      }else{
//                       self.ManageUsersTableView.isHidden = false
//                       self.noRecordsLabel.isHidden = true
//                       }
//
//                       self.ManageUsersTableView.reloadData()
                       
                   } catch let parsingError {
                       print("Error", parsingError)
                   }
                   
               }
           }
           }
       }
    
    
    func assienRoleData()
      {
        // showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
          let url : URL = URL(string: BaseUrl + "/roleassign")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
         let headerData = ["user_type":"","customer_id":"","userval_val":"","role_id":""]
          AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
              
              DispatchQueue.main.async {
                  //self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                  let response1 = response.response
                  if response1?.statusCode == 200
                  {
                      do{
                          let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                          print(jsonRespone)
                          
                          
                      } catch let parsingError {
                          print("Error", parsingError)
                      }
                      
                  }
              }
          }
      }
}
