//
//  ManageActiveCustomerViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageActiveCustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activeImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var updateButtonView: UIView!
    @IBOutlet weak var deleteButtonView: UIView!
    @IBOutlet weak var activeButtonview: UIView!
    @IBOutlet weak var activeButton: UIButton!
}

class ManageActiveCustomerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var manageActiveCustomerTableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageActiveCustomerTableView.delegate = self
        self.manageActiveCustomerTableView.dataSource = self
        self.transView.isHidden = true
        self.manageActiveCustomerTableView.tableFooterView =  UIView(frame: .zero)
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.getDataForManageCustomer()
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
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageActiveCustomerTableViewCellId", for: indexPath) as! ManageActiveCustomerTableViewCell
        
        
        cell.updateButtonView.layer.cornerRadius = 4
        cell.deleteButtonView.layer.cornerRadius = 4
        cell.activeButtonview.layer.cornerRadius = 4

        
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        // cell.cellView.layer.cornerRadius = 8
        /*{
            "assigned_sales_user_id" = VOVH4ITbhFfSzIp;
            "comapny_logo" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/3769ad749aa0e85ef75aeba552146190.png";
            "company_abn" = iiioio;
            "company_address" = jkjhkhjkhjk;
            "company_email" = "sudhakarnaytytyyak05@gmail.com";
            "company_mobile" = 555555555555;
            "company_name" = ttttttt;
            "company_telephone" = 444444444444;
            "create_date" = "2019-11-06 22:31:20";
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
            "customer_terms" = "14 days";
            "delihvery_day" = Monday;
            "dl_back" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/f332277e2c7546026e285676c8b61023.png";
            "dl_front" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/8fb485a007285db6ccdeab07064a7edd.png";
            electric = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/2a9098aa61c3ff327153b586560fcf38.png";
            passport = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/de3ac5ddc2a4da030a5d4af12f378c52.png";
            "postal_address" = tyrtytry;
            sl = 1;
            status = 1;
            "trading_name" = yyuyuyy;
            userUpdated = 0;
            "user_name" = sudhakar;
            "user_password" = 123456;
        }*/
        let itemForCell = self.dataForTableView[indexPath.row]
        let status = itemForCell["customer_status"] as! String
               if status == "1" {
                   cell.activeImage.image = UIImage(named: "active")
               cell.activeButtonview.backgroundColor = UIColor(red: 28.0/255, green: 96.0/255, blue: 174.0/255, alpha: 1)
                       }
                       else
                   {
                       cell.activeImage.image = UIImage(named: "close")
                    cell.activeButtonview.backgroundColor = .red
               cell.activeImage.image = UIImage(named: "close")
           }
        cell.customerNameLabel.text = "Customer Name : \(itemForCell["customer_name"] ?? "")"
        cell.mobileNumberLabel.text = "Mobile : \(itemForCell["customer_mobile"] ?? "")"
        cell.addressLabel.text = "\(itemForCell["customer_address"] ?? "")"
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
       let parameters = ["user_id":"1","user_type":USERTYPE]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
         //http://lanciusit.com/demo/erpapi/api/customerList
         let url : URL = URL(string:BaseUrl + "/customerList")!
      //   let headerData = ["user_id":USERID,"user_type":USERTYPE]
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
                            self.totalAmountLabel.text = "\(items["subtotal"] ?? "")"
                             self.manageActiveCustomerTableView.reloadData()
                             
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
