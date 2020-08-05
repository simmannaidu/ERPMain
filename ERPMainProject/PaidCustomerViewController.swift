//
//  PaidCustomerViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class PaidCustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var deleteView: UIView!
}

class PaidCustomerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var paidCustomerTableView: UITableView!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.paidCustomerTableView.delegate = self
        self.paidCustomerTableView.dataSource = self
        self.transView.isHidden = true
        self.paidCustomerTableView.tableFooterView =  UIView(frame: .zero)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getDataForManageCustomer()
    }
    

    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "PaidCustomerTableViewCellId", for: indexPath) as! PaidCustomerTableViewCell
        
        
        cell.updateView.layer.cornerRadius = 4
        cell.deleteView.layer.cornerRadius = 4
        
        let itemForCell = self.dataForTableView[indexPath.row]
               
                   
                 //  cell.assignedToButton.layer.cornerRadius = 8
                  // cell.activeButton.tag = indexPath.row
               
                   //cell.assignedToButton.tag = indexPath.row
                   cell.mobileNumberLabel.text = "Mobile : \(itemForCell["customer_mobile"] ?? "")"
                   cell.nameLabel.text = "Customer Name : \(itemForCell["customer_name"] ?? "")"
                   cell.balanceLabel.text = "Balance : $\(itemForCell["balance"] ?? "")"
                   cell.addressLabel.text = "Address : \(itemForCell["customer_address"] ?? "")"
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        // cell.cellView.layer.cornerRadius = 8
        
        
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
    @IBAction func updateBtnAction(_ sender: UIButton) {
    }
    @IBAction func deleteBtnAction(_ sender: UIButton) {
    }
    //MARK: - NETWORK
    func getDataForManageCustomer()
    {
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
       var parameters = Parameters()
       if USERTYPE == "1"
       {
           parameters = ["userStatus":"5","user_type":USERTYPE]
       }
       else
       {
           parameters = ["userStatus":"5","user_type":USERTYPE,"sales_user_id" : USERID]
       }
         //http://lanciusit.com/demo/erpapi/api/customerList
         let url : URL = URL(string:BaseUrl + "/paidCustomerList")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
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
                             
                             self.dataForTableView = items["customers_list"] as! [NSDictionary]
                            if self.dataForTableView.count == 0
                            {
                                Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                            }
                        //self.tatalAmountLabel.text = "\(items["subtotal"] ?? "")"
                             self.paidCustomerTableView.reloadData()
                             
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
}
