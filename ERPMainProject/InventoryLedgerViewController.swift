//
//  InventoryLedgerViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class InventoryLedgerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var VocherNoLabel: UILabel!
    @IBOutlet weak var headOfAccountLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var debitLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
}
class InventoryLedgerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var inventoryLedgerTableView: UITableView!
    @IBOutlet weak var openingBalanceLabel: UILabel!
    @IBOutlet weak var transview: UIView!
    @IBOutlet weak var totalAmountLabel: UIView!
    @IBOutlet weak var totaldebitLabel: UILabel!
    @IBOutlet weak var totalCreditLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.inventoryLedgerTableView.delegate = self
        self.inventoryLedgerTableView.dataSource = self
        self.transview.isHidden = true
        self.inventoryLedgerTableView.tableFooterView =  UIView(frame: .zero)
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
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "InventoryLedgerTableViewCellId", for: indexPath) as! InventoryLedgerTableViewCell
        

        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        
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
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transview)
        let url : URL = URL(string: BaseUrl + "/inventory_ledger")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let headerData = [
            "user_type":USERTYPE,
        "user_id":USERID,
        "customer_id":USERID
        ]

            //["customer_id":USERID,"dtpFromDate":"", "dtpToDate":"","search":"1"]
                AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    DispatchQueue.main.async {
                    self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transview)
                    let response1 = response.response
                    if response1?.statusCode == 200
                    {
                         do{
                             //categoryName
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                             var items = NSDictionary()
                            items = jsonRespone as! NSDictionary
                          //  self.dataForTableView = items["all_product_list"] as! [NSDictionary]
                           
                            
                            self.inventoryLedgerTableView.reloadData()
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
