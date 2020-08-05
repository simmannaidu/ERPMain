//
//  SupplierLedgerReportVC.swift
//  ERP
//
//  Created by Hari on 21/01/20.
//  Copyright © 2020 Lancius. All rights reserved.
//

import UIKit
import Alamofire
class SupplierLedgerReportTableViewCell : UITableViewCell {
    
    @IBOutlet weak var balanceAmountLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var CreditLabel: UILabel!
    @IBOutlet weak var DebitLabel: UILabel!
    @IBOutlet weak var DepositeIdLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var invoiceIdLabel: UILabel!
}
class SupplierLedgerReportVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
       @IBOutlet weak var transView: UIView!
    @IBOutlet weak var supplierLedgerReportTableView: UITableView!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.supplierLedgerReportTableView.delegate = self
        self.supplierLedgerReportTableView.dataSource = self
        // Do any additional setup after loading the view.
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
           let cell = tableView .dequeueReusableCell(withIdentifier: "SupplierLedgerReportTableViewCellId", for: indexPath) as! SupplierLedgerReportTableViewCell
           
           
           cell.cellView.layer.shadowColor = UIColor.lightGray
           cell.cellView.layer.shadowOpacity = 1
           cell.cellView.layer.masksToBounds = false
           cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
           cell.cellView.layer.cornerRadius = 8
           
           /*{
              {
                   {
                              "id": "1",
                              "transaction_id": "5JW8WF31ID",
                              "supplier_id": "CWG7EX7M66ZGIKY7ZBBL",
                              "chalan_no": "Adjustment ",
                              "deposit_no": null,
                              "amount": "0",
                              "description": "Previous adjustment with software",
                              "payment_type": "NA",
                              "cheque_no": "NA",
                              "date": "2019-08-26",
                              "status": "1",
                              "d_c": "c",
                              "credit": "0",
                              "balance": 0,
                              "debit": ""
                          },
               },;
         CreditLabel: UILabel!
         @IBOutlet weak var DebitLabel: UILabel!
         @IBOutlet weak var DepositeIdLabel: UILabel!
         @IBOutlet weak var dateLabel: UILabel!
         @IBOutlet weak var DescriptionLabel: UILabel!
         @IBOutlet weak var invoiceIdLabel: UILabel!
           }*/
           let item = self.dataForTableView[indexPath.row]
        cell.dateLabel.text = "\(item["date"] ?? "")"
        cell.invoiceIdLabel.text = "\(item["transaction_id"] ?? "")"
       // cell.dateLabel.text = "\(item["chalan_no"] ?? "")"
        cell.DescriptionLabel.text = "\(item["description"] ?? "")"
        cell.CreditLabel.text = "$ \(item["credit"] ?? "")"
        cell.DebitLabel.text = "$ \(item["debit"] ?? "")"
        cell.balanceAmountLabel.text = "$ \(item["balance"] ?? "")"
          // cell.supplierNameLabel.text = "Supplier Name : \(item["supplier_name"] ?? "")"

           return cell
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 160
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
       }
       
       
       
       // MARK: - ButtonActions
       @IBAction func backBtnAction(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
       }
       @IBAction func deleteBtnAction(_ sender: UIButton) {
       }
       //http://infysmart.com/erpapi/api/supplierList/1
       //MARK:- Network
          func getDataForManageCustomer()
             {
               self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
                let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                 let url : URL = URL(string: BaseUrl + "/supplierLedgerReport")!
                // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
                         AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
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
                                     self.dataForTableView = items["ledgers"] as! [NSDictionary]
                                    if self.dataForTableView.count == 0
                                    {
                                        Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                    }
                                     
                                     self.supplierLedgerReportTableView.reloadData()
                                     // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                                     } catch let parsingError {
                                        print("Error", parsingError)
                                   }
                                // let dataFromServer =
                             }
                         }
               }
             }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - ButtonActions
         
}
