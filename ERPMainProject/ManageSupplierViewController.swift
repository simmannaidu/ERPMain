//
//  ManageSupplierViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageSupplierTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var supplierIdLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    
}

class ManageSupplierViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var manageSupplierTableVIew: UITableView!
    @IBOutlet weak var transView: UIView!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageSupplierTableVIew.delegate = self
        self.manageSupplierTableVIew.dataSource = self
        self.transView.isHidden = true
        self.manageSupplierTableVIew.tableFooterView =  UIView(frame: .zero)
        
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
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageSupplierTableViewCellId", for: indexPath) as! ManageSupplierTableViewCell
        
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        /*{
            address = "H.NO 220 KINHAIGAON  POST - DEHUGAON TAL- HAVELI PUNE-412109";
            details = "H.NO 220 KINHAIGAON  POST - DEHUGAON TAL- HAVELI PUNE-412109";
            id = 80;
            mobile = 9885045371;
            sl = 1;
            status = 1;
            "supplier_id" = DDMNEU54CR9ZN2A9M1S9;
            "supplier_name" = AMBAL;
        }*/
        let item = self.dataForTableView[indexPath.row]
        cell.supplierNameLabel.text = "Supplier Name : \(item["supplier_name"] ?? "")"
         cell.supplierIdLabel.text = "Supplier Id : \(item["supplier_id"] ?? "")"
        cell.mobileNumberLabel.text = "Mobile : \(item["mobile"] ?? "")"
        cell.addressLabel.text = "Address : \(item["address"] ?? "")"
        cell.detailsLabel.text = "Details : \(item["details"] ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
              let url : URL = URL(string: BaseUrl + "/supplierList")!
            let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
             let headerData = ["user_type":USERTYPE]
             // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
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
                                  self.dataForTableView = items["suppliers_list"] as! [NSDictionary]
                                 if self.dataForTableView.count == 0
                                 {
                                     Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                 }
                                  
                                  self.manageSupplierTableVIew.reloadData()
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
