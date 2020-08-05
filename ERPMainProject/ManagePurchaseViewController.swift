//
//  ManagePurchaseViewController.swift
//  CygenERP
//
//  Created by Hari on 23/11/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManagePurchaseTableViewCell : UITableViewCell
{
    @IBOutlet weak var invoiceLabel: UILabel!
    
    @IBOutlet weak var daleteBt: UIButton!
    @IBOutlet weak var totalAmountlLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var purchaseIdLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
}

class ManagePurchaseViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var managePurchaseTableview: UITableView!
       @IBOutlet weak var transView: UIView!
    var dataForTableView = [NSDictionary]()
    @IBOutlet weak var totalAmountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.managePurchaseTableview.delegate = self
        //self.managePurchaseTableview.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.transView.isHidden = true
        self.getDataForManageCustomer()
        
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
       }
    
//MARK:- TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagePurchaseTableViewCellId", for: indexPath) as! ManagePurchaseTableViewCell
        /* {
                                           "chalan_no" = 52;
                                           "final_date" = "10 - OCT - 2019";
                                           "grand_total_amount" = 120;
                                           "purchase_date" = "2019-10-10";
                                           "purchase_details" = "";
                                           "purchase_id" = 20191010100127;
                                           sl = 2;
                                           status = 1;
                                           "supplier_id" = M5HLOM3YVTDLN2JR6H4J;
                                           "supplier_name" = AYERS;
                                           "total_discount" = "<null>";*/
        let item = self.dataForTableView[indexPath.row]
        cell.purchaseDateLabel.text = "Purchase Date : \(item["purchase_date"] ?? "")"
        cell.purchaseIdLabel.text = "Purchase Id : \(item["purchase_id"] ?? "")"
        cell.totalAmountlLabel.text = "Total Amount : $\(item["grand_total_amount"] ?? "")"
        cell.supplierNameLabel.text = "Supplier Name : \(item["supplier_name"] ?? "")"
        cell.invoiceLabel.text = "Invoice No : \(item["chalan_no"] ?? "")"
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
               cell.cellView.layer.shadowOpacity = 1
               cell.cellView.layer.masksToBounds = false
               cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    //MARK:- Network
    func getDataForManageCustomer()
       {
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
           let url : URL = URL(string: BaseUrl + "/purchaseList")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
          let headerData = ["user_type":USERTYPE]
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
                                /*"purchases_list" =     (
                                        {
                                    "chalan_no" = 52;
                                    "final_date" = "10 - OCT - 2019";
                                    "grand_total_amount" = 120;
                                    "purchase_date" = "2019-10-10";
                                    "purchase_details" = "";
                                    "purchase_id" = 20191010100127;
                                    sl = 2;
                                    status = 1;
                                    "supplier_id" = M5HLOM3YVTDLN2JR6H4J;
                                    "supplier_name" = AYERS;
                                    "total_discount" = "<null>";
                                }*/
                                self.totalAmountLabel.text = "\(items[""] ?? "")"
                               self.dataForTableView = items["purchases_list"] as! [NSDictionary]
                                if self.dataForTableView.count == 0
                                {
                                    Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                }
                                                self.managePurchaseTableview.reloadData()
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

}
