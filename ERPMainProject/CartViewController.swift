//
//  CartViewController.swift
//  POS
//
//  Created by Kardas Veeresham on 12/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var boxLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
}

class CartViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{

   
    @IBOutlet weak var productTableview: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var deliveryChargeLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var customerNameView: UIView!
    @IBOutlet weak var customerNameTF: UITextField!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var dateMainView: UIView!


    var dataForTableView = [NSDictionary]()
     var customerListArray = NSMutableArray()
     var customerListIdArray = NSMutableArray()
    var positionValue = NSInteger()
     let datePicker = UIDatePicker()
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    var selectProyarity: String?
    var selectIdProyarity: String?
    var customer_id: String?

//    var grandTotalString = String()
//    var subTotalString = String()
//    var deliveryString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.productTableview.delegate = self
        self.productTableview.dataSource = self
        self.transView.isHidden = true
        self.customerNameTF.delegate = self
        self.dataForTableView = getDataFromCoreData()
        
        Design()
        
//        self.subTotalLabel.text = self.subTotalString
//        self.deliveryChargeLabel.text = self.deliveryString
//         self.grandTotalLabel.text = self.grandTotalString
        
        hidekeyboardWhenTappedArround()
        showDatePicker()
        getDataForManageCustomer()
        dismissPickerView()
    }
    
    
    
    
    func Design(){
        self.customerNameView.layer.borderWidth = 1
        self.customerNameView.layer.borderColor = UIColor.customBlue
        self.dateView.layer.borderWidth = 1
        self.dateView.layer.borderColor = UIColor.customBlue
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == customerNameTF{
//            self.pickerView.selectRow(0, inComponent: 0, animated: false)
//            self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 0)
            currentTextField.inputView = pickerView
        }
        
    }
    
    
    
    // MARK: - PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == customerNameTF{
            return customerListArray.count
        }
        else{
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == customerNameTF{
            self.selectProyarity = customerListArray[row] as? String
            self.selectIdProyarity = customerListIdArray[row] as? String
            return customerListArray[row] as? String
        }
        else{
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == customerNameTF{
            self.selectProyarity = customerListArray[row] as? String
            self.selectIdProyarity = customerListIdArray[row] as? String
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
        
        self.customerNameTF.inputAccessoryView = toolBar
       
        
    }
    
    @objc func doneButtonAction()
    {
            self.customerNameTF.text =  self.selectProyarity
            self.customer_id  = self.selectIdProyarity
            self.view.endEditing(true)
    }
    
    
    
    // MARK: - DatePicker
    func showDatePicker(){
        
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        self.dateTF.inputAccessoryView = toolbar
        self.dateTF.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.dateTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ProductsTableViewCellId", for: indexPath) as! ProductsTableViewCell
        
        let item = self.dataForTableView[indexPath.row]
        

        cell.productImage.imageFromServerURL(image: item["image"] as! String)
        cell.productNameLabel.text = "\(item["product_name"] ?? "")"
        cell.unitLabel.text = "\(item["product_quantity"] ?? 0)" + " X " + "$ \(item["product_rate"] ?? 0)"
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

     // MARK: - ButtonActiones
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  


    @IBAction func placeOrderBtnAction(_ sender: UIButton) {
        
        let messageSuccess = Validation()
        if messageSuccess == "" {
            placeOrder()
        }
        else
        {
            Alert.showBasic(titte: "Alert", massage: messageSuccess, vc: self)
        }
    
    }
    
    
    
    func placeOrder(){
    
        
        
 
         var product_id = String()
         var available_quantity = String()
         var product_quantity = String()
         var product_rate = String()
         var discount = String()
         var total_price = String()
         var tax = String()
         var discount_amount = String()
         self.dataForTableView = getDataFromCoreData()
         //  print("\(dataInTableView)")
         var totalPrice : Float = 0.0
         for item in dataForTableView
         {
         var singleItem : Float = 0.0
         let priceOfItem = Float(item["total_price"] as! String)!
         let quantityOfItem = Float(item["product_quantity"] as! String)!
         singleItem = priceOfItem * quantityOfItem
         totalPrice = totalPrice + singleItem
         if product_id.count == 0 {
         product_id = item["product_id"] as! String
         available_quantity = item["available_quantity"] as! String
         product_quantity = item["product_quantity"] as! String
         product_rate = item["product_rate"] as! String
         discount = "0"
         total_price = "\(singleItem)"
         tax = "0"
         discount_amount = "0"
         }
         else
         {
         product_id = product_id + ","  + (item["product_id"] as! String)
         available_quantity = available_quantity + ","  + (item["available_quantity"] as! String)
         product_quantity = product_quantity + ","  + (item["product_quantity"] as! String)
         product_rate = product_rate + ","  + (item["product_rate"] as! String)
         discount = discount + "," + "0"
         total_price = total_price + "," + "\(singleItem)"
         tax = tax + ","  + "0"
         discount_amount = discount_amount + "," + "0"
         }
         }
         var forDeliveryCharges : Float = 0.0
         if totalPrice < 100
         {
         forDeliveryCharges = totalPrice / 10.0
         //self.deliveryChargesLabel.text = "Delivery Charges : \(forDeliveryCharges)"
         }
         else
         {
         forDeliveryCharges = 0.0
         // self.deliveryChargesLabel.text = "Delivery Charges : 0.0"
         }
         //  self.grandTotalLabel.text = "Grand Total : \(totalPrice + forDeliveryCharges)"
         
         let url = URL.init(string: BaseUrl + "/checkout")
         //        let headerData = ["product_id":product_id,"available_quantity":available_quantity,"product_quantity":product_quantity,"product_rate":product_rate,"discount":discount,"total_price":total_price,"tax":tax,"discount_amount":discount_amount,"total_tax":"0","invoice_discount":"0","total_discount":"0","shipping_cost":"\(forDeliveryCharges)","grand_total_price":"\(totalPrice)","previous":"","n_total":"\(totalPrice + forDeliveryCharges)","paid_amount":"0","due_amount":"0","user_type":USERTYPE,"customer_id":USERID,"invoice_date":""]
         //        AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
         //            print(response.request as Any)  // original URL request
         //            print(response.response as Any)// URL response
         //            let response1 = response.response
         //            if response1?.statusCode == 200
         //            {
         //                do{
         //                    let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
         //                    print(jsonRespone)
         //                    let item = jsonRespone as! NSDictionary
         //                } catch let parsingError {
         //                    print("Error", parsingError)
         //                }
         //                // let dataFromServer =
         //            }
         //        }
         
         
         var request = URLRequest.init(url: url!)
         request.httpMethod = "POST"
         let newTodo: [String: Any] = ["product_id":product_id,"available_quantity":available_quantity,"product_quantity":product_quantity,"product_rate":product_rate,"discount":discount,"total_price":total_price,"tax":tax,"discount_amount":discount_amount,"total_tax":"0.00","invoice_discount":"0","total_discount":"0.00","shipping_cost":"\(forDeliveryCharges)","grand_total_price":"\(totalPrice)","previous":"0","n_total":"\(totalPrice + forDeliveryCharges)","paid_amount":"0","due_amount":"0","user_type" : USERTYPE,"customer_id": self.customer_id ?? "","invoice_date" : "2020-01-3","user_id" : USERID ]
         
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
         print("data \(jsonData)")
         DispatchQueue.main.async {
         self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
         let httpResponse = response as? HTTPURLResponse
         if httpResponse?.statusCode == 200
         {
         let vc = UIStoryboard.init(name: "main_ipad", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecentInvoiceViewControllerId") as? RecentInvoiceViewController
         self.navigationController?.pushViewController(vc!, animated: true)
         
         }else if httpResponse?.statusCode == 400 {
         let message = jsonData["errorMessage"] as? String
         Alert.showBasic(titte: "Alert", massage: message ?? "Your credit limit of amount has exceeded. Please contact Ayers Rock Trading Office" , vc: self)
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
    
    
    // MARK: - Validation
    func Validation() -> String {
        var successMessage = ""
        if customerNameTF.text?.count == 0
        {
            successMessage = "Please Enter Customer Name"
            return successMessage
        }
        if dateTF.text?.count == 0
        {
            successMessage = "Please Enter Date"
            return successMessage
        }
        return successMessage
    }
    
    // MARK: - Network
    
    func getDataForManageCustomer()
    {
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let parameters = ["userStatus":"","user_type":USERTYPE]
         //http://lanciusit.com/demo/erpapi/api/customerList
         let url : URL = URL(string:BaseUrl + "/customerList")!
        let headerData = ["user_id":USERID,"user_type":USERTYPE]
                 AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
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
                             //self.tatalAmountLabel.text = "\(items["subtotal"] ?? "")"
                            
                          //   self.dataForTableView = items["customers_list"] as! [NSDictionary]
                             
                            let listArray = items["customers_list"] as! [NSDictionary]
                            
                            for element :  NSDictionary in listArray {
                            let item  = element["customer_name"]
                            let itemId = element["customer_id"]
                            self.customerListArray.add(item as Any)
                            self.customerListIdArray.add(itemId as Any)
                            }
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
  

    @IBAction func addCustomerAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "AddCustomerViewControllerId") as? AddCustomerViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
 
