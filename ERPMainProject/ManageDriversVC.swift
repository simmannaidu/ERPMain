//
//  ManageDriversVC.swift
//  CygenERP
//
//  Created by Hari on 08/03/20.
//  Copyright © 2020 Lancius. All rights reserved.
//

import UIKit
import Alamofire
class manageDriversTableViewCell : UITableViewCell{
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var driverIdLabel: UILabel!
}
class ManageDriversVC: UIViewController , UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var manageDriversTableView: UITableView!
    var driverList = [NSDictionary]()
@IBOutlet weak var transView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manageDriversTableView.delegate = self
        self.manageDriversTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
     "driver_list": [
         {
             "id": "1",
             "driver_id": "661OX9PR8158QCF",
             "driver_name": "ANUTGGH",
             "driver_mobile": "7894561236",
             "driver_address": "5-90,NSW",
             "status": "1"
         }
     ]
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getDataForSupplierList()
       {
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
           let url : URL = URL(string: BaseUrl + "/driverlist")!
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
                               self.driverList = items["driver_list"] as! [NSDictionary]
                              if self.driverList.count == 0
                              {
                                  Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                              }
                            self.manageDriversTableView.reloadData()
                               
                               //self.manageSupplierTableVIew.reloadData()
                              // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                               } catch let parsingError {
                                  print("Error", parsingError)
                             }
                          // let dataFromServer =
                       }
                   }
         }
       }
    // MARK: - TableViewDelegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.driverList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageDriversTableViewCellId", for: indexPath) as! manageDriversTableViewCell
        let item = self.driverList[indexPath.row] as! NSDictionary
        cell.driverIdLabel.text = "Driver Id : \(item["driver_id"] ?? "")"
         cell.driverNameLabel.text = "Driver Name : \(item["driver_name"] ?? "")"
         cell.mobileNumberLabel.text = "Mobile : \(item["driver_mobile"] ?? "")"
         cell.addressLabel.text = "Address : \(item["driver_address"] ?? "")"
        /*
            "driver_list": [
                {
                    "id": "1",
                    "driver_id": "661OX9PR8158QCF",
                    "driver_name": "ANUTGGH",
                    "driver_mobile": "7894561236",
                    "driver_address": "5-90,NSW",
                    "status": "1"*/
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 90
    }
}
