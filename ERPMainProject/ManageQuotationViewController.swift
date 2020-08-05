//
//  ManageQuotationViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageQuotationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quotationIdLabel: UILabel!
    @IBOutlet weak var quotationNoLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var invoiceButton: UIButton!
    @IBOutlet weak var convertToQuotationButton: UIButton!
    
}

class ManageQuotationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataFromTableView = [NSDictionary]()
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var manageQuotationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageQuotationTableView.delegate = self
        self.manageQuotationTableView.dataSource = self
        self.transView.isHidden = true
        self.manageQuotationTableView.tableFooterView =  UIView(frame: .zero)
        
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
        return self.dataFromTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageQuotationTableViewCellId", for: indexPath) as! ManageQuotationTableViewCell
        
        
        cell.invoiceButton.layer.cornerRadius = 4
        cell.convertToQuotationButton.layer.cornerRadius = 4
        
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
       // cell.cellView.layer.cornerRadius = 8
        /*{
            "customer_id" = KLTSD3RIZG6QS4N;
            "customer_name" = sudhakar;
            date = "2019-11-06";
            "delivery_date" = "2019-11-06 22:47:11";
            "delivery_day" = 0;
            "final_date" = "6 - NOV - 2019";
            "incoice_created_by" = VOVH4ITbhFfSzIp;
            "incoice_created_user_type" = 2;
            invoice = 1097;
            invoiceType = 1;
            invoiceTypeFor = 2;
            "invoice_create_date" = "2019-11-06 22:47:11";
            "invoice_details" = "";
            "invoice_discount" = 0;
            "invoice_id" = 7463643815;
            "invoice_paid_amount" = "0.00";
            "prevous_due" = 0;
            "prevous_due_invoice" = "33.00";
            "shipping_cost" = 3;
            sl = 2;
            status = 1;
            "total_amount" = 33;
            "total_discount" = 0;
            "total_tax" = 0;
        }*/
        let item = self.dataFromTableView[indexPath.row]
        cell.quotationIdLabel.text = "Quotations Id : \(item["invoice_id"] ?? "")"
        cell.quotationNoLabel.text = "Quotations No : \(item["invoice"] ?? "")"
        cell.nameLabel.text = "Customer Name : \(item["customer_name"] ?? "")"
        cell.datelabel.text = "Date : \(item["final_date"] ?? "")"
        cell.totalAmountLabel.text = "Total Amount : $\(item["total_amount"] ?? "")"
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
    
    @IBAction func invoiceBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForWebViewControllerId") as? ForWebViewController
                let item = self.dataFromTableView[sender.tag]
        //
        //               cell.invoiceNumberLabel.text = "Invoice No : \(item["invoice_id"] ?? "")"
                let id = item["invoice_id"] as! String
                vc?.forViewUrl = "http://ayersfood.com/erp_beta/Cinvoice/invoice_webview/" + id
                     self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func convertToQuatationBtnAction(_ sender: UIButton) {
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let item = self.dataFromTableView[sender.tag]
        let invoice_id = item["invoice_id"] as! String
        //http://infysmart.com/erpapi/api/quotationList/1/1/1
           let url : URL = URL(string: BaseUrl + "/converttoInvoice")!
           let headerData = ["user_type": USERTYPE ,"invoice_id": invoice_id]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                   AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                       print(response.request as Any)  // original URL request
                       print(response.response as Any)// URL response
                       let response1 = response.response
                    DispatchQueue.main.async {
                    self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                       if response1?.statusCode == 200
                       {
                        self.getDataForManageCustomer()
                       }
                   }
        }
      /*http://ayersfood.com/erpapi/api/converttoInvoice
      params:
      {
      "user_type":"1",
      "invoice_id":"2275489947"
      }*/
    }
    //MARK:- Network
    func getDataForManageCustomer()
       {
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        //http://infysmart.com/erpapi/api/quotationList/1/1/1
           let url : URL = URL(string: BaseUrl + "/quotationList/" + "\(USERTYPE)/" + "\(USERID)/" + "1")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
           let headerData = [
           "user_type":USERTYPE,
           "user_id":USERID,
           "customer_id":USERID
           
]
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
                               self.dataFromTableView = items["invoices_list"] as! [NSDictionary]
                              
                               if self.dataFromTableView.count == 0
                               {
                                   Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                               }
                               self.manageQuotationTableView.reloadData()
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
