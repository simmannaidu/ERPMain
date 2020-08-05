//
//  ManageCustomerViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageCustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activeImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var updateButtonView: UIView!
    @IBOutlet weak var deleteButtonview: UIView!
    @IBOutlet weak var activeButtonview: UIView!
    @IBOutlet weak var activeButton: UIButton!
    
    @IBOutlet weak var assignMainBt: UIButton!
    @IBOutlet weak var assignedToButton: UIButton!
}

class ManageCustomerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate  {
    var allDataForTableView = [NSDictionary]()
    var nameOfProductArray = [String]()
    var filteredData = [String]()
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
var dataForTableView = [NSDictionary]()
    var dataForPickerView = [NSDictionary]()
    var salesPersonDicArray = [NSDictionary]()
    var selectedCustomer_id = String()
    @IBOutlet weak var grandTotlaLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var transView: UIView!
    
    @IBOutlet weak var popUpTransView: UIView!
    @IBOutlet weak var manageCustomerTableView: UITableView!
    
    @IBOutlet weak var assignSalesPersonPopUpView: UIView!
    
    @IBOutlet weak var salesPersonTF: UITextField!
    
    @IBOutlet weak var salesPersonView: UIView!
    
    
    var pickerView = UIPickerView()
       var currentTextField = UITextField()
       var selectProyarity: String?
        var selectProyarityDic: NSDictionary?
    //selectProyarityDic
        var salesPersonId: NSDictionary?
        var salesPersonArray = [String]()
        //let salesPersonIdArray = ["1","2","4"]
    var allowToArray = [Bool]()
    //var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedCustomer_id = ""
        self.manageCustomerTableView.delegate = self
        self.manageCustomerTableView.dataSource = self
       self.popUpTransView.isHidden = true
        self.transView.isHidden = true
        setShowToSearchView()
        self.getMessageUsersData()
         self.assignSalesPersonPopUpView.isHidden = true
        self.manageCustomerTableView.tableFooterView =  UIView(frame: .zero)
      //  self.getDataForManageCustomer()
        
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideSlideMenu))
                     mytapGestureRecognizer.numberOfTapsRequired = 1
          self.popUpTransView?.addGestureRecognizer(mytapGestureRecognizer)
        
        self.salesPersonView.layer.borderWidth = 1
        self.salesPersonView.layer.borderColor = UIColor.customBlue
        self.salesPersonView.layer.cornerRadius = 8
        dismissPickerView()
        self.salesPersonTF.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        if CheckInternet.Connection(){
            if USERTYPE == "1"
            {
              self.getDataForManageCustomer()
            }
            else
            {
                self.getDataForSalesManageCustomer()
            }
              }else{
                  Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
              }
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == self.salesPersonTF{
            currentTextField.inputView = pickerView
        }
    }
    
    
    @objc func hideSlideMenu()
       {
        self.popUpTransView.isHidden = true
self.assignSalesPersonPopUpView.isHidden = true
           
       }
      
    
    // MARK: - PickerView
       
       
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           if currentTextField == self.salesPersonTF{
               return self.salesPersonArray.count
           }
           else{
               return 0
           }
       }
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           if currentTextField == self.salesPersonTF{
               self.selectProyarity = self.salesPersonArray[row]
            self.selectProyarityDic = self.dataForPickerView[row]
                //self.salesPersonDicArray[row]
               return self.salesPersonArray[row]
           }
           else{
               return ""
           }
           
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           if currentTextField == self.salesPersonTF{
               self.selectProyarity = self.salesPersonArray[row]
             self.selectProyarityDic = self.dataForPickerView[row]
                //self.selectProyarityDic = self.salesPersonDicArray[row]
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
           
           self.salesPersonTF.inputAccessoryView = toolBar
           
       }
       
       @objc func doneButtonAction()
       {
           if currentTextField == self.salesPersonTF{
               self.salesPersonTF.text =  self.selectProyarity
              self.salesPersonId = self.selectProyarityDic
            // self.selectProyarityDic = self.dataForPickerView[row]
                self.view.endEditing(true)
           }
       }
    
    
    
   
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageCustomerTableViewCellId", for: indexPath) as! ManageCustomerTableViewCell
        
        /*{
            "assigned_sales_user_id" = VOVH4ITbhFfSzIp;
            "comapny_logo" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/3769ad749aa0e85ef75aeba552146190.png";
            "company_abn" = iiioio;
            "company_address" = jkjhkhjkhjk;
            "company_email" = "sudhakarnaytytyyak05@gmail.com";
            "company_mobile" = 555555555555;
            "company_name" = ttttttt;
            "company_telephone" = 444444444444;
            "create_date" = "2019-11-06 17:01:20";
            customerView = 0;
            "customer_address" = ", Subishi Plaza, Suite 101, Behind GEM Motors (Maruti Showroom), Kondapur, Hyderabad \U2013 500 084, India.";
            "customer_balance" = "-33.00";
            "customer_credits" = 0;
            "customer_date_of_birth" = "25-07-1989";
            "customer_email" = "rajws@gmail.com";
            "customer_id" = KLTSD3RIZG6QS4N;
            "customer_mobile" = 888888888888;
            "customer_name" = sudhakar;
            "customer_status" = 0;
            "customer_surname" = sudhakar;
            "customer_telephone" = 081443046948;
            "customer_terms" = "Cash only";
            "delihvery_day" = Monday;
            "dl_back" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/f332277e2c7546026e285676c8b61023.png";
            "dl_front" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/8fb485a007285db6ccdeab07064a7edd.png";
            electric = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/2a9098aa61c3ff327153b586560fcf38.png";
            passport = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/de3ac5ddc2a4da030a5d4af12f378c52.png";
            "postal_address" = tyrtytry;
            sl = 2;
            status = 1;
            "trading_name" = yyuyuyy;
            userUpdated = 0;
            "user_name" = sudhakar;
            "user_password" = 123456;
        }*/
        //customer_status
        let itemForCell = self.dataForTableView[indexPath.row]
        let status = itemForCell["customer_status"] as! String
        if status == "1" {
            cell.activeImage.image = UIImage(named: "active")
            cell.activeButtonview.backgroundColor = custemBlueColor
        }
        else
    {
        cell.activeImage.image = UIImage(named: "close")
        cell.activeButtonview.backgroundColor = .red
        }
        if self.allowToArray[indexPath.row]
        {
            cell.assignedToButton.backgroundColor = .red
            cell.assignedToButton.setTitle("Allow Login", for: .normal)
        }
        else
        {
            cell.assignedToButton.backgroundColor = custemBlueColor
            cell.assignedToButton.setTitle("Block Login", for: .normal)
        }
        
        cell.assignedToButton.layer.cornerRadius = 8
        cell.activeButton.tag = indexPath.row
    
        cell.assignedToButton.tag = indexPath.row
        cell.mobileNumberLabel.text = "Mobile : \(itemForCell["customer_mobile"] ?? "")"
        cell.nameLabel.text = "Customer Name : \(itemForCell["customer_name"] ?? "")"
        cell.balanceLabel.text = "Balance : $\(itemForCell["customer_balance"] ?? "")"
        cell.addressLabel.text = "\(itemForCell["customer_address"] ?? "")"
        if USERTYPE == "1"
        {
           cell.assignMainBt.isHidden = false
            let tittleString = itemForCell["assigned_sales_user_id"] as! String
           cell.assignMainBt.setTitle("Assign To : \(tittleString)", for: .normal)
        }
        else
        {
            cell.assignMainBt.isHidden = true
           // let tittleString = itemForCell["assigned_sales_user_id"] as! String
           // cell.assignMainBt.setTitle("Assign To", for: .normal)
        }
        cell.assignMainBt.layer.cornerRadius = 4
        cell.assignMainBt.tag = indexPath.row
        cell.updateButtonView.layer.cornerRadius = 4
        cell.deleteButtonview.layer.cornerRadius = 4
        cell.activeButtonview.layer.cornerRadius = 4
        cell.assignedToButton.layer.cornerRadius = 4
        cell.assignedToButton.layer.borderWidth = 1
        cell.assignedToButton.layer.borderColor = custemBlueColor.cgColor
            //UIColor.init(red: 28.0/255, green: 96.0/255, blue: 174.0/255, alpha: 1).cgColor
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
         cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    func getDataForManageCustomer(pageNumber : String)
    {
        let url : URL = URL(string: BaseUrl + "/customerList/1/5/" + pageNumber)!
       // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    let response1 = response.response
                    if response1?.statusCode == 200
                    {
                         do{
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                             var items = NSDictionary()
                            items = jsonRespone as! NSDictionary
                            self.dataForTableView = items["customers_list"] as! [NSDictionary]
                           
                            
                            self.manageCustomerTableView.reloadData()
                           // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                }
    }
    
    
     // MARK: - ButtonActions
    
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func assigMainAction(_ sender: UIButton) {
        let item = self.dataForTableView[sender.tag]
        self.selectedCustomer_id = item["customer_id"] as! String
        self.popUpTransView.isHidden = false
               self.assignSalesPersonPopUpView.isHidden = false
    }
    @IBAction func assignedToBtnAction(_
        sender: UIButton) {
        let item = self.dataForTableView[sender.tag]
        let customer_id = item["customer_id"] as! String
        let allow_login = item["allow_login"] as! String
        var sendallow_login = String()
        if allow_login == "0"
        {
         sendallow_login = "1"
        }
        else
        {
            sendallow_login = "0"
        }
        self.allowOrBlockLogin(customer_id: customer_id, allow_login: sendallow_login)
//        self.popUpTransView.isHidden = false
//        self.assignSalesPersonPopUpView.isHidden = false
    }
    @IBAction func activeBtnAction(_ sender: UIButton) {
        let item = self.dataForTableView[sender.tag]
        self.toMakeActiveOrInactive(item: item)
    }
    @IBAction func deleteBtnAction(_ sender: UIButton) {
    }
    @IBAction func updateBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func assignSalesPopUpSubmitBtnAction(_ sender: UIButton) {
        let item = ["customer_id" : self.selectedCustomer_id , "assigned_sales_user_id" : "\(self.selectProyarityDic?["user_id"] ?? "")" ,"user_type" : USERTYPE]
        assinTheCustomerToUser(dataDic: item)
        self.popUpTransView.isHidden = true
        self.assignSalesPersonPopUpView.isHidden = true
    }
    
    @IBAction func assignSalesPersonPopUpCloseBtnAction(_ sender: UIButton) {
        
        self.popUpTransView.isHidden = true
         self.assignSalesPersonPopUpView.isHidden = true
    }
    
    
    
    //MARK:- NETWORK
    func assinTheCustomerToUser(dataDic : Parameters)
    {
    //https://ayersfood.com/erpapi/api/assign_salesperson
        /*user_type
        customer_id
        assigned_sales_user_id*/
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        
            //http://lanciusit.com/demo/erpapi/api/customerList
            let url : URL = URL(string:BaseUrl + "/assign_salesperson")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
           // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
                    AF.request(url, method: .post, parameters: dataDic, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any)// URL response
                        let response1 = response.response
                       DispatchQueue.main.async {
                                          self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                        if response1?.statusCode == 200
                        {
                           self.getDataForManageCustomer()
                           // let dataFromServer =
                        }
                    }
           }
    }
    func getDataForManageCustomer()
    {
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        var parameters = Parameters()
        if USERTYPE == "1"
        {
        parameters = ["userStatus":"","user_type":USERTYPE,"user_id" : USERID]
        }
        else
        {
            parameters = ["userStatus":"","user_type":USERTYPE , "customer_id" : USERID]
        }
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        print("hence data \(parameters)")
         //http://lanciusit.com/demo/erpapi/api/customerList
         let url : URL = URL(string:BaseUrl + "/customerList")!
        // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
                 AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
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
                             //self.tatalAmountLabel.text = "\(items["subtotal"] ?? "")"
                             self.dataForTableView = items["customers_list"] as! [NSDictionary]
                            self.allDataForTableView = self.dataForTableView
                            if self.dataForTableView.count == 0
                            {
                               // Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                            }
                            self.filteredData.removeAll()
                            self.allowToArray.removeAll()
                            for item in self.allDataForTableView
                            {
                                self.filteredData.append(item["customer_name"] as! String)
                                let allow_login = item["allow_login"] as! String
                                if allow_login == "0"
                                {
                                self.allowToArray.append(true)
                                }
                                else
                                {
                                    self.allowToArray.append(false)
                                }
                            }
                             self.manageCustomerTableView.reloadData()
                             
                            // self.manageQuotationTableView.reloadData()
                            // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                             } catch let parsingError {
                                print("Error", parsingError)
                           }
                        // let dataFromServer =
                     }
                 }
        }
    }
    func getMessageUsersData(){
        showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/manageuser")!
       let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
             AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
            
            DispatchQueue.main.async {
            self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
            let response1 = response.response
            if response1?.statusCode == 200
            {
                do{
                    let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                    print(jsonRespone)
                    var items = NSDictionary()
                    items = jsonRespone as! NSDictionary
                    let userDetails = items["user_list"] as! [NSDictionary]
                    self.dataForPickerView = userDetails
                    for item in userDetails
                    {
                        let firstName = "\(item["first_name"] ?? "")"
                        let lastName = "\(item["last_name"] ?? "")"
                        let itemInString = firstName + " " + lastName
                        self.salesPersonArray.append(itemInString)
                    }
                    //self.salesPersonArray = items["user_list"] as! [NSDictionary]
                    if self.dataForTableView.count == 0
                    {
                     //   Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                    }
                   if self.dataForTableView.count == 0
                   {
                    //self.ManageUsersTableView.isHidden = true
                    //self.noRecordsLabel.isHidden = false
                   }else{
                   // self.ManageUsersTableView.isHidden = false
                   // self.noRecordsLabel.isHidden = true
                    }
                    
                    self.pickerView.reloadAllComponents()
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            }
        }
        }
    }
    func getDataForSalesManageCustomer()
    {
        /*{
        user_type:"2",
        sales_user_id: "VOVH4ITbhFfSzIp"
        }*/
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let parameters = ["user_type":USERTYPE,"customer_id":USERID , "userStatus" : ""]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
         //http://lanciusit.com/demo/erpapi/api/customerList
         let url : URL = URL(string:BaseUrl + "/customerList")!
        // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
                 AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
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
                             //self.tatalAmountLabel.text = "\(items["subtotal"] ?? "")"
                             self.dataForTableView = items["customers_list"] as! [NSDictionary]
                            self.allDataForTableView = self.dataForTableView
                            if self.dataForTableView.count == 0
                            {
                                Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                            }
                            self.filteredData.removeAll()
                            self.allowToArray.removeAll()
                            for item in self.allDataForTableView
                            {
                                self.filteredData.append(item["customer_name"] as! String)
                                let allow_login = item["allow_login"] as! String
                                if allow_login == "0"
                                {
                                self.allowToArray.append(true)
                                }
                                else
                                {
                                    self.allowToArray.append(false)
                                }
                            }
                             self.manageCustomerTableView.reloadData()
                             
                            // self.manageQuotationTableView.reloadData()
                            // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                             } catch let parsingError {
                                print("Error", parsingError)
                           }
                        // let dataFromServer =
                     }
                 }
        }
    }
    /* http://ayersfood.com/erpapi/api/customerActive
    params:
         {
        "user_type":"1",
        "customer_id":"748598",
        "terms":"5",
        "credits":"0",
        "delihvery_day":"dfgd",
        "customer_email":"df@gmail.com",
        "customer_status":"0"    }*/
    
    /*divya errabelli 5:21 PM
    http://ayersfood.com/erpapi/api/updaterejectProfile
         params:
         {
        "user_type":"1",
        "customer_id":"748598",
        "id":"1"
        }*/
    func toMakeActiveOrInactive(item : NSDictionary)
       {
           self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        var changeStatus = String()
        let status = item["customer_status"] as! String
        if status == "0"
        {
           changeStatus = "1"
        }
        else
        {
            changeStatus = "0"
        }
        let parameters = ["customer_id":item["customer_id"],"user_type":USERTYPE , "terms" : item["customer_terms"] ,"credits" : item["customer_credits"] , "delihvery_day" : item["delihvery_day"] , "customer_email" : item["customer_email"] , "customer_status" : changeStatus]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
            //http://lanciusit.com/demo/erpapi/api/customerList
            let url : URL = URL(string:BaseUrl + "/customerActive")!
           // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
                    AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any)// URL response
                        let response1 = response.response
                       DispatchQueue.main.async {
                                          self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                        if response1?.statusCode == 200
                        {
                           self.getDataForManageCustomer()
                           // let dataFromServer =
                        }
                    }
           }
       }
//    http://ayersfood.com/erpapi/api/customerallow_loginparams:{
//    "user_type":"1",
//    "customer_id":"ZPYJ2DYWK43MDIF",
//    "allow_login":"1"
//    }response:{
//        "status": "TRUE",
//        "responseCode": "0",
//        "message": "Login Blocked"
//    }
    func allowOrBlockLogin(customer_id : String , allow_login : String)
    {
        let parameters = ["user_type":USERTYPE , "customer_id" : customer_id , "allow_login" : allow_login ]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
         //http://lanciusit.com/demo/erpapi/api/customerList
        print(parameters)
         let url : URL = URL(string:BaseUrl + "/customerallow_login")!
        // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
        print(BaseUrl + "/customerallow_login")
                 AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                     print(response.request as Any)  // original URL request
                     print(response.response as Any)// URL response
                     let response1 = response.response
                    DispatchQueue.main.async {
                                       self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                     if response1?.statusCode == 200
                     {
                        self.getDataForManageCustomer()
                        // let dataFromServer =
                     }
                 }
        }
    }
   @IBAction func searchValueChange(_ sender: UITextField) {
       if self.searchTextField.text?.count != 0
       {
           forSearchAction(searchText: self.searchTextField.text!)
       }
       else
       {
           self.dataForTableView = self.allDataForTableView
           self.manageCustomerTableView.reloadData()
       }
   }
   @IBAction func searchBtAction(_ sender: UIButton) {
       if self.searchTextField.text?.count != 0
              {
                  forSearchAction(searchText: self.searchTextField.text!)
              }
   }
   func forSearchAction(searchText : String)
   {
    let filteredData1 = self.filteredData.filter({$0.uppercased().prefix(searchText.count) == searchText.uppercased()})
       var itemsArray = [NSDictionary]()
       for item in filteredData1
       {
           for product in self.allDataForTableView
           {
               if item == product["customer_name"] as! String
               {
                   itemsArray.append(product)
               }
           }
       }
       
       self.dataForTableView.removeAll()
       self.dataForTableView = itemsArray
       manageCustomerTableView.reloadData()
   }
   func setShowToSearchView()
   {
       self.searchView.layer.shadowColor = UIColor.lightGray
                  self.searchView.layer.shadowOpacity = 1
                  self.searchView.layer.masksToBounds = false
                  self.searchView.layer.shadowOffset = CGSize(width: 1, height: 1)
                  self.searchView.layer.cornerRadius = 8
   }
}
