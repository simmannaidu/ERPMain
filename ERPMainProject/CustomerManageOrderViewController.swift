//
//  CustomerManageOrderViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire

class CustomerManageOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var invoiceNumberLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    
    @IBOutlet weak var deliveryDateLabel: UILabel!
}

class CustomerManageOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var manageOrderTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageOrderTableView.delegate = self
        self.manageOrderTableView.dataSource = self
        self.transView.isHidden = true
        self.manageOrderTableView.tableFooterView =  UIView(frame: .zero)
        self.toGetDataFromServer()
    }
    

    
    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "CustomerManageOrderTableViewCellId", for: indexPath) as! CustomerManageOrderTableViewCell
        /* {
                   "invoice_id": "3558444959",
                   "customer_id": "ZPYJ2DYWK43MDIF",
                   "date": "2019-11-28",
                   "total_amount": "492",
                   "prevous_due": "0",
                   "shipping_cost": "0",
                   "invoice": "1098",
                   "invoice_discount": "0",
                   "total_discount": "0",
                   "total_tax": "0",
                   "invoice_details": "",
                   "status": "1",
                   "invoiceType": "1",
                   "prevous_due_invoice": "492.00",
                   "invoice_paid_amount": "0.00",
                   "incoice_created_user_type": "3",
                   "incoice_created_by": "ZPYJ2DYWK43MDIF",
                   "invoiceTypeFor": "1",
                   "delivery_date": "2019-11-28 17:09:32",
                   "delivery_day": "0",
                   "invoice_create_date": "2019-11-28 17:09:32",
                   "customer_name": "MasonQ",
                   "final_date": "28 - NOV - 2019",
                   "sl": 2
               }*/
        let item = self.dataForTableView[indexPath.row]
        cell.invoiceNumberLabel.text = "Invoice No : \(item["invoice_id"] ?? "")"
        cell.totalAmountLabel.text = "Total Amount : $ \(item["total_amount"] ?? "")"
        cell.orderDateLabel.text = "Order Date : \(item["invoice_create_date"] ?? "")"
        cell.deliveryDateLabel.text = "Delivery Date : \(item["delivery_date"] ?? "")"
        
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
    //invoiceList/1/1/0
     //MARK :- Network
        func toGetDataFromServer()
           {
               let url : URL = URL(string:BaseUrl + "/invoiceList")!
                      let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                       let headerData = ["user_id":USERTYPE,"user_type":USERID]
                       AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                           print(response.request as Any)  // original URL request
                           print(response.response as Any)// URL response
                           let response1 = response.response
                           if response1?.statusCode == 200
                           {
                                do{
                                   let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                                   print(jsonRespone)
                                   // self.jsonDic = jsonRespone
                                    self.dataForTableView = jsonRespone["invoices_list"] as! [NSDictionary]
                                    if self.dataForTableView.count == 0
                                    {
                                        Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                    }
                                    self.manageOrderTableView.reloadData()
                                   } catch let parsingError {
                                      print("Error", parsingError)
                                 }
                              // let dataFromServer =
                           }
                       }
           }
}
