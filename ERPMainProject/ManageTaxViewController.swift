//
//  ManageTaxViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageTaxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var taxIdLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIView!
}

class ManageTaxViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var manageTaxTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageTaxTableView.delegate = self
        self.manageTaxTableView.dataSource = self
        self.transView.isHidden = true
        self.manageTaxTableView.tableFooterView =  UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.getDataForManageCustomer()
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
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageTaxTableViewCellId", for: indexPath) as! ManageTaxTableViewCell
        
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        /*{
            "tax_id": "95RKLF5DFX",
            "tax": "10",
            "status": "1"
        }*/
        let item = self.dataForTableView[indexPath.row]
        cell.taxLabel.text = "Tax : \(item["tax"] ?? "") %"
        cell.taxIdLabel.text = "Tax Id : \(item["tax_id"] ?? "") "
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
     // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func DeleteBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func editBtnAction(_ sender: UIButton) {
    }
    //http://lanciusit.com/demo/erpapi/api/taxlist
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
        let url : URL = URL(string: BaseUrl + "/taxlist")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        //let headerData = ["customer_id":USERID,"dtpFromDate":"", "dtpToDate":"","search":"1"]
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
                            self.dataForTableView = items["tax_list"] as! [NSDictionary]
                           if self.dataForTableView.count == 0
                           {
                               Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                           }
                            
                            self.manageTaxTableView.reloadData()
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
