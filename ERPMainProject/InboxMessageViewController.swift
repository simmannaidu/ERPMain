//
//  InboxMessageViewController.swift
//  DummyERP
//
//  Created by Kardas Veeresham on 1/8/20.
//  Copyright © 2020 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class InboxMessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}


class InboxMessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var inboxMessageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.inboxMessageTableView.delegate = self
        self.inboxMessageTableView.dataSource = self
        self.transView.isHidden = true
        self.inboxMessageTableView.tableFooterView =  UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getDataFromServer()
    }
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "InboxMessagesTableViewCellId", for: indexPath) as! InboxMessagesTableViewCell
        let item = self.dataForTableView[indexPath.row]
        
        cell.userLabel.text = item["message_sender"] as? String
        cell.messageLabel.text = item["message_detail"] as? String
        cell.subjectLabel.text = item["message_subject"] as? String
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MessageDetailsViewControllerId") as? MessageDetailsViewController
        let item = self.dataForTableView[indexPath.row]
               vc?.messagedetailStr = "\(item["message_detail"] ?? "")"
                vc?.messageTitleStr = "\(item["message_subject"] ?? "")"
        self.navigationController?.pushViewController(vc!, animated: true)
             //  self.present(vc!, animated: true, completion: nil)
        
    }
   

    
    // MARK: - BackBtnAction
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func messageDetailBtnAction(_ sender: UIButton) {
       
    }
    /*http://ayersfood.com/erpapi/api/manageinbox
    {

    "user_id" : "BEqZmikMVUvDGpQ"
    }*/
    func getDataFromServer()
    {
         showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
                let url : URL = URL(string: BaseUrl + "/manageinbox")!
                let headerData = ["user_id":USERID]
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                        AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                            DispatchQueue.main.async {
                                self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                            print(response.request as Any)  // original URL request
                            print(response.response as Any)// URL response
                            let response1 = response.response
                            if response1?.statusCode == 200
                            {
                                 do{
                                    let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                   let item = jsonRespone as! NSDictionary
                                    self.dataForTableView = item["message_list"] as! [NSDictionary]
                                    self.inboxMessageTableView.reloadData()
                                    } catch let parsingError {
                                       print("Error", parsingError)
                                    }
                            }
                                else
                                 {
                                    Alert.showBasic(titte: "Sorry", massage: "Please try again", vc: self)
                                }
                                }
                        }
    }
}
