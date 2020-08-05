//
//  DueReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/28/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class DueReportTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var salesDateLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var invoiceNoLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var paidAmountLabel: UILabel!
    @IBOutlet weak var dueAmountLabel: UILabel!
}


class DueReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var dueReportTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var totalAmountView: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var totalPaidLabel: UILabel!
    @IBOutlet weak var totalDueLabel: UILabel!
    @IBOutlet weak var noRecordsLabel: UILabel!
     var dataForTableView = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dueReportTableView.delegate = self
        self.dueReportTableView.dataSource = self
        self.transView.isHidden = true
        self.dueReportTableView.tableFooterView =  UIView(frame: .zero)
        
    
        getDataFromServer()
    }
    override func viewWillAppear(_ animated: Bool) {
        if CheckInternet.Connection(){
                               self.getDataFromServer()
                           }else{
                               Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                           }
    }

    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "DueReportTableViewCellId", for: indexPath) as! DueReportTableViewCell
                cell.cellView.layer.shadowColor = UIColor.lightGray
                cell.cellView.layer.shadowOpacity = 1
                cell.cellView.layer.masksToBounds = false
                cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        
        let item = self.dataForTableView[indexPath.row]
        cell.salesDateLabel.text = "Sales Date : \(item["sales_date"] ?? "")"
        cell.invoiceNoLabel.text = "Invoice No : \(item["invoice_id"] ?? "")"
        cell.customerNameLabel.text = "Customer Name : \(item["customer_name"] ?? "")"
        cell.totalAmountLabel.text = "Total Amount : $\(item["total_amount"] ?? "")"
        cell.paidAmountLabel.text = "Paid Amount : $\(item["paid_amount"] ?? "")"
        cell.dueAmountLabel.text = "Due Amount : $\(item["due_amount"] ?? "")"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    // MARK: - Network
    
    func getDataFromServer()
    {
        let url : URL = URL(string: BaseUrl + "/retrieve_dateWise_DueReports")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
            print(response.request as Any)  // original URL request
            print(response.response as Any)// URL response
            let response1 = response.response
            DispatchQueue.main.async {
            self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
            if response1?.statusCode == 200
            {
                do{
                    let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                    print(jsonRespone)
                    var items = NSDictionary()
                    items = jsonRespone as! NSDictionary
                    self.dataForTableView = items["sales_report"] as! [NSDictionary]
                    if self.dataForTableView.count == 0
                    {
                        Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                    }
                    if self.dataForTableView.count == 0  {
                        self.dueReportTableView.isHidden = true
                        self.totalAmountView.isHidden = true
                        self.noRecordsLabel.isHidden = false
                    }else{
                        self.dueReportTableView.isHidden = false
                        self.totalAmountView.isHidden = false
                        self.noRecordsLabel.isHidden = true
                    }
                    
                    self.dueReportTableView.reloadData()
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
