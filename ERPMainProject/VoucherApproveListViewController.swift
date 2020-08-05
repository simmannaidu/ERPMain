//
//  VoucherApproveListViewController.swift
//  ERP
//
//  Created by Hari on 21/01/20.
//  Copyright © 2020 Lancius. All rights reserved.
//

import UIKit
import Alamofire
class VoucherApproveListTableViewCell : UITableViewCell
{
    
    @IBOutlet weak var isActiveBt: UIButton!
    @IBOutlet weak var isActiveImage: UIImageView!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var debitLabel: UILabel!
    @IBOutlet weak var voucherNoLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
}
class VoucherApproveListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
   @IBOutlet weak var transView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        getDataForServer()
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoucherApproveListTableViewCellId", for: indexPath) as! VoucherApproveListTableViewCell
        let item = self.dataForTableView[indexPath.row]
        cell.voucherNoLabel.text = String("Voucher No : \(item["ID"] ?? "")")
            //+ item["ID"] as? String
        cell.debitLabel.text = String("Debit : $ \(item["Debit"] ?? "")")
            //item["Debit"] as? String
        cell.creditLabel.text = String("Credit : $ \(item["Credit"] ?? "")")
            //item["Credit"] as? String
        cell.remarkLabel.text = item["ID"] as? String
        cell.cellView.layer.shadowColor = UIColor.gray.cgColor
               cell.cellView.layer.shadowOpacity = 1
                cell.layer.masksToBounds = false
               cell.cellView.layer.shadowOffset = CGSize(width:1, height: 1)
               cell.cellView.layer.shadowRadius = 2
               cell.cellView.layer.cornerRadius = 8
        /* "ID": "687",
                   "VNo": null,
                   "Vtype": "DV",
                   "VDate": "0000-00-00",
                   "COAID": "102010201",
                   "Narration": null,
                   "Debit": "0.00",
                   "Credit": "200.00",
                   "IsPosted": "1",
                   "CreateBy": "1",
                   "CreateDate": "2020-01-21 07:19:01",
                   "UpdateBy": "0",
                   "UpdateDate": "0000-00-00 00:00:00",
                   "IsAppove": "0",
                   "invoiceQuationacc_transaction": "1*/
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    /*"aprrove_list": [
    {
        "ID": "687",
        "VNo": null,
        "Vtype": "DV",
        "VDate": "0000-00-00",
        "COAID": "102010201",
        "Narration": null,
        "Debit": "0.00",
        "Credit": "200.00",
        "IsPosted": "1",
        "CreateBy": "1",
        "CreateDate": "2020-01-21 07:19:01",
        "UpdateBy": "0",
        "UpdateDate": "0000-00-00 00:00:00",
        "IsAppove": "0",
        "invoiceQuationacc_transaction": "1"
    }*/
    func getDataForServer()
    {
      self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/voucherApproveList")!
       // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
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
                            print(items)
                            self.dataForTableView = items["aprrove_list"] as! [NSDictionary]
                            
                            self.mainTableView.reloadData() //self.manageSupplierTableVIew.reloadData()
                           // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                }
      }
    }
    // MARK: - ButtonActions
       @IBAction func backBtnAction(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
       }
}
