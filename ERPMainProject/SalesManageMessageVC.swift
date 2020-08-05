//
//  SalesManageMessageVC.swift
//  ERP
//
//  Created by Hari on 04/01/20.
//  Copyright © 2020 Lancius. All rights reserved.
//

import UIKit
import Alamofire
class SalesManageMessageTableViewCell: UITableViewCell  {
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}
class SalesManageMessageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var manageMessageTableView: UITableView!
   var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manageMessageTableView.delegate = self
               self.manageMessageTableView.dataSource = self
               self.transView.isHidden = true
              
               self.manageMessageTableView.tableFooterView =  UIView(frame: .zero)
        // Do any additional setup after loading the view.
    }
      override func viewWillAppear(_ animated: Bool) {
    //        self.getDataForManageCustomer()
            if CheckInternet.Connection(){
               // self.getNotification()
                                   self.getDataForManageCustomer()
                               }else{
                                   Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                               }
        }

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Tableview Delegates
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.dataForTableView.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView .dequeueReusableCell(withIdentifier: "SalesManageMessageTableViewCellId", for: indexPath) as! SalesManageMessageTableViewCell
            
            /*{
                id = 3;
                "message_date" = "2019-10-23 13:35:02";
                "message_detail" = "FCG2D9IJ1GVOU6X Request For Update Profile";
                "message_read" = 0;
                "message_subject" = "Request For Update Profile";
                receiver = 1;
                sender = "Customer ( FCG2D9IJ1GVOU6X)";
                status = 0;
                "user_type" = 1;
            }*/
            let item = self.dataForTableView[indexPath.row]
            cell.messageLabel.text = "Message : \(item["message_detail"] ?? "")"
            cell.subjectLabel.text = "Subject : \(item["message_subject"] ?? "")"
            cell.userLabel.text = "User : \(item["sender"] ?? "")"
            cell.cellView.layer.shadowColor = UIColor.lightGray
            cell.cellView.layer.shadowOpacity = 1
            cell.cellView.layer.masksToBounds = false
            cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
            cell.cellView.layer.cornerRadius = 8
            
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 110
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
    func getDataForManageCustomer()
    {
        let url : URL = URL(string: "https://ayersfood.com/erpapi/api/managemessage")!
        let headerData = ["customer_id":USERID,"user_type":USERTYPE]
                AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
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
                            self.dataForTableView = items["message_list"] as! [NSDictionary]
                           
                            
                            self.manageMessageTableView.reloadData()
                           // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                }
    }
    func getNotification()
        {
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
            let url : URL = URL(string:BaseUrl + "/notification")!
                    
                    
                    AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any)// URL response
                        let response1 = response.response
                     DispatchQueue.main.async {
                                            self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                        if response1?.statusCode == 200
                        {
                            /*
                                "title": "notification",
                                "out_of_stock": 3,
                                "balance": "$ 317.5",
                                "message": 10,
                                "incompleteUser": 0,
                                "invoice": 12,
                                "newApplicant": 0
                            }*/
                            do{
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                                
//                            self.newApplicationBadgeLabel.text = "\(jsonRespone["newApplicant"] ?? "")"
//                                self.updateApplicationBadgeLabel.text = "\(jsonRespone["incompleteUser"] ?? "")"
//                                self.messageBadgeCountLabel.text = "\(jsonRespone["message"] ?? "")"
//                                self.outOfStockBadgeCountLabel.text = "\(jsonRespone["out_of_stock"] ?? "")"
//                                self.recentInvoiceBadgeCountLabel.text = "\(jsonRespone["invoice"] ?? "")"
                            }
                            catch
                            {
                                
                            }
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
