//
//  ManageMessagesViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/24/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageMessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}

class ManageMessagesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var manageMessageTableView: UITableView!
    @IBOutlet weak var forCenterButtonView: UIView!
    @IBOutlet weak var recentInvoiceBadgeCountView: UIView!
    @IBOutlet weak var dropDowenView: UIView!
    @IBOutlet weak var newApplicationBadgeCountView: UIView!
    @IBOutlet weak var updateApplicationBadgeCountView: UIView!
    @IBOutlet weak var forTabBarView: UIView!
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
        self.manageMessageTableView.delegate = self
        self.manageMessageTableView.dataSource = self
        self.transView.isHidden = true
       
        self.manageMessageTableView.tableFooterView =  UIView(frame: .zero)
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.getDataForManageCustomer()
        if USERTYPE == "2"
        {
            self.forTabBarView.isHidden = true
            
        }
        else{
            self.forTabBarView.isHidden = false
        }
        if CheckInternet.Connection(){
            self.getNotification()
                               self.getDataForManageCustomer()
                           }else{
                               Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                           }
    }

    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageMessagesTableViewCellId", for: indexPath) as! ManageMessagesTableViewCell
        
        /*{
            id = 3;
            "message_date" = "2019-10-23 13:35:02";
            "message_detail" = "FCG2D9IJ1GVOU6X Request For Update Profile";
            "message_read" = 0;
            "message_subject" = "Request For Update Profile";
            receiver = 1;
            sender = "Customer ( FCG2D9IJ1GVOU6X)";
            status = 0;
            "user_type" = 1;
        }*/
        let item = self.dataForTableView[indexPath.row]
        cell.messageLabel.text = "Message : \(item["message_detail"] ?? "")"
        cell.subjectLabel.text = "Subject : \(item["message_subject"] ?? "")"
        cell.userLabel.text = "User : \(item["sender"] ?? "")"
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
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
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageNewApplicationViewControllerId") as? ManageNewApplicationViewController
                  
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
    /*http://lanciusit.com/demo/erpapi/api/managemessage
    {
        "customer_id":"1",
        "user_type":"1"
    }*/
    //MARK:- Network
    func getDataForManageCustomer()
       {
           let url : URL = URL(string: "https://ayersfood.com/erpapi/api/managemessage")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
           let headerData = ["customer_id":USERID,"user_type":USERTYPE]
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
                                var items = NSDictionary()
                               items = jsonRespone as! NSDictionary
                               self.dataForTableView = items["message_list"] as! [NSDictionary]
                              if self.dataForTableView.count == 0
                              {
                                  Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                              }
                               
                               self.manageMessageTableView.reloadData()
                              // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                               } catch let parsingError {
                                  print("Error", parsingError)
                             }
                          // let dataFromServer =
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
