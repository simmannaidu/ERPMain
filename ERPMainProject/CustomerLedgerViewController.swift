//
//  CustomerLedgerViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class CustomerLedgerTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var invoiceNoLabel: UILabel!
    @IBOutlet weak var receiptNoLabel: UILabel!
    @IBOutlet weak var descriptionlabel: UILabel!
    @IBOutlet weak var debitLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
}

class CustomerLedgerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var customerLedgerTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var totalAmountView: UIView!
    @IBOutlet weak var totalDebitLabel: UILabel!
    @IBOutlet weak var totalCreditLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customerLedgerTableView.delegate = self
        self.customerLedgerTableView.dataSource = self
        self.transView.isHidden = true
        self.customerLedgerTableView.tableFooterView =  UIView(frame: .zero)
        Design()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.toGetDataFromServer()
    }

  // MARK: - Design
    func Design(){
        
    }
    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "CustomerLedgerTableViewCellId", for: indexPath) as! CustomerLedgerTableViewCell
        /*{
            "id": "13",
            "transaction_id": "GQCHBVC2TZ7GE6X",
            "customer_id": "1",
            "invoice_no": "6965643836",
            "receipt_no": "0",
            "amount": "230",
            "description": "Purchase by customer",
            "payment_type": "",
            "cheque_no": "",
            "date": "2019-09-19 00:00:00",
            "receipt_from": "0",
            "status": "1",
            "d_c": "d",
            "created_at": "2019-09-19 16:54:14",
            "invoiceQuationledger": "1",
            "invoce_n": "1006",
            "final_date": "19 - SEP - 2019",
            "credit": "230",
            "balance": -230,
            "debit": ""
        }
         @IBOutlet weak var dateLabel: UILabel!
         @IBOutlet weak var invoiceNoLabel: UILabel!
         @IBOutlet weak var receiptNoLabel: UILabel!
         @IBOutlet weak var descriptionlabel: UILabel!
         @IBOutlet weak var debitLabel: UILabel!
         @IBOutlet weak var creditLabel: UILabel!
         @IBOutlet weak var balanceLabel: UILabel!*/
        let item = self.dataForTableView[indexPath.row]
        cell.dateLabel.text = "Date : \(item["date"] ?? "")"
        cell.invoiceNoLabel.text = "Invoice No : \(item["invoice_no"] ?? "")"
        cell.receiptNoLabel.text = "Receipt No : \(item["receipt_no"] ?? "")"
        cell.descriptionlabel.text = "Description : \(item["description"] ?? "")"
        cell.creditLabel.text = "Credit : $ \(item["credit"] ?? "")"
        cell.balanceLabel.text = "Balance : $ \(item["balance"] ?? "")"
        cell.debitLabel.text = "Debit : \(item["debit"] ?? "")"
                cell.cellView.layer.shadowColor = UIColor.lightGray
                cell.cellView.layer.shadowOpacity = 1
                cell.cellView.layer.masksToBounds = false
                cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK :- Network
    func toGetDataFromServer()
       {
           let url : URL = URL(string:BaseUrl + "/customerdetail")!
            //"/invoiceList/" + "\(USERTYPE)/" + "\(USERID)")!
             let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let parameter = [
        "user_type":USERTYPE,
        "user_id":USERID,
        "customer_id":USERID
        ]
                   AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                       print(response.request as Any)  // original URL request
                       print(response.response as Any)// URL response
                       let response1 = response.response
                       if response1?.statusCode == 200
                       {
                            do{
                               let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                               print(jsonRespone)
                               // self.jsonDic = jsonRespone
                                self.dataForTableView = jsonRespone["ledgers"] as! [NSDictionary]
                                if self.dataForTableView.count == 0
                                {
                                    Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                }
                                // "total_credit": "230.00",
                                 //  "total_debit": "0.00",
                                 //  "total_balance": "-230.00",
                                self.totalCreditLabel.text = "Total Credit : $ \(jsonRespone["total_credit"] ?? "")"
                                self.totalBalanceLabel.text = "Total Balance : $ \(jsonRespone["total_balance"] ?? "")"
                                self.totalDebitLabel.text = "Total Debit : $ \(jsonRespone["total_debit"] ?? "")"
                            self.customerLedgerTableView.reloadData()
                               } catch let parsingError {
                                  print("Error", parsingError)
                             }
                       }
                   }
       }
}
