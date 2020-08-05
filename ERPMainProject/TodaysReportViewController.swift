 //
 //  TodaysReportViewController.swift
 //  CygenERP
 //
 //  Created by Kardas Veeresham on 11/28/19.
 //  Copyright © 2019 infinity Smart Solutions. All rights reserved.
 //

 import UIKit
 import Alamofire
 class TodaysReportTableViewCell: UITableViewCell {
     @IBOutlet weak var cellView: UIView!
     @IBOutlet weak var salesDateLabel: UILabel!
     @IBOutlet weak var customerNameLabel: UILabel!
     @IBOutlet weak var invoiceNoLabel: UILabel!
     @IBOutlet weak var totalAmountLabel: UILabel!
 }
 class TodaysReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
     var valueType = Bool()
     var ItemData = NSDictionary()
     @IBOutlet weak var todaysReportTableView: UITableView!
     @IBOutlet weak var transView: UIView!
     @IBOutlet weak var totalAmountLabel: UILabel!
     @IBOutlet weak var salesreportButton: UIButton!
     @IBOutlet weak var salesReportLabel: UILabel!
     @IBOutlet weak var purchaseReportButton: UIButton!
     @IBOutlet weak var purchaseReportLabel: UILabel!
     @IBOutlet weak var fragmentView: UIView!
     @IBOutlet weak var noRecordsLabel: UILabel!
     @IBOutlet weak var totalAmountView: UIView!
     
     var dataForTableView = [NSDictionary]()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         self.valueType = true
         self.todaysReportTableView.delegate = self
         self.todaysReportTableView.dataSource = self
         self.transView.isHidden = true
         self.todaysReportTableView.tableFooterView =  UIView(frame: .zero)
         
         self.salesreportButton.setTitleColor(UIColor.customBlueBG, for: .normal)
         self.salesReportLabel.backgroundColor = UIColor.customBlueBG
         self.purchaseReportButton.setTitleColor(UIColor.lightGrayBG, for: .normal)
         self.purchaseReportLabel.backgroundColor = UIColor.lightGrayBG
         Design()
         
         
         
         getDataFromServersalesreport()
     }
     
     
     
     // MARK: - Design

     func Design(){
         self.fragmentView.layer.shadowColor = UIColor.lightGray
         self.fragmentView.layer.shadowOpacity = 1
         self.fragmentView.layer.masksToBounds = false
         self.fragmentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
     }
     
     override func viewWillAppear(_ animated: Bool) {
         if CheckInternet.Connection(){
                                self.getDataFromServersalesreport()
                            }else{
                                Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                            }
     }
     // MARK: - Tableview Delegates
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.dataForTableView.count
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView .dequeueReusableCell(withIdentifier: "TodaysReportTableViewCellId", for: indexPath) as! TodaysReportTableViewCell
         
         
                 cell.cellView.layer.shadowColor = UIColor.lightGray
                 cell.cellView.layer.shadowOpacity = 1
                 cell.cellView.layer.masksToBounds = false
                 cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                 cell.cellView.layer.cornerRadius = 8
         let item = self.dataForTableView[indexPath.row]
         if self.valueType
         {
         cell.salesDateLabel.text = "Sales Date : \(item["sales_date"] ?? "")"
         cell.invoiceNoLabel.text = "Invoice No : \(item["invoice_id"] ?? "")"
         cell.totalAmountLabel.text = "Total Amount : $\(item["total_amount"] ?? "")"
         cell.customerNameLabel.text = "Customer Name : \(item["customer_name"] ?? "")"
         }
         else
         {
             cell.salesDateLabel.text = "Purchase Date : \(item["purchase_date"] ?? "")"
             cell.invoiceNoLabel.text = "Invoice No : \(item["chalan_no"] ?? "")"
             cell.totalAmountLabel.text = "Total Amount : $\(item["grand_total_amount"] ?? "")"
             cell.customerNameLabel.text = "Supplier Name : \(item["supplier_name"] ?? "")"
         }
         /* {
                    "chalan_no" = 85965;
                    "grand_total_amount" = "132.5";
                    "prchse_date" = "22 - JAN - 2020";
                    "purchase_date" = "2020-01-22";
                    "purchase_details" = 0;
                    "purchase_id" = 20200122060451;
                    sl = 1;
                    status = 1;
                    "supplier_id" = CWG7EX7M66ZGIKY7ZBBL;
                    "supplier_name" = lotus;
                    "total_discount" = 0;
                }*/
         /*{
             "invoice_id": "1966793892",
             "customer_id": "ZPYJ2DYWK43MDIF",
             "date": "2020-01-22",
             "total_amount": "39.6",
             "prevous_due": "37418.1",
             "shipping_cost": "3.6",
             "invoice": "1109",
             "invoice_discount": "0",
             "total_discount": "0",
             "total_tax": "0",
             "invoice_details": "0",
             "status": "1",
             "invoiceType": "1",
             "prevous_due_invoice": "39.00",
             "invoice_paid_amount": "0.00",
             "incoice_created_user_type": "1",
             "incoice_created_by": "1",
             "invoiceTypeFor": "1",
             "delivery_date": "2020-01-22 11:33:00",
             "delivery_day": "0",
             "invoice_create_date": "2020-01-22 11:33:00",
             "customer_name": "MasonQ",
             "sl": 1,
             "sales_date": "22 - JAN - 2020"
         }*/
         
         return cell
     }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 135
     }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
     }
     
     
     // MARK: - ButtonActions
     @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }

     @IBAction func salesReportbtnAction(_ sender: UIButton) {
        // getDataFromServersalesreport()
         self.valueType = true
          self.setdataFoTableView()
         self.salesreportButton.setTitleColor(UIColor.customBlueBG, for: .normal)
         self.salesReportLabel.backgroundColor = UIColor.customBlueBG
         self.purchaseReportButton.setTitleColor(UIColor.lightGrayBG, for: .normal)
         self.purchaseReportLabel.backgroundColor = UIColor.lightGrayBG
         
     }
     
     @IBAction func purchaseReportBtnAction(_ sender: Any) {
         
         self.salesreportButton.setTitleColor(UIColor.lightGrayBG, for: .normal)
         self.salesReportLabel.backgroundColor = UIColor.lightGrayBG
         self.purchaseReportButton.setTitleColor(UIColor.customBlueBG, for: .normal)
         self.purchaseReportLabel.backgroundColor = UIColor.customBlueBG
         
          self.valueType = false
          self.setdataFoTableView()
       //  self.todaysReportTableView.isHidden = true
        // self.totalAmountView.isHidden = true
        // self.noRecordsLabel.isHidden = false
     }
 func setdataFoTableView()
 {
     if self.valueType
     {
      self.dataForTableView =  self.ItemData["sales_report"] as! [NSDictionary]
         self.totalAmountLabel.text = "Total Amount : $ \(self.ItemData["sales_amount"] ?? "")"
             //self.ItemData["sales_amount"] as! String
     }
     else
     {
       self.dataForTableView =  self.ItemData["purchase_report"] as! [NSDictionary]
         self.totalAmountLabel.text = "Total Amount : $ \(self.ItemData["purchase_amount"] ?? "")" //self.ItemData["purchase_amount"] as! String
     }
     if self.dataForTableView.count == 0  {
         self.todaysReportTableView.isHidden = true
         self.totalAmountView.isHidden = true
         self.noRecordsLabel.isHidden = false
     }else{
         self.todaysReportTableView.isHidden = false
         self.totalAmountView.isHidden = false
         self.noRecordsLabel.isHidden = true
     }
     self.todaysReportTableView.reloadData()
     }
     
     // MARK: - Network
     
     func getDataFromServersalesreport()
     {
         let url : URL = URL(string: BaseUrl + "/todays_sales_report")!
         //todays_sales_report
         let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
         AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
             print(response.request as Any)  // original URL request
             print(response.response as Any)// URL response
             let response1 = response.response
             if response1?.statusCode == 200
             {
                 do{
                     let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                     print(jsonRespone)
                    // var items = NSDictionary()
                     self.ItemData = jsonRespone as! NSDictionary
                     self.setdataFoTableView()
                     self.dataForTableView =  self.ItemData["sales_report"] as! [NSDictionary]
                
                     if self.dataForTableView.count == 0
                     {
                         Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                     }
 //                    if self.dataForTableView.count == 0  {
 //                        self.todaysReportTableView.isHidden = true
 //                        self.totalAmountView.isHidden = true
 //                        self.noRecordsLabel.isHidden = false
 //                    }else{
 //                        self.todaysReportTableView.isHidden = false
 //                        self.totalAmountView.isHidden = false
 //                        self.noRecordsLabel.isHidden = true
 //                    }
                     
                    // self.todaysReportTableView.reloadData()
                     // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                 } catch let parsingError {
                     print("Error", parsingError)
                 }
                 // let dataFromServer =
             }
         }
     }
     
 }
