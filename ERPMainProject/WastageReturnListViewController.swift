//
//  WastageReturnListViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

import Alamofire
class WastageReturnListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var invoiceId: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var deleteButtonView: UIView!
}
class WastageReturnListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    var dataForTableView = [NSDictionary]()
    @IBOutlet weak var wastageReturnTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.wastageReturnTableView.delegate = self
        self.wastageReturnTableView.dataSource = self
        self.transView.isHidden = true
        self.getDataForServer()
        self.wastageReturnTableView.tableFooterView =  UIView(frame: .zero)
       
    }
    override func viewWillAppear(_ animated: Bool) {
   
        
      if CheckInternet.Connection(){
                           //  self.getDataForManageCustomer()
                         }else{
                             Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                         }
        
    }

   
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "WastageReturnListTableViewCellId", for: indexPath) as! WastageReturnListTableViewCell
        /*{
            "byy_qty" = 3;
            "customer_id" = ZPYJ2DYWK43MDIF;
            "customer_name" = MasonQ;
            "date_purchase" = "2019-11-29";
            "date_return" = "2019-12-02";
            deduction = 0;
            "final_date" = "2 - DEC - 2019";
            "invoice_id" = 7127995769;
            "net_total_amount" = 60;
            "product_id" = 89654;
            "product_rate" = 30;
            "purchase_id" = 0;
            reason = "";
            "ret_qty" = 2;
            "return_id" = 973475612727987;
            sl = 1;
            "supplier_id" = "";
            "total_deduct" = 0;
            "total_ret_amount" = 60;
            "total_tax" = 0;
            usablity = 3;
        }*/
        let item = self.dataForTableView[indexPath.row]
        cell.invoiceId.text = "Invoice Id : \(item["invoice_id"] ?? "")"
        cell.categoryNameLabel.text = "Customer Name : \(item["customer_name"] ?? "")"
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

    @IBAction func deleteButtonView(_ sender: UIButton) {
    }
    func getDataForServer()
    {
     let date = Date()
     let formatter = DateFormatter()


     formatter.dateFormat = "dd-MM-yyyy"


     let currentDateString = formatter.string(from: date)
        
        /*{
        "customer_id":"1",
        "dtpFromDate":"2019-09-04",
        "dtpToDate":"2019-06-04",
        "search":"1"
        }*/
//        let parameter = [
//            "customer_id" : USERID , "dtpFromDate" : "2019-09-04",
//            "dtpToDate" : currentDateString ,
//            "search" : "1"]
         let headerData = ["customer_id": USERID,"dtpFromDate" : "2019-09-04" , "dtpToDate" : currentDateString , "search" : "1"]
        
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        //http://lanciusit.com/demo/erpapi/api/returnlist
        let url : URL = URL(string: BaseUrl + "/wastagereturnlist")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
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
                               self.dataForTableView = items["return_list"] as! [NSDictionary]
                                if self.dataForTableView.count == 0
                                {
                                    self.wastageReturnTableView.isHidden = true
                                    Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                }
                                else
                                {
                                    self.wastageReturnTableView.isHidden = false
                                }
                                self.wastageReturnTableView.reloadData()
                                } catch let parsingError {
                                   print("Error", parsingError)
                              }
                           // let dataFromServer =
                        }
            }
                    }
        }
}
