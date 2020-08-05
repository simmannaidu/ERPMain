//
//  OutboxMessageViewController.swift
//  DummyERP
//
//  Created by Kardas Veeresham on 1/8/20.
//  Copyright © 2020 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class OutboxMessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var receiverLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
}


class OutboxMessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var outboxMessageTableView: UITableView!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.outboxMessageTableView.delegate = self
        self.outboxMessageTableView.dataSource = self
        self.transView.isHidden = true
        self.outboxMessageTableView.tableFooterView =  UIView(frame: .zero)
        
    }
    

    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "OutboxMessagesTableViewCellId", for: indexPath) as! OutboxMessagesTableViewCell
        
        
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
        
    }
   

    // MARK: - BackBtnAction
    
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func messageDFetailBtnAction(_ sender: UIButton) {
        
    }
    func getDataFromServer()
    {
         showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                let url : URL = URL(string: BaseUrl + "/manageinbox")!
                let headerData = ["user_id":USERID]
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
                                    self.outboxMessageTableView.reloadData()
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
