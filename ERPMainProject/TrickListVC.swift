//
//  TrickListVC.swift
//  CygenERP
//
//  Created by Hari on 08/03/20.
//  Copyright © 2020 Lancius. All rights reserved.
//

import UIKit
import Alamofire
class TrickListTableViewCell : UITableViewCell{
     @IBOutlet weak var trickNumberLabel: UILabel!
    @IBOutlet weak var trickIdLabel: UILabel!
}
class TrickListVC: UIViewController, UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var manageTrickTableView: UITableView!
    var truckList = [NSDictionary]()
    @IBOutlet weak var transView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manageTrickTableView.delegate = self
        self.manageTrickTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func getDataForSupplierList()
          {
            self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
              let url : URL = URL(string: BaseUrl + "/tricklist")!
            let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
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
                                  print(items)
                                  self.truckList = items["driver_list"] as! [NSDictionary]
                                 if self.truckList.count == 0
                                 {
                                     Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                 }
                                self.manageTrickTableView.reloadData()
                                 // self.pickerView.reloadAllComponents()
                                  
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
        return self.truckList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrickListTableViewCellId", for: indexPath) as! TrickListTableViewCell
        let item = self.truckList[indexPath.row] as! NSDictionary
        cell.trickIdLabel.text = "Truck Id : \(item["truck_id"] ?? "")"
         cell.trickNumberLabel.text = "Truck Number : \(item["truck_number"] ?? "")"
        /*"id": "1",
        "truck_id": "5GNL8Q3PNLLSLZO",
        "truck_number": "ASGT456323ER3",
        "status": "1"*/
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 90
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
