//
//  ManageUnitViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageUnitTableViewCell: UITableViewCell {
    @IBOutlet weak var unitIdLabel: UILabel!
    @IBOutlet weak var unitNameLabel: UILabel!
    
    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteButtonView: UIView!
}

class ManageUnitViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dataFromServer = [NSDictionary]()
    @IBOutlet weak var manageUnitTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageUnitTableView.delegate = self
        self.manageUnitTableView.dataSource = self
        self.transView.isHidden = true
        self.manageUnitTableView.tableFooterView =  UIView(frame: .zero)
    
    }
    override func viewWillAppear(_ animated: Bool) {
        if CheckInternet.Connection(){
                  self.getDataFromServer()
              }else{
                  Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
              }
    }


    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataFromServer.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageUnitTableViewCellId", for: indexPath) as! ManageUnitTableViewCell
        
        
        cell.cellview.layer.shadowColor = UIColor.lightGray
        cell.cellview.layer.shadowOpacity = 1
        cell.cellview.layer.masksToBounds = false
        cell.cellview.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellview.layer.cornerRadius = 8
        /*{
            sl = 2;
            status = 1;
            "unit_id" = VTMRJYPN9OY24BI;
            "unit_name" = "100g x 20";
        }*/
        var item : NSDictionary = self.dataFromServer[indexPath.row]
        cell.unitIdLabel.text = "Unit Id : \(item["unit_id"] ?? "")"
        cell.unitNameLabel.text = "Unit Name : \(item["unit_name"] ?? "") "
        //cell.label
        //"Unit Id : \(item["unit_id] ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    // http://infysmart.com/erpapi/api/unitList/1
    func getDataFromServer()
    {
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        print("\(BaseUrl)")
        let url : URL = URL(string: BaseUrl + "/unitList/" + USERTYPE)!
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
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                             var items = NSDictionary()
                            items = jsonRespone as! NSDictionary
                            print("\(items)")
                            
                            self.dataFromServer = items["unit_list"] as! [NSDictionary]
                            if self.dataFromServer.count == 0
                            {
                                Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                            }
                            self.manageUnitTableView.reloadData() //UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                            
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                    }
                }
    }
    // MARK: - Button Actiones

    @IBAction func backbtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func deletebtnAction(_ sender: UIButton) {
    }
}
