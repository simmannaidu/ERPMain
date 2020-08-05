//
//  ManageNewApplicationViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/24/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageNewApplicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var incompleteButton: UIButton!
    @IBOutlet weak var updateButtonView: UIView!
    @IBOutlet weak var deleteButtonView: UIView!
    @IBOutlet weak var activeButtonView: UIView!
    @IBOutlet weak var activeButton: UIButton!
    
}

class ManageNewApplicationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dataForTableView = [NSDictionary]()
    @IBOutlet weak var forBottemBarView: UIView!
    @IBOutlet weak var manageNewApplicationTableview: UITableView!
    @IBOutlet weak var forHomeCenterView: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBAction func newCustomerBt(_ sender: UIButton) {
    }
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var recentInvoiceBadgeCountLabel: UILabel!
    @IBOutlet weak var recentInvoiceBadgeCountView: UIView!
       @IBOutlet weak var outOfStockBadgeCountLabel: UILabel!
       @IBOutlet weak var messageBadgeCountLabel: UILabel!
       @IBOutlet weak var updateApplicationBadgeLabel: UILabel!
       @IBOutlet weak var newApplicationBadgeLabel: UILabel!
    @IBOutlet weak var newApplicationBadgeCountView: UIView!

      @IBOutlet weak var updateApplicationBadgeCountView: UIView!
        @IBOutlet weak var messageBadgeCountView: UIView!
        @IBOutlet weak var outOfStockBadgeCountView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageNewApplicationTableview.delegate = self
        self.manageNewApplicationTableview.dataSource = self
        self.forHomeCenterView.layer.cornerRadius = 20
        self.forHomeCenterView.clipsToBounds = true
        self.transView.isHidden = true
        self.manageNewApplicationTableview.tableFooterView =  UIView(frame: .zero)
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
            self.getNotification()
              self.getDataForManageCustomer()
              }else{
                  Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
              }
    }

    @IBAction func submitBtAction(_ sender: UIButton) {
    }
    @IBAction func deliveryDatAction(_ sender: UITextField) {
    }
    @IBAction func termsAction(_ sender: UITextField) {
    }
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageNewApplicationTableViewCellId", for: indexPath) as! ManageNewApplicationTableViewCell
        
        
       
        cell.activeButtonView.layer.cornerRadius = 4
        cell.updateButtonView.layer.cornerRadius = 4
        cell.deleteButtonView.layer.cornerRadius = 4
         cell.incompleteButton.layer.cornerRadius = 4
        cell.incompleteButton.layer.borderWidth = 1
        cell.incompleteButton.layer.borderColor = UIColor.lightGray
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        /* {
                   "assigned_sales_user_id" = 0;
                   "comapny_logo" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/54a82c88437095a45a43217cfe1c4988.png";
                   "company_abn" = 3241234132412;
                   "company_address" = 21341324234234;
                   "company_email" = "234213421341324@njdsnwi.com";
                   "company_mobile" = 432432142567;
                   "company_name" = 413243241324ff;
                   "company_telephone" = 3241234125sw;
                   "create_date" = "2019-10-15 16:06:29";
                   customerView = 0;
                   "customer_address" = 1324123412341234;
                   "customer_balance" = 0;
                   "customer_credits" = 1000;
                   "customer_date_of_birth" = "26-07-1989";
                   "customer_email" = "sudhakarnayak05@gmail.com";
                   "customer_id" = VV9IDEGV27O3QU5;
                   "customer_mobile" = 234123412341;
                   "customer_name" = "navya raooo";
                   "customer_status" = 0;
                   "customer_surname" = "navya raooo";
                   "customer_telephone" = 1rtr23412341234;
                   "customer_terms" = "7 days";
                   "delihvery_day" = Wednesday;
                   "dl_back" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/4399383c249784778e0e296986f46315.png";
                   "dl_front" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/6e0f07cde945c0995c3b6aa59fdc6506.png";
                   electric = 0;
                   passport = 0;
                   "postal_address" = 2341234132423142156756;
                   sl = 2;
                   status = 2;
                   "trading_name" = 32412341234132ff;
                   userUpdated = 0;
                   "user_name" = "navya raooo";
                   "user_password" = 23412341234123;
               }*/
        let itemForCell = self.dataForTableView[indexPath.row]
        cell.addressLabel.text = "Address : \(itemForCell["customer_address"] ?? "")"
        cell.mobileNumberLabel.text = "Mobile : \(itemForCell["customer_mobile"] ?? "")"
        cell.balanceLabel.text = "Balance : \(itemForCell["customer_balance"] ?? "")"
        cell.nameLabel.text = "Customer Name : \(itemForCell["customer_name"] ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
     // MARK: - ButtonActions

    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
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
        let parameters = ["userStatus":"7","user_type":USERTYPE , "user_id" : USERID]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
         //http://lanciusit.com/demo/erpapi/api/customerList
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
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
                            // self.totalAmountLabel.text = "\(items["subtotal"] ?? "")"
                             self.dataForTableView = items["customers_list"] as! [NSDictionary]
                            if self.dataForTableView.count == 0
                            {
                                Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                            }
                             self.manageNewApplicationTableview.reloadData()
                             
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
