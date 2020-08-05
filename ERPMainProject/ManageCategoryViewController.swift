//
//  ManageCategoryViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class ManageCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var categoryIdLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var updateButton: UIView!
    @IBOutlet weak var deleteButtonView: UIView!
    
}


class ManageCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var nameOfProductArray = [String]()
    var filteredData = [String]()
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var manageCategoryTableView: UITableView!
    var dataFromTableView = [NSDictionary]()
    var allDataFromTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
      setShowToSearchView()
        self.manageCategoryTableView.delegate = self
        self.manageCategoryTableView.dataSource = self
        self.transView.isHidden = true
        self.manageCategoryTableView.tableFooterView =  UIView(frame: .zero)
        //self.getDataForManageCustomer()
    }
    func setShowToSearchView()
    {
        self.searchView.layer.shadowColor = UIColor.lightGray
                   self.searchView.layer.shadowOpacity = 1
                   self.searchView.layer.masksToBounds = false
                   self.searchView.layer.shadowOffset = CGSize(width: 1, height: 1)
                   self.searchView.layer.cornerRadius = 8
    }
    @IBAction func searchValueChange(_ sender: UITextField) {
        if self.searchTextField.text?.count != 0
        {
            forSearchAction(searchText: self.searchTextField.text!)
        }
        else
        {
            self.dataFromTableView = self.allDataFromTableView
            self.manageCategoryTableView.reloadData()
        }
    }
    @IBAction func searchBtAction(_ sender: UIButton) {
        if self.searchTextField.text?.count != 0
               {
                   forSearchAction(searchText: self.searchTextField.text!)
               }
    }
    func forSearchAction(searchText : String)
    {
     let filteredData1 = self.filteredData.filter({$0.uppercased().prefix(searchText.count) == searchText.uppercased()})
        var itemsArray = [NSDictionary]()
        for item in filteredData1
        {
            for product in self.allDataFromTableView
            {
                if item == product["category_name"] as! String
                {
                    itemsArray.append(product)
                }
            }
        }
        
        self.dataFromTableView.removeAll()
        self.dataFromTableView = itemsArray
        manageCategoryTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        if CheckInternet.Connection(){
                      self.getDataForServer1()
                      }else{
                          Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                      }
        
    }
   
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataFromTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageCategoryTableViewCellId", for: indexPath) as! ManageCategoryTableViewCell
        
        
        cell.updateButton.layer.cornerRadius = 4
        cell.deleteButtonView.layer.cornerRadius = 4
        
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        // cell.cellView.layer.cornerRadius = 8
        let item = self.dataFromTableView[indexPath.row]
        cell.categoryIdLabel.text = "Category Id : \(item["category_id"] ?? "")"
        cell.categoryNameLabel.text = "Category Name : \(item["category_name"] ?? "")"
        /*{
            "cat_image" = "http://lanciusit.com/demo/erpapi/assets/category_image/1.jpg";
            "category_id" = W15LDBOFCPYPMQ8;
            "category_name" = FROZEN;
            id = 1;
            sl = 1;
            status = 1;
        }*/
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
 // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
        
    }
    //MARK:- NETWORK
    func getDataForServer1 ()
    {
     //http://infysmart.com/erpapi/api/quotationList/1/1/1
        /*{"userStatus":"",
        "user_type":"1"
        }*/
       // let parameters = ["userStatus":"","user_type":"1"]
        //http://lanciusit.com/demo/erpapi/api/customerList
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let url : URL = URL(string:BaseUrl + "/categoryList/0")!
       // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
                AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
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
                            
                            self.dataFromTableView = items["category_list"] as! [NSDictionary]
                            self.allDataFromTableView = self.dataFromTableView
                            if self.dataFromTableView.count == 0
                            {
                                Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                            }
                            self.filteredData.removeAll()
                            for item in self.dataFromTableView
                            {
                                self.filteredData.append(item["category_name"] as! String)
                            }
                            self.manageCategoryTableView.reloadData()
                            
                           // self.manageQuotationTableView.reloadData()
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
