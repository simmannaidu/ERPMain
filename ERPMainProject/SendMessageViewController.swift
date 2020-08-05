//
//  SendMessageViewController.swift
//  DummyERP
//
//  Created by Kardas Veeresham on 1/9/20.
//  Copyright © 2020 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class SendMessageTableViewCell: UITableViewCell{

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checkedImage: UIImageView!
}


class SendMessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageSubjectView: UIView!
    @IBOutlet weak var messageSubjectTF: UITextField!
    @IBOutlet weak var messageDetailView: UIView!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popUpTransView: UIView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var SendMessageTableView: UITableView!
    
    var customersData = [NSDictionary]()
     var customersImutableData = [NSDictionary]()
var customerBoolArray = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Design()
        
        self.SendMessageTableView.delegate = self
        self.SendMessageTableView.dataSource = self
        self.transView.isHidden = true
        self.popupView.isHidden = true
        self.popUpTransView.isHidden = true
        self.SendMessageTableView.tableFooterView =  UIView(frame: .zero)
        
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hidepopUpView))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.popUpTransView?.addGestureRecognizer(mytapGestureRecognizer)
        // self.messageTextView.overrideUserInterfaceStyle = .light
        if #available(iOS 13, *) {
            self.messageSubjectTF.overrideUserInterfaceStyle = .light
            self.messageTextView.overrideUserInterfaceStyle = .light
             self.userLabel.overrideUserInterfaceStyle = .light
            // use UICollectionViewCompositionalLayout
        } else {
            // show sad face emoji
        }
        getDataCustomerData()
       
    }
    
    @objc func hidepopUpView()
    {
        self.popUpTransView.isHidden = true
        self.popupView.isHidden = true
    }

    func Design()
    {
        self.userView.layer.borderWidth = 1
        self.userView.layer.borderColor = UIColor.lightGray
        self.userView.layer.cornerRadius = 4
        self.messageSubjectView.layer.borderWidth = 1
        self.messageSubjectView.layer.borderColor = UIColor.lightGray
        self.messageSubjectView.layer.cornerRadius = 4
        self.messageDetailView.layer.borderWidth = 1
        self.messageDetailView.layer.borderColor = UIColor.lightGray
        self.messageDetailView.layer.cornerRadius = 4
    }

    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customersData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "SendMessageTableViewCellId", for: indexPath) as! SendMessageTableViewCell
        
        let item = self.customersData[indexPath.row]
        cell.customerNameLabel.text = "\(item["customer_name"] ?? "")"
        
        let itemBool = self.self.customerBoolArray[indexPath.row]
        if itemBool {
             cell.checkedImage.image = UIImage(named: "checkBox")
        }else{
            cell.checkedImage.image = UIImage(named: "box")
            
        }
       
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       let itemBool = self.customerBoolArray[indexPath.row]
        if itemBool {
                   self.customerBoolArray[indexPath.row] = false
               }else{
                   self.customerBoolArray[indexPath.row] = true
               }
        self.SendMessageTableView.reloadData()
    }
    
    
    
    
    func isInCart(data : NSDictionary) -> Bool
    {
        
        //        let cartArray = getDataFromCoreData()
        //        var i = 0
        for cart in self.customersImutableData
        {
            
            //            if productId == cart["product_id"] as! String
            //            {
            //                self.positionValue =  NSInteger(i)
            //                return true
            //            }
            //            i = i + 1
            let productId = data["customer_id"] as! String
            if productId == cart["customer_id"] as! String{
                return true
            }
        }
        return false
    }
    
    
    func addOrRemoveItemInArray(data : NSDictionary){
        
        if isInCart(data: data){
            
            // self.customersImutableData.remove(at: data)
            
        }else{
            self.customersImutableData.append(data)
        }
    }
    
    
    
    
    
    
    // MARK: - ButtonActiones
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func popupCloseBtnAction(_ sender: UIButton) {
        self.popupView.isHidden = true
        self.popUpTransView.isHidden = true
    }
    
    
    @IBAction func popUpSubmitBtnAction(_ sender: UIButton) {
      var userName = ""
//        for item in self.customersData
//        {
          //  let itemBool = self.customerBoolArray[indexPath.row]
        var i = 0
        for item in self.customerBoolArray
        {
            if item {
                if userName.count == 0
                {
                    let userItem = self.customersData[i]
                    userName = userItem["customer_name"] as! String
                }
                else
                {
                    let userItem = self.customersData[i]
                  let itemName = userItem["customer_name"] as! String
                    userName = userName + " , " + itemName
                }
                       //self.customerBoolArray[indexPath.row] = false
                   }else{
                      // self.customerBoolArray[indexPath.row] = true
                   }
            i = i + 1
        }
        self.userLabel.text = userName

        self.popupView.isHidden = true
        self.popUpTransView.isHidden = true
    }
    
    @IBAction func UserPopUpOpenBtnAction(_ sender: UIButton) {
        
        self.popupView.isHidden = false
        self.popUpTransView.isHidden = false
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        let messageSuccess = Validation()
        if messageSuccess == "" {
            if CheckInternet.Connection(){
               sendMessageData()
            }else{
                Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
            }
        }
        else
        {
            Alert.showBasic(titte: "Alert", massage: messageSuccess, vc: self)
        }
    }
    
    
    
    // MARK: - Validation
    func Validation() -> String {
        var successMessage = ""
        if self.userLabel.text?.count == 0
        {
            successMessage = "Please Enter User"
            return successMessage
        }
        if self.messageSubjectTF.text?.count == 0
        {
            successMessage = "Please Enter Message Subject"
            return successMessage
        }
        if self.messageTextView.text?.count == 0
        {
            successMessage = "Please Enter Message Details"
            return successMessage
        }
        return successMessage
    }
    
    
    // MARK: - Network
    
    func getDataCustomerData(){
        let url = URL.init(string: BaseUrl + "/customerList")
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST"
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let newTodo: [String: Any] = ["user_id":USERID,"user_type": USERTYPE]
        request.headers = headers
        let jsonTodo: Data
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
            request.httpBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error  in
            if error == nil
            {
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
                  //  print("data \(jsonData)")
                    DispatchQueue.main.async {
                        
                        let httpResponse = response as? HTTPURLResponse
                        if httpResponse?.statusCode == 200
                        {
                            self.customersData = jsonData["customers_list"] as! [NSDictionary]
                            self.customerBoolArray.removeAll()
                            for item in self.customersData
                            {
                                self.customerBoolArray.append(false)
                            }
                            self.SendMessageTableView.reloadData()
                        }else if httpResponse?.statusCode == 400
                        {
                            Alert.showBasic(titte: "Alert", massage:"Error 400", vc: self)
                        }
                        else
                        {
                            //   let message = jsonData["message"] as? NSString
                            Alert.showBasic(titte: "Alert", massage:"Try Again!", vc: self)
                        }
                    }
                }
                catch{
                }
            }else{
            }
        }
        dataTask.resume()
    }
    
    
    
    func sendMessageData(){
        var userId = String()
        var i = 0
        for item in self.customerBoolArray
        {
            if item {
                if userId.count == 0
                {
                    let userItem = self.customersData[i]
                    userId = userItem["customer_id"] as! String
                }
                else
                {
                    let userItem = self.customersData[i]
                  let itemName = userItem["customer_id"] as! String
                    userId = userId + " , " + itemName
                }
                       //self.customerBoolArray[indexPath.row] = false
                   }else{
                      // self.customerBoolArray[indexPath.row] = true
                   }
            i = i + 1
        }
        let url = URL.init(string:"http://ayersfood.com/erpapi/api/insertimessage")
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST"
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let newTodo: [String: Any] = ["user_id" : USERID,
                                      "message_receiver":userId,
                                      "message_subject": self.messageSubjectTF.text!,
                                      "message_detail": self.messageTextView.text!]
        request.headers = headers
        
        let jsonTodo: Data
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
            request.httpBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error  in
            if error == nil
            {
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
                    //  print("data \(jsonData)")
                    DispatchQueue.main.async {
                        
                        let httpResponse = response as? HTTPURLResponse
                        if httpResponse?.statusCode == 200
                        {
                            let message = jsonData["mesage"] as? NSString
                            Alert.showBasic(titte: "Success", massage:  message! as String , vc: self)
                        }else if httpResponse?.statusCode == 400
                        {
                            Alert.showBasic(titte: "Alert", massage:"Error 400", vc: self)
                        }
                        else
                        {
                            //   let message = jsonData["message"] as? NSString
                            Alert.showBasic(titte: "Alert", massage:"Try Again!", vc: self)
                        }
                    }
                }
                catch{
                    
                }
            }else{
                
            }
        }
        dataTask.resume()
        
    }
    
    
}
