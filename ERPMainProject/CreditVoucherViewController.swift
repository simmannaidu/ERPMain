//
//  CreditVoucherViewController.swift
//  ERP
//
//  Created by Hari on 21/01/20.
//  Copyright © 2020 Lancius. All rights reserved.
//

import UIKit
import Alamofire
class CreditVoucherViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate {
    @IBOutlet weak var nameOfAccountTF: UITextField!
    @IBOutlet weak var totalAmountTF: UITextField!
    @IBOutlet weak var remarkTV: UITextView!
    @IBOutlet weak var sepplierNameTF: UITextField!
    @IBOutlet weak var VocherNoText: UITextField!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var selectDate: UITextField!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    var currentTextField = UITextField()
     let datePicker = UIDatePicker()
    let pickerView = UIPickerView()
    var supplierArray = [NSDictionary]()
    var nameOfAccountArray = [NSDictionary]()
    var selectProyarity = String()
    var nameOfAccountDic = NSDictionary()
    var typeOfDic = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getNotification()
        self.toSetBoaderColor()
        self.getDataForSupplierList()
        self.VocherNoText.setDarkModeToNormal()
        self.nameOfAccountTF.setDarkModeToNormal()
        self.selectDate.setDarkModeToNormal()
        self.remarkTV.setDarkModeToNormal()
        self.totalAmountTF.setDarkModeToNormal()
        self.sepplierNameTF.setDarkModeToNormal()
        self.showDatePicker()
        self.dismissPickerView()
        self.getDataForAccountName()
        self.sepplierNameTF.delegate = self
        self.nameOfAccountTF.delegate = self
        // Do any additional setup after loading the view.
    }
    func toSetBoaderColor()
    {
        self.view1 = toSetBorderColorForView(view: self.view1, color: .lightGrayBG, Width: 2 , cornerRadius : 10)
        self.view2 = toSetBorderColorForView(view: self.view2, color: .lightGrayBG, Width: 2 , cornerRadius : 10)
         self.view3 = toSetBorderColorForView(view: self.view3, color: .lightGrayBG, Width: 2 , cornerRadius : 10)
         self.view4 = toSetBorderColorForView(view: self.view4, color: .lightGrayBG, Width: 2 , cornerRadius : 10)
         self.view5 = toSetBorderColorForView(view: self.view5, color: .lightGrayBG, Width: 2 , cornerRadius : 10  )
        self.view6 = toSetBorderColorForView(view: self.view6, color: .lightGrayBG, Width: 2 , cornerRadius : 10  )
        
         
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
           
           self.pickerView.delegate = self
           self.pickerView.dataSource = self
           currentTextField = textField
           //invoiceDiscountValueForText = "0"
        if currentTextField == self.sepplierNameTF{
               //            self.pickerView.selectRow(0, inComponent: 0, animated: false)
               //            self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 0)
               currentTextField.inputView = pickerView
              
        }
        if currentTextField == self.nameOfAccountTF
        {
            currentTextField.inputView = pickerView
        }
            pickerView.reloadAllComponents()
       }
       
       
       // MARK: - PickerView
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == self.sepplierNameTF{
            return self.supplierArray.count
           }
        if currentTextField == self.nameOfAccountTF{
         return self.nameOfAccountArray.count
        }
        return 0
       }
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           if currentTextField == sepplierNameTF{
            let item = self.supplierArray[row]
            self.typeOfDic = item
            self.selectProyarity = item["HeadName"] as! String
              // self.selectIdProyarity = customerListIdArray[row] as? NSDictionary
              // customer_balance = Float(self.selectIdProyarity?["customer_balance"] as! String)!
            return item["HeadName"] as? String
                //customerListArray[row] as? String
           }
        if currentTextField == nameOfAccountTF{
         let item = self.nameOfAccountArray[row]
            self.nameOfAccountDic = item
         self.selectProyarity = item["HeadName"] as! String
           // self.selectIdProyarity = customerListIdArray[row] as? NSDictionary
           // customer_balance = Float(self.selectIdProyarity?["customer_balance"] as! String)!
         return item["HeadName"] as? String
             //customerListArray[row] as? String
        }
           return ""
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           if currentTextField == sepplierNameTF{
               let item = self.supplierArray[row]
            self.typeOfDic = item
               self.selectProyarity = item["HeadName"] as! String
              // self.selectIdProyarity = customerListIdArray[row] as? NSDictionary
           }
        if currentTextField == nameOfAccountTF{
            let item = self.nameOfAccountArray[row]
            self.nameOfAccountDic = item
                      self.selectProyarity = item["HeadName"] as! String
                     // self.selectIdProyarity = customerListIdArray[row] as? NSDictionary
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
           
           self.sepplierNameTF.inputAccessoryView = toolBar
        self.nameOfAccountTF.inputAccessoryView = toolBar
          
           
       }
       
       @objc func doneButtonAction()
       {
           if currentTextField == self.sepplierNameTF
           {
           self.sepplierNameTF.text =  self.selectProyarity
           //self.customerDic  = self.selectIdProyarity
               //customer_balance
            //   customer_balance = Float(self.selectIdProyarity?["customer_balance"] as! String)!
              // self.newQuationTableView.reloadData()
           }
        if currentTextField == self.nameOfAccountTF
        {
            self.nameOfAccountTF.text = self.selectProyarity
        }
           self.view.endEditing(true)
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
           
           self.selectDate.inputAccessoryView = toolbar
           self.selectDate.inputView = datePicker
       }
       
       @objc func donedatePicker(){
           
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
        //"dd-MM-yyyy"
           self.selectDate.text = formatter.string(from: datePicker.date)
           self.view.endEditing(true)
       }
       
       @objc func cancelDatePicker(){
           self.view.endEditing(true)
       }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        }

    @IBAction func saveAction(_ sender: UIButton) {
        let messageSuccess = Validation()
               if messageSuccess == "" {
                   if CheckInternet.Connection(){
                       //forLoging()
                    save()
                   }else{
                       Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                   }
               }
               else
               {
                   Alert.showBasic(titte: "Alert", massage: messageSuccess, vc: self)
               }
    }
    func getNotification()
        {
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
            let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
            let url : URL = URL(string:BaseUrl + "/creditvoucherNumber")!
                    AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any)// URL response
                        let response1 = response.response
                     DispatchQueue.main.async {
                                            self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                        if response1?.statusCode == 200
                        {
                            /*
                                "title": "notification",
                                "out_of_stock": 3,
                                "balance": "$ 317.5",
                                "message": 10,
                                "incompleteUser": 0,
                                "invoice": 12,
                                "newApplicant": 0
                            }*/
                            do{
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                                                                  self.VocherNoText.text = jsonRespone["voucher_no"] as! String
//                            self.newApplicationBadgeLabel.text = "\(jsonRespone["newApplicant"] ?? "")"
//                                self.updateApplicationBadgeLabel.text = "\(jsonRespone["incompleteUser"] ?? "")"
//                                self.messageBadgeCountLabel.text = "\(jsonRespone["message"] ?? "")"
//                                self.outOfStockBadgeCountLabel.text = "\(jsonRespone["out_of_stock"] ?? "")"
//                                self.recentInvoiceBadgeCountLabel.text = "\(jsonRespone["invoice"] ?? "")"
                            }
                            catch
                            {
                                
                            }
                        }
                        
                        }
            }
    }
     func save()
            {
             self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
                let url : URL = URL(string:BaseUrl + "/creditVoucher")!
                        
                        /*user_type:"2",
                        user_id : "BEqZmikMVUvDGpQ",
                        voucher_no: "PM-4",
                        supplier_id:"T74KO7Z2SUMFEQV4KDMK",
                        txtAmount:"100",
                        dtpDate:"2020-01-17",
                        txtRemarks:"sample "*/
                let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                let voucherNo = self.VocherNoText.text ?? ""
                let totalAmount = self.totalAmountTF.text ?? ""
                let remarkText = self.remarkTV.text ?? ""
                let dateString = self.totalAmountTF.text ?? ""
               // let supplierId = self.remarkTV.text ?? ""
                /*{
                user_type:"2",
                user_id : "BEqZmikMVUvDGpQ",
                voucher_no: "DV-2",
                cmbCode:"102030200",
                txtAmount:"100",
                dtpDate:"2020-01-17",
                txtRemarks:"sample "
                }
                }*/
                //self.selectDate.text!
                let cmbCode = self.nameOfAccountDic["HeadCode"] ?? ""
                let cmbDebit = self.typeOfDic["HeadCode"] ?? ""
                let parameter = ["user_type" : USERTYPE,
                "user_id" : USERID,
                "voucher_no" : voucherNo,
                "cmbDebit" : cmbDebit,
                "cmbCode" : cmbCode,
                "txtAmount" : totalAmount,
                "dtpDate" : dateString,
                "txtRemarks" : remarkText] as [String : Any]
                print(parameter)
                        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                            print(response.request as Any)  // original URL request
                            print(response.response as Any)// URL response
                            let response1 = response.response
                         DispatchQueue.main.async {
                                                self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                            if response1?.statusCode == 200
                            {
                               /*
                                    "title": "notification",
                                    "out_of_stock": 3,
                                    "balance": "$ 317.5",
                                    "message": 10,
                                    "incompleteUser": 0,
                                    "invoice": 12,
                                    "newApplicant": 0
                                }*/
                                
                                do{
                                let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                                    print(jsonRespone)
                                    self.getNotification()
                                    self.sepplierNameTF.text = ""
                                    self.selectDate.text = ""
                                    self.nameOfAccountTF.text = ""
                                    self.remarkTV.text = ""
                                    self.totalAmountTF.text = ""
                                    Alert.showBasic(titte: "Success", massage: jsonRespone["title"] as! String, vc: self)
                                }
                                catch
                                {
                                    
                                }
                           }
                            }
                            
                }
    }
    func getDataForSupplierList()
    {
      self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/creditAccountHead")!
       // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    let response1 = response.response
                  DispatchQueue.main.async {
                             self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                    if response1?.statusCode == 200
                    {
                         do{
                             //categoryName
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                             var items = NSDictionary()
                            items = jsonRespone as! NSDictionary
                            print(items)
                            self.supplierArray = items["creditAccountHead"] as! [NSDictionary]
                           if self.supplierArray.count == 0
                           {
                               Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                           }
                            self.pickerView.reloadAllComponents()
                            
                            //self.manageSupplierTableVIew.reloadData()
                           // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                }
      }
    }
    func getDataForAccountName()
       {
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
           let url : URL = URL(string: BaseUrl + "/accountName")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
          // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
                   AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                       print(response.request as Any)  // original URL request
                       print(response.response as Any)// URL response
                       let response1 = response.response
                     DispatchQueue.main.async {
                                self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                       if response1?.statusCode == 200
                       {
                            do{
                                //categoryName
                               let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                               print(jsonRespone)
                                var items = NSDictionary()
                               items = jsonRespone as! NSDictionary
                               print(items)
                               self.nameOfAccountArray = items["accountList"] as! [NSDictionary]
                              if self.nameOfAccountArray.count == 0
                              {
                                  Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                              }
                               self.pickerView.reloadAllComponents()
                               
                               //self.manageSupplierTableVIew.reloadData()
                              // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                               } catch let parsingError {
                                  print("Error", parsingError)
                             }
                          // let dataFromServer =
                       }
                   }
         }
       }
    /*
    // MARK: - Navigation

    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func Validation() -> String {
           var successMessage = ""
        if self.sepplierNameTF.text?.count == 0
               {
                   successMessage = "Please select the user"
                   return successMessage
               }
        if self.totalAmountTF.text?.count == 0
        {
            successMessage = "Please enter amount"
            return successMessage
        }
        if self.selectDate.text?.count == 0
               {
                   successMessage = "Please enter date"
                   return successMessage
               }
        if self.remarkTV.text?.count == 0
        {
            successMessage = "Please enter remark"
            return successMessage
        }
            return successMessage
    }
}
