//
//  RoleListViewController.swift
//  AyersERP
//
//  Created by Hari on 12/12/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire

class RoleListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roleId: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var roleNameLabel: UILabel!
}

class RoleListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var transView: UIView!
       @IBOutlet weak var roleListTableView: UITableView!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.roleListTableView.delegate = self
               self.roleListTableView.dataSource = self
               self.transView.isHidden = true
               self.roleListTableView.tableFooterView =  UIView(frame: .zero)
    }
    


     override func viewWillAppear(_ animated: Bool) {
   
            if CheckInternet.Connection(){
                  getDataForRoleList()
            }else{
            Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
        }
        }

        // MARK: - Tableview Delegates
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.dataForTableView.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView .dequeueReusableCell(withIdentifier: "RoleListTableViewCellId", for: indexPath) as! RoleListTableViewCell
            
          
            let item = self.dataForTableView[indexPath.row]
            cell.roleNameLabel.text = "Role Name : \(item["type"] ?? "")"
            cell.roleId.text = "Role Id : \(item["id"] ?? "")"
           
            cell.cellView.layer.shadowColor = UIColor.lightGray
            cell.cellView.layer.shadowOpacity = 1
            cell.cellView.layer.masksToBounds = false
            cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
            cell.cellView.layer.cornerRadius = 8
            
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 95
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
      

        // MARK: - ButtonActions
        @IBAction func backBtnAction(_ sender: UIButton) {
             self.navigationController?.popViewController(animated: true)
        }
        
        //MARK:- Network
        func getDataForRoleList()
           {
               let url : URL = URL(string: "https://ayersfood.com/erpapi/api/Rolelist")!
            let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
             //  let headerData = ["customer_id":USERID,"user_type":USERTYPE]
                       AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                           print(response.request as Any)  // original URL request
                           print(response.response as Any)// URL response
                           let response1 = response.response
                           if response1?.statusCode == 200
                           {
                                do{
                                    //categoryName
                                   let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                   print(jsonRespone)
                                    var items = NSDictionary()
                                   items = jsonRespone as! NSDictionary
                                   self.dataForTableView = items["user_list"] as! [NSDictionary]
                                  if self.dataForTableView.count == 0
                                  {
                                      Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                  }
                                   
                                   self.roleListTableView.reloadData()
                                  // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                                   } catch let parsingError {
                                      print("Error", parsingError)
                                 }
                              // let dataFromServer =
                           }
                       }
           }

}
