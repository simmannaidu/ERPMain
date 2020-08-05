//
//  RecentInvoiceViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/24/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class RecentInvoiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var invoiceNumberLabel: UILabel!
    @IBOutlet weak var assignDeleveryDateButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var invoiceButton: UIButton!
    @IBOutlet weak var minInvoiceButton: UIButton!
    @IBOutlet weak var posInvoiceButton: UIButton!
    @IBOutlet weak var updateButtonVIew: UIView!
    @IBOutlet weak var deleteButtonView: UIView!
    
}

class RecentInvoiceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
var dataForTableView = [NSDictionary]()
    var selectedItem = NSDictionary()
    @IBOutlet weak var recentInvoiceTableview: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var popUpTransView: UIView!
    
    @IBOutlet weak var assignDeliveryPopUpView: UIView!
    
    @IBOutlet       weak var deliveryDayTF: UITextField!
    @IBOutlet weak var deliveryDayView: UIView!
    
    let deliveryDayArray = ["Monday","Tuesday","Wednesday","Thursday","May Vary"]
    let deliveryDayIdArray = ["1","2","3","4","5","6"]
    var selectProyarity: String?
    var selectProyarityid: String?
    var pickerView = UIPickerView()
    var currentTextField = UITextField()
    var deliveryDayId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDataFromServer()
        self.recentInvoiceTableview.delegate = self
        self.recentInvoiceTableview.dataSource = self
        self.transView.isHidden = true
        self.popUpTransView.isHidden = true
    self.assignDeliveryPopUpView.isHidden = true
        self.recentInvoiceTableview.tableFooterView =  UIView(frame: .zero)
        
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideSlideMenu))
        mytapGestureRecognizer.numberOfTapsRequired = 1
self.popUpTransView?.addGestureRecognizer(mytapGestureRecognizer)
        
self.deliveryDayView.layer.borderWidth = 1
self.deliveryDayView.layer.borderColor = UIColor.customBlue
self.deliveryDayView.layer.cornerRadius = 8
        
        self.deliveryDayTF.delegate = self
        dismissPickerView()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == self.deliveryDayTF{
            currentTextField.inputView = pickerView
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CheckInternet.Connection(){
        self.getDataFromServer()
        }else{
            Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
        }
    }

    @objc func hideSlideMenu()
       {
             self.popUpTransView.isHidden = true
               self.assignDeliveryPopUpView.isHidden = true
           
       }
    
    
    
    // MARK: - PickerView
      
      
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          if currentTextField == self.deliveryDayTF{
              return self.deliveryDayArray.count
          }
        else{
            return 0
        }
         
      }
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          if currentTextField == self.deliveryDayTF{
              self.selectProyarity = self.deliveryDayArray[row]
              self.selectProyarityid = self.deliveryDayIdArray[row]
              return self.deliveryDayArray[row]
          }
        else{
            return ""
        }
          
      }
      
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          if currentTextField == self.deliveryDayTF{
              self.selectProyarity = self.deliveryDayArray[row]
               self.selectProyarityid = self.deliveryDayIdArray[row]
          }
      }
      
      
      
      
      func dismissPickerView()
      {
          
          let toolBar = UIToolbar()
          toolBar.sizeToFit()
          
          let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
          let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
          
          toolBar.setItems([flexibleSpace, doneButton], animated: false)
          toolBar.isUserInteractionEnabled = true
          
          self.deliveryDayTF.inputAccessoryView = toolBar
          
      }
      
      @objc func doneButtonAction()
      {
          if currentTextField == self.deliveryDayTF{
              self.deliveryDayTF.text =  self.selectProyarity
             self.deliveryDayId = self.selectProyarityid
               self.view.endEditing(true)
          }
      }
    
    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "RecentInvoiceTableViewCellId", for: indexPath) as! RecentInvoiceTableViewCell
        
        /*{
            "customer_id" = ZPYJ2DYWK43MDIF;
            "customer_name" = MasonQ;
            date = "2019-10-21";
            "delivery_date" = "2019-10-21 17:11:26";
            "delivery_day" = 0;
            "final_date" = "21 - OCT - 2019";
            "incoice_created_by" = 1;
            "incoice_created_user_type" = 1;
            invoice = 1081;
            invoiceType = 1;
            invoiceTypeFor = 1;
            "invoice_create_date" = "2019-11-03 19:45:07";
            "invoice_details" = "";
            "invoice_discount" = 0;
            "invoice_id" = 2412341673;
            "invoice_paid_amount" = "0.00";
            "prevous_due" = "9851.88";
            "prevous_due_invoice" = "33.00";
            "shipping_cost" = 3;
            sl = 11;
            status = 1;
            "total_amount" = 33;
            "total_discount" = 0;
            "total_tax" = 0;
        }*/
        
        let item = self.dataForTableView[indexPath.row]
        
        cell.invoiceNumberLabel.text = "Invoice No : \(item["invoice_id"] ?? "")"
        cell.dateLabel.text = "Date : \(item["date"] ?? "")"
        cell.totalAmountLabel.text = "Total Amount : $\(item["total_amount"] ?? "")"
        cell.invoiceButton.layer.cornerRadius = 4
        cell.minInvoiceButton.layer.cornerRadius = 4
        cell.posInvoiceButton.layer.cornerRadius = 4
        cell.updateButtonVIew.layer.cornerRadius = 4
        cell.deleteButtonView.layer.cornerRadius = 4
        cell.assignDeleveryDateButton.layer.cornerRadius = 4
        cell.assignDeleveryDateButton.layer.borderColor = UIColor.lightGray
        cell.assignDeleveryDateButton.layer.borderWidth = 1
        
        cell.invoiceButton.tag = indexPath.row
        cell.assignDeleveryDateButton.tag = indexPath.row
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    @IBAction func showInVoiceAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForWebViewControllerId") as? ForWebViewController
        let item = self.dataForTableView[sender.tag]
//
//               cell.invoiceNumberLabel.text = "Invoice No : \(item["invoice_id"] ?? "")"
        let id = item["invoice_id"] as! String
        vc?.forViewUrl = "http://ayersfood.com/erp_beta/Cinvoice/quotations_webview/" + id
             self.navigationController?.pushViewController(vc!, animated: true)
    }
   
    //invoiceList/1/1/0
    //MARK:- NETWORK
    func getDataFromServer(pageNumber : String )
    {
        let url : URL = URL(string: BaseUrl + "/invoiceList/1/1/" + pageNumber)!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
       // let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
        let headerData = ["user_id":"1","user_type":"1"]
                AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    let response1 = response.response
                    if response1?.statusCode == 200
                    {
                         do{
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                             var items = NSDictionary()
                            items = jsonRespone as! NSDictionary
                            self.dataForTableView = items["invoices_list"] as! [NSDictionary]
                           
                            
                            self.recentInvoiceTableview.reloadData()
                           // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                }
    }
    func getDataFromServer()
    {
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/invoiceList")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
    let headerData = ["user_id":USERTYPE,"user_type":USERID]
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
                            self.dataForTableView = items["invoices_list"] as! [NSDictionary]
                           if self.dataForTableView.count == 0
                           {
                               Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                           }
                            
                            self.recentInvoiceTableview.reloadData()
                           // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                }
        }
    }
    
    
    func assignDeliveryDateData(item : NSDictionary)
    {
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let url : URL = URL(string: BaseUrl + "/assign_delivery_date")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        /*{
            "invoice_id":"7127995769",
            "delivery_day":"monday",
            "user_type":"1"
        }*/
        let parameters = ["invoice_id" : item["invoice_id"] ?? "",
                          "delivery_day" : self.deliveryDayTF.text ?? "",
            "user_type" : "1"]
                AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    let response1 = response.response
                    DispatchQueue.main.async {
                    self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                        self.popUpTransView.isHidden = true
                           self.assignDeliveryPopUpView.isHidden = true
                    if response1?.statusCode == 200
                    {
                         do{
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                            self.getDataFromServer()
                           // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                }
        }
    }
    
    
    
    
    // MARK: - ButtonActions
    
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func assignDeliveryPopUpSubmitBtnAction(_ sender: UIButton) {
        if self.deliveryDayTF.text?.count != 0
        {
            self.assignDeliveryDateData(item: self.selectedItem)
            self.deliveryDayTF.text = ""
        }
        else
        {
        Alert.showBasic(titte: "Alert", massage: "Please select date", vc: self)
        }
    }
    
    @IBAction func popUpCloseBtnAction(_ sender: UIButton) {
        self.popUpTransView.isHidden = true
    self.assignDeliveryPopUpView.isHidden = true
         self.deliveryDayTF.text = ""
    }
    
    
    @IBAction func assignDeliveryDayPopUpBtnAction(_ sender: UIButton) {
        self.selectedItem = self.dataForTableView[sender.tag]
        
        self.popUpTransView.isHidden = false
           self.assignDeliveryPopUpView.isHidden = false
    }
    
    
  
    
    //    func assignDeliveryDate()
//    {
//        let url : URL = URL(string: BaseUrl + "/assign_delivery_date")!
//        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
//        }
//
//        //AF.request(url , method: .post , parameters: nil,encoder: JSONEncoding.default )
//    }
   /*https://ayersfood.com/erpapi/api/assign_delivery_date
   {
       "invoice_id":"7127995769",
       "delivery_day":"monday",
       "user_type":"1"
   }*/
}
