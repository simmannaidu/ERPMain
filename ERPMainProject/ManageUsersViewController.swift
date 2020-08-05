//
//  ManageUsersViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 12/2/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire

class ManageUsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
}

class ManageUsersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var ManageUsersTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var noRecordsLabel: UILabel!
    
    var dataForTableView = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ManageUsersTableView.delegate = self
        self.ManageUsersTableView.dataSource = self
        self.transView.isHidden = true
        self.ManageUsersTableView.tableFooterView =  UIView(frame: .zero)
        
        if CheckInternet.Connection(){
            getMessageUsersData()
        }else{
            Alert.showBasic(titte: "Alert", massage: "Your Device is not connected with internet", vc: self)
        }
        
    }
    

    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageUsersTableViewCellId", for: indexPath) as! ManageUsersTableViewCell
    
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
    
        let item = self.dataForTableView[indexPath.row]
        let firstName = "\(item["first_name"] ?? "")"
        let lastName = "\(item["last_name"] ?? "")"
        cell.nameLabel.text = "Name : \(firstName + lastName)"
        cell.emailLabel.text = "Email : \(item["username"] ?? "")"
        
        let type = "\(item["user_type"] ?? "")"
        if type == "1"{
            cell.userTypeLabel.text = "UserType : \("Admin")"
        }else if type == "2"{
             cell.userTypeLabel.text = "UserType : \("User")"
        }
        else{
            cell.userTypeLabel.text = "UserType : \("Sales Person")"
        }
        
        let status = "\(item["status"] ?? "")"
        if status == "1"{
            cell.statusLabel.text = "Status : \("Active")"
        }else{
             cell.statusLabel.text = "Status : \("Inactive")"
        }
        
        
        return cell
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    
     // MARK: - Network
    
    func getMessageUsersData(){
        showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/manageuser")!
       let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
             AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
            
            DispatchQueue.main.async {
            self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
            let response1 = response.response
            if response1?.statusCode == 200
            {
                do{
                    let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                    print(jsonRespone)
                    var items = NSDictionary()
                    items = jsonRespone as! NSDictionary
                    self.dataForTableView = items["user_list"] as! [NSDictionary]
                    if self.dataForTableView.count == 0
                    {
                        Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                    }
                   if self.dataForTableView.count == 0
                   {
                    self.ManageUsersTableView.isHidden = true
                    self.noRecordsLabel.isHidden = false
                   }else{
                    self.ManageUsersTableView.isHidden = false
                    self.noRecordsLabel.isHidden = true
                    }
                    
                    self.ManageUsersTableView.reloadData()
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            }
        }
        }
    }
    
    
    
}
