//
//  ManageCustomerUpdateApplicantsViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/25/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageCustomerUpdateApplicantsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var rejectedButton: UIButton!
    @IBOutlet weak var acceptedBtnAction: UIButton!
}

class ManageCustomerUpdateApplicantsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   var dataForTableView = [NSDictionary]()
    @IBOutlet weak var customerUpdateApplicationTableview: UITableView!
    @IBOutlet weak var forBottemBarView: UIView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var popUpTransView: UIView!
    
    @IBOutlet weak var viewDetailsPopUpView: UIView!
    
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var telephoneNumberLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var tradingNameLabel: UILabel!
    @IBOutlet weak var companyABNLabel: UILabel!
    @IBOutlet weak var comanyAddressLabel: UILabel!
    @IBOutlet weak var companyMobileLabel: UILabel!
    @IBOutlet weak var companyTelephoneLabel: UILabel!
    @IBOutlet weak var companyEmailLabel: UILabel!
    @IBOutlet weak var postalAddressLabel: UILabel!
    @IBOutlet weak var australianDriversLicenceFrontImage: UIImageView!
    @IBOutlet weak var australianDriversLicenceBackImage: UIImageView!
    @IBOutlet weak var passportImage: UIImageView!
    @IBOutlet weak var utilityBillImage: UIImageView!
    @IBOutlet weak var businessRegisterationImage: UIImageView!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var deliveryDayLabel: UILabel!
    @IBOutlet weak var forCenterButtonView: UIView!
    @IBOutlet weak var recentInvoiceBadgeCountView: UIView!
    @IBOutlet weak var dropDowenView: UIView!
    @IBOutlet weak var newApplicationBadgeCountView: UIView!
    @IBOutlet weak var updateApplicationBadgeCountView: UIView!
    @IBOutlet weak var messageBadgeCountView: UIView!
    @IBOutlet weak var outOfStockBadgeCountView: UIView!
    
    @IBOutlet weak var recentInvoiceBadgeCountLabel: UILabel!
    @IBOutlet weak var outOfStockBadgeCountLabel: UILabel!
    @IBOutlet weak var messageBadgeCountLabel: UILabel!
    @IBOutlet weak var updateApplicationBadgeLabel: UILabel!
    @IBOutlet weak var newApplicationBadgeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.forCenterButtonView.layer.cornerRadius = 20
        self.forCenterButtonView.clipsToBounds = true
        self.customerUpdateApplicationTableview.delegate = self
        self.customerUpdateApplicationTableview.dataSource = self
        self.transView.isHidden = true
        self.popUpTransView.isHidden = true
        self.viewDetailsPopUpView.isHidden = true
        self.customerUpdateApplicationTableview.tableFooterView =  UIView(frame: .zero)
        self.getNotification()
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideSlideMenu))
               mytapGestureRecognizer.numberOfTapsRequired = 1
    self.popUpTransView?.addGestureRecognizer(mytapGestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.getDataForManageCustomer()
        if USERTYPE == "2"
        {
            self.forBottemBarView.isHidden = true
            
        }
        else{
            self.forBottemBarView.isHidden = false
        }
        if CheckInternet.Connection(){
              self.getDataForManageCustomer()
              }else{
                  Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
              }
    }

    
    @objc func hideSlideMenu()
     {
          self.popUpTransView.isHidden = true
           self.viewDetailsPopUpView.isHidden = true
         
     }
    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageCustomerUpdateApplicantsTableViewCellId", for: indexPath) as! ManageCustomerUpdateApplicantsTableViewCell
        
        /* "customers_list" =     (
                        {
                    "assigned_sales_user_id" = 0;
                    "comapny_logo" = 0;
                    "company_abn" = dssfsdf;
                    "company_address" = "# 1-111/3/C, Subishi Plaza, Suite 101, Behind GEM Motors (Maruti Showroom), Kondapur, Hyderabad \U2013 500 084, India.";
                    "company_email" = "sudhakarnayak05@gmail.com";
                    "company_mobile" = 08144304694;
                    "company_name" = lancius;
                    "company_telephone" = 08144304694;
                    "contact_method" = 0;
                    "create_date" = "2019-10-18 11:37:13";
                    customerView = 0;
                    "customer_address" = "# 1-111/3/C, Subishi Plaza, Suite 101, Behind GEM Motors (Maruti Showroom), Kondapur, Hyderabad \U2013 500 084, India.";
                    "customer_credits" = 0;
                    "customer_date_of_birth" = "12-07-1989";
                    "customer_email" = "";
                    "customer_id" = LJLDYB5281S48UM;
                    "customer_mobile" = 08144304694;
                    "customer_name" = natrajjan;
                    "customer_profile_status" = 1;
                    "customer_status" = 0;
                    "customer_surname" = raj;
                    "customer_telephone" = 08144304694;
                    "customer_terms" = 0;
                    "delihvery_day" = 0;
                    "dl_back" = 0;
                    "dl_front" = 0;
                    electric = 0;
                    id = 1;
                    passport = 0;
                    "postal_address" = "Plot no-510,Baramunda village, near palamandap
        \nBaramunda village";
                    status = 2;
                    "trading_name" = ffsdfs;
                    "user_name" = natrajjan;
                }*/
        
        let item = self.dataForTableView[indexPath.row]
        let customer_profile_status = item["customer_profile_status"] as! String
        if customer_profile_status == "0"
        {
         cell.rejectedButton.isHidden = false
            cell.acceptedBtnAction.isHidden = false
        }
        else if customer_profile_status == "1"
        {
            cell.rejectedButton.isHidden = true
            cell.acceptedBtnAction.isHidden = true
        }
        else
        {
           cell.rejectedButton.isHidden = true
            cell.acceptedBtnAction.isHidden = true
        }
        cell.addressLabel.text = "Address : \(item["customer_address"] ?? "")"
        cell.customerNameLabel.text = "Name : \(item["customer_name"] ?? "")"
        cell.mobileNumberLabel.text = "Mobile No : \(item["customer_mobile"] ?? "")"
        
        cell.acceptedBtnAction.tag = indexPath.row
        cell.rejectedButton.tag = indexPath.row
        cell.viewDetailsButton.tag = indexPath.row
        
        
        
        cell.viewDetailsButton.layer.cornerRadius = 4
        cell.rejectedButton.layer.cornerRadius = 4
        cell.acceptedBtnAction.layer.cornerRadius = 4
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
   
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewDetailsBtnAction(_ sender: UIButton) {
        let item = self.dataForTableView[sender.tag]
        //customer_id
        let customer_Id  = item["customer_id"] as! String
         toGetCustomerDetaisData(customer_id: customer_Id)
        
    }
    @IBAction func rejectedBtnAction(_ sender: UIButton) {
        let item = self.dataForTableView[sender.tag]
        self.toInActiveCustmer(item: item)
      
    }
    @IBAction func acceptedBtnAction(_ sender: UIButton) {
        let item = self.dataForTableView[sender.tag]
          self.toActiveCustmer(item: item)
        
    }
    @IBAction func viewDetailsPopUpCloseBtnAction(_ sender: UIButton) {
        
        self.popUpTransView.isHidden = true
              self.viewDetailsPopUpView.isHidden = true
        
    }
    @IBAction func newApplicationAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageNewApplicationViewControllerId") as? ManageNewApplicationViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func updateApplicationBtnAction(_ sender: UIButton) {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCustomerUpdateApplicantsViewControllerId") as? ManageCustomerUpdateApplicantsViewController
                  
                  self.navigationController?.pushViewController(vc!, animated: true)
       }
       @IBAction func homeBtnAction(_ sender: UIButton) {
           
       let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainScrollViewControllerId") as? MainScrollViewController
                        
                        self.navigationController?.pushViewController(vc!, animated: true)
             }
       
       
       @IBAction func messageBtnAction(_ sender: UIButton) {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SendMessageViewControllerId") as? SendMessageViewController
                  
                  self.navigationController?.pushViewController(vc!, animated: true)
       }
       
       @IBAction func outOfStockBtnAction(_ sender: UIButton) {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OutOfStockViewControllerId") as? OutOfStockViewController
           
           self.navigationController?.pushViewController(vc!, animated: true)
       }
       
       @IBAction func recentInvoiceBtnAction(_ sender: UIButton) {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecentInvoiceViewControllerId") as? RecentInvoiceViewController
                  
                  self.navigationController?.pushViewController(vc!, animated: true)
       }
    
    
    // MARK: - NETWORK
    func getDataForManageCustomer()
    {
      
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
       
         let url : URL = URL(string:BaseUrl + "/update_customer")!
        let parameters = ["user_type":USERTYPE,
        "user_id":USERID,
        "userStatus":""
]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
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
            self.dataForTableView.removeAll()
                            // self.tatalAmountLabel.text = "\(items["subtotal"] ?? "")"
                             self.dataForTableView = items["customers_list"] as! [NSDictionary]
                            if self.dataForTableView.count == 0
                            {
                                Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                            }
                             self.customerUpdateApplicationTableview.reloadData()
                             
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
    
    
    
    func toInActiveCustmer(item : NSDictionary)
       {
           self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
           let parameters = ["customer_id":item["customer_id"],"user_type":USERTYPE , "id" : item["id"]]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
            //http://lanciusit.com/demo/erpapi/api/customerList
            let url : URL = URL(string:BaseUrl + "/updaterejectProfile")!
           // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
        AF.request(url, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
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
       /*http://ayersfood.com/erpapi/api/updateAcceptProfile    params:
        {
       "user_type":"1",
       "customer_id":"748598",
       "id":"1"
       }*/
       
       func toActiveCustmer(item : NSDictionary)
          {
              self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
               let parameters = ["customer_id":item["customer_id"],"user_type":USERTYPE , "id" : item["id"]]
            let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
               //http://lanciusit.com/demo/erpapi/api/customerList
               let url : URL = URL(string:BaseUrl + "/updateAcceptProfile")!
              // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
            AF.request(url, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
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
    
    
    func toGetCustomerDetaisData(customer_id : String)
         {
             let url : URL = URL(string:BaseUrl + "/customerdetail")!
            let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
            let parameter = [
            "user_type":USERTYPE,
            "user_id":USERID,
            "customer_id":customer_id
            ]
        //  let parameter = ["customer_id":customer_id]
    AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
        print(response.request as Any)  // original URL request
            print(response.response as Any)// URL response
            let response1 = response.response
            if response1?.statusCode == 200
        {
            do{
                let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                                 print(jsonRespone)
                                  self.popUpTransView.isHidden = false
                                  self.viewDetailsPopUpView.isHidden = false
                    // self.jsonDic = jsonRespone
            let companyDetailsArray = jsonRespone["company_info"] as! [NSDictionary]
            let companyDetails = companyDetailsArray[0]
                
                self.customerNameLabel.text = "\(jsonRespone["customer_surname"] ?? "")"
                 self.addressLabel.text = "\(jsonRespone["customer_address"] ?? "")"
               // self.mobileNumberLabel.text = "\(jsonRespone["customer_mobile"] ?? "")"
                self.dateOfBirthLabel.text = "\(jsonRespone["customer_date_of_birth"] ?? "")"
                self.telephoneNumberLabel.text = "\(jsonRespone["customer_telephone"] ?? "")"
                self.companyNameLabel.text = "\(companyDetails["company_name"] ?? "")"
                self.tradingNameLabel.text = "\(jsonRespone[""] ?? "")"
                self.companyABNLabel.text = "\(jsonRespone["company_abn"] ?? "")"
                self.comanyAddressLabel.text = "\(companyDetails["address"] ?? "")"
                self.companyMobileLabel.text = "\(companyDetails["mobile"] ?? "")"
                self.companyTelephoneLabel.text = "\(jsonRespone["company_telephone"] ?? "")"
                self.companyEmailLabel.text = "\(companyDetails["email"] ?? "")"
                self.postalAddressLabel.text = "\(jsonRespone["postal_address"] ?? "")"
                self.termsLabel.text = "\(jsonRespone[""] ?? "")"
                self.creditsLabel.text = "\(jsonRespone[""] ?? "")"
                self.deliveryDayLabel.text = "\(jsonRespone[""] ?? "")"
                
                } catch let parsingError {
                print("Error", parsingError)
            }
                }
                     }
         }
    
    
    func getNotification()
        {
            self.outOfStockBadgeCountView.layer.cornerRadius = self.outOfStockBadgeCountView.frame.size.height / 2
            self.outOfStockBadgeCountView.clipsToBounds = true
            self.messageBadgeCountView.layer.cornerRadius = self.messageBadgeCountView.frame.size.height / 2
            self.messageBadgeCountView.clipsToBounds = true
            self.updateApplicationBadgeCountView.layer.cornerRadius = self.updateApplicationBadgeCountView.frame.size.height / 2
            self.updateApplicationBadgeCountView.clipsToBounds = true
            self.newApplicationBadgeCountView.layer.cornerRadius = self.newApplicationBadgeCountView.frame.size.height / 2
            self.newApplicationBadgeCountView.clipsToBounds = true
            self.recentInvoiceBadgeCountView.layer.cornerRadius = self.recentInvoiceBadgeCountView.frame.size.height / 2
            self.recentInvoiceBadgeCountView.clipsToBounds = true
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
            let url : URL = URL(string:BaseUrl + "/notification")!
                    
                 let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
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
                            self.newApplicationBadgeLabel.text = "\(jsonRespone["newApplicant"] ?? "")"
                                self.updateApplicationBadgeLabel.text = "\(jsonRespone["incompleteUser"] ?? "")"
                                self.messageBadgeCountLabel.text = "\(jsonRespone["message"] ?? "")"
                                self.outOfStockBadgeCountLabel.text = "\(jsonRespone["out_of_stock"] ?? "")"
                                self.recentInvoiceBadgeCountLabel.text = "\(jsonRespone["invoice"] ?? "")"
                            }
                            catch
                            {
                                
                            }
                        }
                        
                        }
            }
    }
}
