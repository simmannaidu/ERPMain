//
//  SupplierReturnListViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

import Alamofire
class SupplierReturnListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var purchaseIdLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var deleteButtonView: UIView!
}
class SupplierReturnListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var supplierReturnTableView: UITableView!
    @IBOutlet weak var transview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.supplierReturnTableView.delegate = self
        self.supplierReturnTableView.dataSource = self
        self.transview.isHidden = true
        self.supplierReturnTableView.tableFooterView =  UIView(frame: .zero)
        self.getSuppllerList()
    }
    override func viewWillAppear(_ animated: Bool) {
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
        let cell = tableView .dequeueReusableCell(withIdentifier: "SupplierReturnListTableViewCellId", for: indexPath) as! SupplierReturnListTableViewCell
        
       // let item = self.dataForTableView[indexPath.row]
        
//        cell.purchaseIdLabel.text = "Purchase Id : \(item[""] ?? "")"
//        cell.supplierNameLabel.text = "Supplier Name : \(item[""] ?? "")"
//        cell.dateLabel.text = "Date : \(item[""] ?? "")"
//        cell.amountLabel.text = "Total Amount : \(item[""] ?? "")"
        let item = self.dataForTableView[indexPath.row]
        cell.purchaseIdLabel.text = "Invoice Id : \(item["invoice_id"] ?? "")"
        cell.supplierNameLabel.text = "Customer Name : \(item["customer_name"] ?? "")"
        cell.dateLabel.text = "Date : \(item["date_return"] ?? "")"
        cell.amountLabel.text = "Total Amount : $\(item["total_ret_amount"] ?? "")"
        cell.cellView.layer.shadowColor = UIColor.lightGray
                cell.cellView.layer.shadowOpacity = 1
                cell.cellView.layer.masksToBounds = false
                cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func deleteButtonAction(_ sender: UIButton) {
    }
    
    // MARK: - NETWORK
    func getDataForManageCustomer()
    {
     
        /*{
        "customer_id":"1",
        "dtpFromDate":"2019-09-04",
        "dtpToDate":"2019-06-04",
        "search":"1"
        }*/
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transview)
        //http://lanciusit.com/demo/erpapi/api/returnlist
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let url : URL = URL(string: BaseUrl + "/supplierreturnlist")!
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any)// URL response
                        let response1 = response.response
            DispatchQueue.main.async {
            self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transview)
                        if response1?.statusCode == 200
                        {
                             do{
                                 //categoryName
                                let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                print(jsonRespone)
                                 var items = NSDictionary()
                                items = jsonRespone as! NSDictionary
                               self.dataForTableView = items["return_list"] as! [NSDictionary]
                                if self.dataForTableView.count == 0
                                {
                                    Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                }
                                self.supplierReturnTableView.reloadData()
                                } catch let parsingError {
                                   print("Error", parsingError)
                              }
                           // let dataFromServer =
                        }
                    }
        }
        }
    func getSuppllerList()
    {
    self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transview)
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let url : URL = URL(string: BaseUrl + "/supplierList")!
         let headerData = ["user_type":USERTYPE]
       // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
                AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    let response1 = response.response
                  DispatchQueue.main.async {
                             self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transview)
                    if response1?.statusCode == 200
                    {
                         do{
                             //categoryName
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                             var items = NSDictionary()
                            items = jsonRespone as! NSDictionary
                            self.dataForTableView = items["suppliers_list"] as! [NSDictionary]
                           if self.dataForTableView.count == 0
                           {
                               Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                           }
                            
                            //self.manageSupplierTableVIew//.reloadData()
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
