//
//  ManageInactiveCustomerViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageInactiveCustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activeImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var updateButtonview: UIView!
    @IBOutlet weak var deleteButtonview: UIView!
    @IBOutlet weak var activeButtonView: UIView!
    @IBOutlet weak var activeButton: UIButton!
    
}

class ManageInactiveCustomerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var manageInactiveCustomerTableView: UITableView!
    @IBOutlet weak var tatalAmountLabel: UILabel!
    @IBOutlet weak var transView: UIView!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageInactiveCustomerTableView.delegate = self
        self.manageInactiveCustomerTableView.dataSource = self
        self.transView.isHidden = true
        self.manageInactiveCustomerTableView.tableFooterView =  UIView(frame: .zero)
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.getDataForManageCustomer()
        if CheckInternet.Connection(){
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
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageInactiveCustomerTableViewCellId", for: indexPath) as! ManageInactiveCustomerTableViewCell
        
        
        cell.updateButtonview.layer.cornerRadius = 4
        cell.deleteButtonview.layer.cornerRadius = 4
        cell.activeButtonView.layer.cornerRadius = 4
        
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
         cell.cellView.layer.cornerRadius = 8
        let itemForCell  = self.dataForTableView[indexPath.row]
        let status = itemForCell["customer_status"] as! String
               if status == "1" {
                   cell.activeImage.image = UIImage(named: "active")
                cell.activeButtonView.backgroundColor = UIColor(red: 28.0/255, green: 96.0/255, blue: 174.0/255, alpha: 1)
               }
               else
           {
               cell.activeImage.image = UIImage(named: "close")
            cell.activeButtonView.backgroundColor = .red
           }
        cell.nameLabel.text = "Customer Name : \(itemForCell["customer_name"] ?? "")"
        cell.mobileNumberLabel.text = "Mobile : \(itemForCell["customer_mobile"] ?? "")"
        cell.addressLabel.text = "Address : \(itemForCell["customer_address"] ?? "")"
        cell.balanceLabel.text = "Balance : \(itemForCell["customer_balance"] ?? "")"
        
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
    
    @IBAction func updateBtnAction(_ sender: UIButton) {
    }
    @IBAction func deleteBtnAction(_ sender: UIButton) {
    }
    @IBAction func activeBtnAction(_ sender: UIButton) {
        let item = self.dataForTableView[sender.tag]
        self.toMakeActiveOrInactive(item: item)
    }
    //MARK: - NETWORK
    func getDataForManageCustomer()
    {
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let parameters = ["userStatus":"5","user_type":USERTYPE , "user_id" : USERID]
         //http://lanciusit.com/demo/erpapi/api/customerList
         let url : URL = URL(string:BaseUrl + "/customerList")!
        // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
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
                             
                             self.dataForTableView = items["customers_list"] as! [NSDictionary]
                            if self.dataForTableView.count == 0
                            {
                                Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                            }
                            self.tatalAmountLabel.text = "\(items["subtotal"] ?? "")"
                             self.manageInactiveCustomerTableView.reloadData()
                             
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
         //http://lanciusit.com/demo/erpapi/api/customerList
         let url : URL = URL(string:BaseUrl + "/customerActive")!
        // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
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
}

