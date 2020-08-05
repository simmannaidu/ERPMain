//
//  CashBookViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class CashBookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var vocherNoLabel: UILabel!
    @IBOutlet weak var vocherTypeLabel: UILabel!
    @IBOutlet weak var particularslabel: UILabel!
    @IBOutlet weak var debitLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
}

class CashBookViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var cashBookTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var openingBalanceLabel: UILabel!
    @IBOutlet weak var totalAmountView: UIView!
    @IBOutlet weak var totalDebitLabel: UILabel!
    @IBOutlet weak var totalCreditLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cashBookTableView.delegate = self
        self.cashBookTableView.dataSource = self
        self.transView.isHidden = true
        self.cashBookTableView.tableFooterView =  UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CheckInternet.Connection(){
                      self.getDataForManageCustomer()
                      }else{
                          Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                      }
       // self.getDataForManageCustomer()
 
    }
   

    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "CashBookTableViewCellId", for: indexPath) as! CashBookTableViewCell
        
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        /*"company": [
            {
                "company_id": "1",
                "company_name": "Ayers Rock Trading ",
                "email": "sales@ayersrocktrading.com.au",
                "address": "Block C, Unit 4-5 102 Station Road, Seven Hills, 2147, NSW Australia",
                "mobile": "(61) 296362091",
                "website": "https://ayersrocktrading.com.au/",
                "status": "1"
            }
        ],
        "software_info": [
            {
                "setting_id": "1",
                "logo": "http://ayersfood.com/erp_beta/my-assets/image/logo/87837702b9978207744d78600ec2866b.png",
                "invoice_logo": "http://ayersfood.com/erp_beta/my-assets/image/logo/688a6e3084a0202635b214e213b28abb.png",
                "favicon": "http://ayersfood.com/erp_beta/my-assets/image/logo/bb914d1032f7ed4f5638a7805944b9e2.png",
                "currency": "$",
                "currency_position": "0",
                "footer_text": "Copyright Ayers Rock Trading  Pty Ltd.  All rights reserved.",
                "language": "english",
                "rtr": "0",
                "captcha": "1",
                "site_key": "",
                "secret_key": "",
                "discount_type": "1"
            }*/
        let item = self.dataForTableView[indexPath.row]
        cell.dateLabel.text = "Date : \(item[""] ?? "")"
        cell.creditLabel.text = "Credit : \(item[""] ?? "")"
        cell.vocherNoLabel.text = "Voucher No : \(item[""] ?? "")"
        cell.balanceLabel.text = "Balance : \(item[""] ?? "")"
        cell.creditLabel.text = "Credit : \(item[""] ?? "")"
        cell.vocherTypeLabel.text = "Voucher Type : \(item[""] ?? "")"
        cell.particularslabel.text = "Particulars : \(item[""] ?? "")"
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/cashbook")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let headerData = [
        "user_type":USERTYPE,
        "user_id":USERID
        ]


            //["customer_id":USERID,"dtpFromDate":"", "dtpToDate":"","search":"1"]
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
                           self.dataForTableView = items["all_product_list"] as! [NSDictionary]
                           
                            
                            self.cashBookTableView.reloadData()
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
