//
//  NewQuationsViewController.swift
//  DummyERP
//
//  Created by Kardas Veeresham on 1/6/20.
//  Copyright © 2020 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class NewQuationsTableViewCell: UITableViewCell{

    @IBOutlet weak var editBTAction: UIButton!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var itemInformationLabel: UILabel!
    @IBOutlet weak var unitLabel : UILabel!
    @IBOutlet weak var QntyLabel : UILabel!
    @IBOutlet weak var DiscountLabel : UILabel!
    @IBOutlet weak var avQuntyLabel : UILabel!
    @IBOutlet weak var rateLabel : UILabel!
     @IBOutlet weak var totalLabel : UILabel!
    @IBOutlet weak var deleteButton: UIButton!
}

class NewQuationsTableViewCellTwo: UITableViewCell{
    
    @IBOutlet weak var invoiceDetailsView: UIView!
    @IBOutlet weak var invoiceDetailsTextView: UITextView!
    @IBOutlet weak var invoiceDiscountView: UIView!
    @IBOutlet weak var invoiceDiscountTF: UITextField!
    
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalDiscountLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var netTotalLabel: UILabel!
    
    @IBOutlet weak var previusAmountLabel: UILabel!
}


class NewQuationsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource ,UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var newCustomerBt: UIButton!
    @IBOutlet weak var customerNameView: UIView!
    @IBOutlet weak var customerNameTF: UITextField!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateTf: UITextField!
    var isEditTheCell = Bool()
    
    @IBOutlet weak var newQuationTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var popUpTransView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var selectCategoryView: UIView!
    @IBOutlet weak var selectCategoryTF: UITextField!
    @IBOutlet weak var itemInformationView: UIView!
    @IBOutlet weak var itemInformAtionTF: UITextField!
    @IBOutlet weak var selectQuantityView: UIView!
    @IBOutlet weak var quantityTF: UITextField!
    
    @IBOutlet weak var discountOnItemTF: UITextField!
    @IBOutlet weak var totalPriceOfItemLabel: UITextField!
    @IBOutlet weak var rateOfItemLabel: UITextField!
    var dataToTableViewArray = [NSDictionary]()
    var invoiceDiscountValue = String()
    var categoryListArray = NSMutableArray()
    var categoryListIdArray = NSMutableArray()
    var itemInformationListArray = NSMutableArray()
    var itemInformationListIdArray = NSMutableArray()
    var customerListArray = NSMutableArray()
    var customerListIdArray = NSMutableArray()
    let datePicker = UIDatePicker()
     //let datePicker = UIDatePicker()
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    var selectProyarity: String?
    var selectIdProyarity: NSDictionary?
    var customerDic: NSDictionary?
    var catgeryDic = NSDictionary()
    var productDic: NSDictionary?
    
    var forDicountString = String()
    var numberOfEditingTheCell = NSInteger()
    var selectedCatageryString : String?
    var selectedProductString : String?
    var selectedQuantityString : String?
    
    var customer_balance = Float()
    var editableDic = NSDictionary()
    var catId = String()
     var dataForCatagery = [NSDictionary]()
     var dataForProducts = [NSDictionary]()
     var dataForCustomers = [NSDictionary]()
    
    var dataForCatageryName =  [NSString]()
     var dataForProductsName = [NSString]()
    var dataForCustomersName = [NSString]()
    
    var invoiceDiscountValueForText = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedProductString  = ""
        self.selectedQuantityString = ""
        self.selectedCatageryString = ""
        self.isEditTheCell = false
        self.customer_balance = 0.0
        self.customerNameTF.delegate = self
        self.selectCategoryTF.delegate = self
        self.itemInformAtionTF.delegate = self
        
        self.newQuationTableView.delegate = self
        self.newQuationTableView.dataSource = self
        self.transView.isHidden = true
        self.popUpTransView.isHidden = true
        self.newCustomerBt.layer.cornerRadius = 10
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getDataForManageCustomer()
            //   getDataCustomerData()
               hidekeyboardWhenTappedArround()
               showDatePicker()
               dismissPickerView()
               getDataForCategoryList()
               Design()
        if #available(iOS 13, *) {
                  self.customerNameTF.overrideUserInterfaceStyle = .light
                  self.dateTf.overrideUserInterfaceStyle = .light
                  self.selectCategoryTF.overrideUserInterfaceStyle = .light
            self.itemInformAtionTF.overrideUserInterfaceStyle = .light
            self.discountOnItemTF.overrideUserInterfaceStyle = .light
            self.quantityTF.overrideUserInterfaceStyle = .light
            // self.quantityTF.overrideUserInterfaceStyle = .light
            self.totalPriceOfItemLabel.overrideUserInterfaceStyle = .light
           // self.disco.overrideUserInterfaceStyle = .light
                  // use UICollectionViewCompositionalLayout
              } else {
                  // show sad face emoji
              }
        
    }
    
    func Design()
    {
        self.popUpView.layer.cornerRadius = 10
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        invoiceDiscountValueForText = "0"
        if currentTextField == customerNameTF{
            //            self.pickerView.selectRow(0, inComponent: 0, animated: false)
            //            self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 0)
            currentTextField.inputView = pickerView
           
        }else if currentTextField == selectCategoryTF{
            //            self.pickerView.selectRow(0, inComponent: 0, animated: false)
            //            self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 0)
            currentTextField.inputView = pickerView
        }else if currentTextField == itemInformAtionTF{
            guard let cateId = self.catgeryDic["category_id"] else
            {
             Alert.showBasic(titte: "Sorry", massage: "Please select category", vc: self)
                return
            }
            

           // let catId = self.catgeryDic["category_id"] as! String
            if (cateId as AnyObject).count != 0
                //self.catgery_id.count != 0
            {
                self.getProductsDataFromServer()
              currentTextField.inputView = pickerView
            }
            else
            {

            }
        
        }
         pickerView.reloadAllComponents()
    }
    
    
    // MARK: - PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == customerNameTF{
            return customerListArray.count
        }
        else if currentTextField == selectCategoryTF{
            return categoryListArray.count
        }
        else if currentTextField == itemInformAtionTF{
            return itemInformationListArray.count
        }else {
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == customerNameTF{
            self.selectProyarity = customerListArray[row] as? String
            self.selectIdProyarity = customerListIdArray[row] as? NSDictionary
            customer_balance = Float(self.selectIdProyarity?["customer_balance"] as! String)!
            return customerListArray[row] as? String
        }
            else  if currentTextField == selectCategoryTF{
            self.selectProyarity = self.categoryListArray[row] as? String
            self.selectIdProyarity = self.categoryListIdArray[row] as? NSDictionary
                       return self.categoryListArray[row] as? String
                   }
        else{
            self.selectProyarity = self.itemInformationListArray[row] as? String
            self.selectIdProyarity = self.itemInformationListIdArray[row] as? NSDictionary
            return self.itemInformationListArray[row] as? String
                   
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == customerNameTF{
            self.selectProyarity = customerListArray[row] as? String
            self.selectIdProyarity = customerListIdArray[row] as? NSDictionary
        }
         if currentTextField == itemInformAtionTF{
            self.selectProyarity = self.itemInformationListArray[row] as? String
            self.selectIdProyarity = self.itemInformationListIdArray[row] as? NSDictionary
        }
        if currentTextField == selectCategoryTF{
            self.selectProyarity = self.categoryListArray[row] as? String
            self.selectIdProyarity = self.categoryListIdArray[row] as? NSDictionary
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
        self.selectCategoryTF.inputAccessoryView = toolBar
        self.itemInformAtionTF.inputAccessoryView = toolBar
        
    }
    
    @objc func doneButtonAction()
    {
        if currentTextField == self.customerNameTF
        {
        self.customerNameTF.text =  self.selectProyarity
        self.customerDic  = self.selectIdProyarity
            //customer_balance
            customer_balance = Float(self.selectIdProyarity?["customer_balance"] as! String)!
            self.newQuationTableView.reloadData()
        }
        if currentTextField == selectCategoryTF
        {
            self.selectCategoryTF.text = self.selectProyarity
            self.catgeryDic = self.selectIdProyarity!
        }
        if currentTextField == itemInformAtionTF
        {
            self.itemInformAtionTF.text = self.selectProyarity
            self.productDic = self.selectIdProyarity
            self.setValuesForLabelsInPopUp()
           // self.rateOfItemLabel.text = "$\(self.productDic?["price"] ?? "")"
        }
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
        
        self.dateTf.inputAccessoryView = toolbar
        self.dateTf.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.dateTf.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    // MARK: - Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataToTableViewArray.count == 0
        {
            return 0
        }
        else
        {
        return dataToTableViewArray.count + 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == dataToTableViewArray.count
        {
            let cell = tableView .dequeueReusableCell(withIdentifier: "NewQuationsTableViewCellTwoId", for: indexPath) as! NewQuationsTableViewCellTwo
            
            cell.invoiceDetailsView.layer.borderWidth = 1
                       cell.invoiceDetailsView.layer.borderColor = UIColor.lightGray
                       cell.invoiceDetailsView.layer.cornerRadius = 4
                       cell.invoiceDiscountView.layer.borderWidth = 1
                       cell.invoiceDiscountView.layer.borderColor = UIColor.lightGray
                       cell.invoiceDiscountView.layer.cornerRadius = 4
            
            cell.invoiceDiscountTF.text = self.invoiceDiscountValue
            var finalPrice = 0.0
            var discountValue = 0.0
            for item in self.dataToTableViewArray
            {
            let itemTotalPrice = (Double(item["price"] as! String)!) * (Double(item["Qnty"] as! String)!)
                let discountPer = Double(item["discount"] as! String)!
                var discount_amountOfItem  : Double = 0.00
                if discountPer != 0
                {
                    discount_amountOfItem = itemTotalPrice * Double(discountPer / 100)
                }
                
                finalPrice = finalPrice + itemTotalPrice - discount_amountOfItem
                discountValue = discount_amountOfItem + discountValue
            }
            cell.grandTotalLabel.text = String(format : "$%.2f" , finalPrice)
            cell.totalDiscountLabel.text = String(format : "$%.2f" , discountValue)

            var supplierCharge = 0.0
            if finalPrice < 100
            {
                supplierCharge = finalPrice / 10
                
            }
            else{
                supplierCharge = 0.0
                
            }
            cell.previusAmountLabel.text = String(format : "$%.2f",customer_balance)
            cell.shippingCostLabel.text = String(format : "$%.2f", supplierCharge)
            
            var invoiceDiscountIntValue = 0
            if self.invoiceDiscountValue != "0" && self.invoiceDiscountValue != ""
            {
                //cell.totalDiscountLabel.text =
                invoiceDiscountIntValue = NSInteger(self.invoiceDiscountValue) ?? 1
               //let  invoiceDisValue = finalPrice * Double(invoiceDiscountIntValue / 100)

                cell.netTotalLabel.text = String(format : "$%.2f",supplierCharge + finalPrice - finalPrice * Double(invoiceDiscountIntValue / 100) - Double( customer_balance))
            }
            else
            {
               cell.netTotalLabel.text = String(format : "$%.2f",finalPrice + supplierCharge - Double( customer_balance))
            }
            
           // let invoiceDiscount : NSInteger = NSInteger(cell.invoiceDiscountTF.text!)!
            return cell
        }
        else
        {
        let cell = tableView .dequeueReusableCell(withIdentifier: "NewQuationsTableViewCellId", for: indexPath) as! NewQuationsTableViewCell
        let item = dataToTableViewArray[indexPath.row]
            /* let item = ["category_name":self.catgeryDic["category_name"] , "category_id":self.catgeryDic["category_id"] , "product_name":self.catgeryDic["product_name"] , "Qnty":self.quantityTF.text , "unit":self.productDic["unit"] ,"price":self.productDic["price"] , "discount" : "0.00" , "product_id":self.productDic["product_id"]]*/
            
            cell.categoryLabel.text = "Category Name : \(item["category_name"] ?? "")"
                //item["category_name"] as! String
        cell.itemInformationLabel.text = "Item Information : \(item["product_name"] ?? "")"
            //item["product_name"] as! String
            cell.avQuntyLabel.text = "AvQunty : \(item["avQunty"] ?? "")"
                //item["avQunty"] ?? "" as! String
        cell.QntyLabel.text = "Qunty : \(item["Qnty"] ?? "")"
            //item["Qnty"] as! String
        cell.DiscountLabel.text = "Discount : \(item["discount"] ?? "")%"
            //item["discount"] as! String
        cell.unitLabel.text = "Unit : \(item["unit"]  ?? "")"
            //item["unit"] as! String
        cell.rateLabel.text = "Rate : $\(item["price"] ?? "")"
            //item["price"] as! String
        let itemTotalPrice = (Float(item["price"] as! String)!) * (Float(item["Qnty"] as! String)!)
            
        cell.totalLabel.text = String(format: "Total : $%.2f", itemTotalPrice)
            cell.deleteButton.tag = indexPath.row
            cell.editBTAction.tag = indexPath.row
            //NSString("%.2f",itemTotalPrice)
            //(item["product_name"] as! String)
            cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
            
        return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == self.dataToTableViewArray.count
        {
            return 440
        }
        else
        {
        return 158
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func toMakeEmptyForPopUpView()
    {
        self.selectCategoryTF.text = ""
        self.itemInformAtionTF.text = ""
        self.quantityTF.text = ""
        self.totalPriceOfItemLabel.text = ""
        self.rateOfItemLabel.text = ""
        self.discountOnItemTF.text = ""
        self.catgeryDic = NSDictionary()
               self.productDic = NSDictionary()
               self.popUpTransView.isHidden = true
               self.popUpView.isHidden = true
    }
    
   // MARK: - ButtonActiones
    @IBAction func popUpCloseBtnAction(_ sender: UIButton) {
        isEditTheCell = false
        toMakeEmptyForPopUpView()
        
    }
    @IBAction func quantityTFAction(_ sender: UITextField) {
    }
    @IBAction func discountTfAction(_ sender: UITextField) {
    }
    @IBAction func invoiceDiscountTFAction(_ sender: UITextField) {
    }
    @IBAction func popUpSubmitBtnAction(_ sender: UIButton) {
        /*6 elements
        ▿ 0 : 2 elements
          - key : status
          - value : 1
        ▿ 1 : 2 elements
          - key : id
          - value : 1
        ▿ 2 : 2 elements
          - key : category_name
          - value : FROZEN
        ▿ 3 : 2 elements
          - key : category_id
          - value : W15LDBOFCPYPMQ8
        ▿ 4 : 2 elements
          - key : sl
          - value : 1
        ▿ 5 : 2 elements
          - key : cat_image
          - value : https://ayersfood.com/erpapi/assets/category_image/1.jpg*/
        /*some : 20 elements
        ▿ 0 : 2 elements
          - key : status
          - value : 1
        ▿ 1 : 2 elements
          - key : tax
          - value : 0
        ▿ 2 : 2 elements
          - key : image
          - value : http://lanciusitsolutions.com/ayerserp/my-assets/image/product/685f1855386355f0c2e0c3b2021a2297.jpg
        ▿ 3 : 2 elements
          - key : product_details
          - value : SLICED COCONUT
        ▿ 4 : 2 elements
          - key : categoryName
          - value : FROZEN
        ▿ 5 : 2 elements
          - key : product_name
          - value : SLICED COCONUT
        ▿ 6 : 2 elements
          - key : supplier_price
          - value : 29.4
        ▿ 7 : 2 elements
          - key : actual_qty
          - value : 2566
        ▿ 8 : 2 elements
          - key : product_id
          - value : 89654
        ▿ 9 : 2 elements
          - key : productNew
          - value : 0
        ▿ 10 : 2 elements
          - key : supplier_name
          - value : AYERS
        ▿ 11 : 2 elements
          - key : serial_no
          - value : 8585858
        ▿ 12 : 2 elements
          - key : number_of_pieces
          - value : 12
        ▿ 13 : 2 elements
          - key : unit
          - value : 400g x 12
        ▿ 14 : 2 elements
          - key : price_per_pieces
          - value : 2.50
        ▿ 15 : 2 elements
          - key : supplier_id
          - value : M5HLOM3YVTDLN2JR6H4J
        ▿ 16 : 2 elements
          - key : product_model
          - value : ARTPL741585
        ▿ 17 : 2 elements
          - key : price
          - value : 30
        ▿ 18 : 2 elements
          - key : category_id
          - value : W15LDBOFCPYPMQ8
        ▿ 19 : 2 elements
          - key : sl
          - value : 2*/
        let message = forCheckingToSelectOrNot()
               if message.count == 0
               {
                if self.quantityTF.text!.count != 0 && self.quantityTF.text != "0"
                {
                    let item : NSDictionary = ["category_name":self.catgeryDic["category_name"] ?? "" , "category_id":self.catgeryDic["category_id"] ?? "" , "product_name":self.productDic?["product_name"] ?? "" , "Qnty":self.quantityTF.text ?? "" , "unit":self.productDic?["unit"] ?? "" ,"price":self.productDic?["price"] ?? "" , "discount" : self.discountOnItemTF.text ?? "0" , "product_id":self.productDic?["product_id"] ?? "","avQunty":self.productDic?["actual_qty"] ?? ""]
                     if isEditTheCell != true
                     {
                     self.dataToTableViewArray.append(item as NSDictionary)
                     }
                     else
                     {
                         self.dataToTableViewArray.remove(at: self.numberOfEditingTheCell)
                         self.dataToTableViewArray.append(item)
                         //replaceSubrange(self.numberOfEditingTheCell, with: item)
                         isEditTheCell = false
                     }
                     
                    // self.dataToTableViewArray.append(item as NSDictionary)
                     self.newQuationTableView.reloadData()
                     toMakeEmptyForPopUpView()
                }
                else
                {
                    Alert.showBasic(titte: "Sorry", massage: "Please select the quantity", vc: self)
                }
               }
               else
                   {
                       //self.quantityTF.text = ""
                     Alert.showBasic(titte: "Sorry", massage: message, vc: self)
               }
    }
    @IBAction func newCustomerBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "AddCustomerViewControllerId") as? AddCustomerViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func editActionInCell(_ sender: UIButton) {
        self.isEditTheCell = true
        self.editableDic = self.dataToTableViewArray[sender.tag]
        self.selectCategoryTF.isUserInteractionEnabled = false
        self.itemInformAtionTF.isUserInteractionEnabled = false
        self.numberOfEditingTheCell = sender.tag
        self.popUpView.isHidden = false
        self.popUpTransView.isHidden = false
    }
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cellDeleteBtnAction(_ sender: UIButton) {
        self.dataToTableViewArray.remove(at: sender.tag)
        self.newQuationTableView.reloadData()
    }
    
    @IBAction func addNewItemBtnAction(_ sender: UIButton) {
        
        self.catgeryDic = NSDictionary()
        self.productDic = NSDictionary()
//        self.selectCategoryTF.isUserInteractionEnabled = true
//        self.itemInformAtionTF.isUserInteractionEnabled = true
        self.popUpTransView.isHidden = false
        self.popUpView.isHidden = false
    }
    @IBAction func submitBtnAction(_ sender: UIButton) {
                   guard let cateId = self.customerDic?["delihvery_day"] else
                                             {
                                              Alert.showBasic(titte: "Sorry", massage: "Please Select Customer", vc: self)
                                                 return
                                             }
                          if self.dateTf.text?.count != 0
                          {
                                  if self.dataToTableViewArray.count != 0
                                  {
                                      
                                          self.addQuotation()
                                  }
                                  else
                                  {
                                       Alert.showBasic(titte: "Sorry", massage: "Please select items.", vc: self)
                                  }
                          }
                          else
                          {
                            Alert.showBasic(titte: "Sorry", massage: "Please select date.", vc: self)
                          }
        
    }
    
    @IBAction func EditingOfQTY(_ sender: UITextField) {
        let message = forCheckingToSelectOrNot()
        if message.count == 0
        {

        }
        else
            {
                self.quantityTF.text = ""
              Alert.showBasic(titte: "Sorry", massage: message, vc: self)
        }
    }
    
    @IBAction func EditingDidBeginDiscountTFAct(_ sender: UITextField) {
       
        let message = forCheckingToSelectOrNot()
        if message.count == 0
        {
            
        }
        else
            {
                self.discountOnItemTF.text = ""
              Alert.showBasic(titte: "Sorry", massage: message, vc: self)
        }
    }
   
    @IBAction func quantityValueChange(_ sender: UITextField) {
        let message = forCheckingToSelectOrNot()
               if message.count == 0
               {
                 setValuesForLabelsInPopUp()
               }
               else
                   {
                       self.quantityTF.text = ""
                  //   Alert.showBasic(titte: "Sorry", massage: message, vc: self)
               }
       
    }
    @IBAction func discountPersentageTF(_ sender: UITextField) {
        let message = forCheckingToSelectOrNot()
        if message.count == 0
        {
          if self.quantityTF.text!.count != 0
          {
          if sender.text!.count < 3
                 {
                  self.forDicountString = sender.text!

                 }
                 else
                 {
                  self.discountOnItemTF.text = self.forDicountString
                 }
              
              setValuesForLabelsInPopUp()
          }
          else
          {
            self.discountOnItemTF.text = ""
              Alert.showBasic(titte: "Sorry", massage: "Please select Quantity", vc: self)
          }
        }
        else
            {
                self.discountOnItemTF.text = ""
              Alert.showBasic(titte: "Sorry", massage: message, vc: self)
        }
        
    }
    
    @IBAction func invoiceEditingChangeAction(_ sender: UITextField) {
        if sender.text!.count < 3
           {
            self.invoiceDiscountValue = sender.text!
            self.invoiceDiscountValue = sender.text!
           }
           else
           {
           // self.newQuationTableView.reloadData()
       // .tex//t = self.forDicountString
             
           }
       
        self.newQuationTableView.reloadData()
    }
    
    // MARK: - NETWORK
        func getDataForManageCustomer()
        {
          
            self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
           
             let url : URL = URL(string:BaseUrl + "/customerList")!
            let parameters = ["user_type":USERTYPE , "user_id" : USERID]
            let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
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
                                
                                /*{
                                    "assigned_sales_user_id" = VOVH4ITbhFfSzIp;
                                    "comapny_logo" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/3769ad749aa0e85ef75aeba552146190.png";
                                    "company_abn" = iiioio;
                                    "company_address" = jkjhkhjkhjk;
                                    "company_email" = "sudhakarnaytytyyak05@gmail.com";
                                    "company_mobile" = 555555555555;
                                    "company_name" = ttttttt;
                                    "company_telephone" = 444444444444;
                                    "create_date" = "2019-11-06 17:01:20";
                                    customerView = 0;
                                    "customer_address" = ", Subishi Plaza, Suite 101, Behind GEM Motors (Maruti Showroom), Kondapur, Hyderabad \U2013 500 084, India.";
                                    "customer_balance" = "-33.00";
                                    "customer_credits" = 0;
                                    "customer_date_of_birth" = "25-07-1989";
                                    "customer_email" = "rajws@gmail.com";
                                    "customer_id" = KLTSD3RIZG6QS4N;
                                    "customer_mobile" = 888888888888;
                                    "customer_name" = sudhakar;
                                    "customer_status" = 0;
                                    "customer_surname" = sudhakar;
                                    "customer_telephone" = 081443046948;
                                    "customer_terms" = "Cash only";
                                    "delihvery_day" = Monday;
                                    "dl_back" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/f332277e2c7546026e285676c8b61023.png";
                                    "dl_front" = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/8fb485a007285db6ccdeab07064a7edd.png";
                                    electric = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/2a9098aa61c3ff327153b586560fcf38.png";
                                    passport = "http://lanciusitsolutions.com/ayerserpalpha/my-assets/image/customer/de3ac5ddc2a4da030a5d4af12f378c52.png";
                                    "postal_address" = tyrtytry;
                                    sl = 2;
                                    status = 1;
                                    "trading_name" = yyuyuyy;
                                    userUpdated = 0;
                                    "user_name" = sudhakar;
                                    "user_password" = 123456;
                                }*/
                                
                                
                let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                print(jsonRespone)
                   
  /*  //            self.dataForTableView.removeAll()
                                self.dataForCustomersName.removeAll()
                                 self.dataForCustomers = items["customers_list"] as! [NSDictionary]
                                for item in self.dataForCustomers
                                {
                                    self.dataForCustomersName.append(item["user_name"] as! NSString)
                                }*/
                                var items = NSDictionary()

                                               items = jsonRespone as! NSDictionary
                                let listArray = items["customers_list"] as! [NSDictionary]
                                self.customerListArray.removeAllObjects()
                                self.customerListIdArray.removeAllObjects()
                                                           
                                                           for element :  NSDictionary in listArray {
                                                               let item  = element["customer_name"]
                                                               //let itemId = element["customer_id"]
                                                               self.customerListArray.add(item as Any)
                                                               self.customerListIdArray.add(element as Any)
                                                           }
                                 } catch let parsingError {
                                    print("Error", parsingError)
                               }
                            // let dataFromServer =
                         }
                     }
            }
        }
        func getDataForCategoryList()
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
                   let headerData = ["user_id":USERID,"user_type":USERTYPE]
                           AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
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
                                        var items = NSDictionary()

                                                       items = jsonRespone as! NSDictionary
                                        let listArray = items["category_list"] as! [NSDictionary]
                                                                   
                                        self.categoryListArray.removeAllObjects()
                                        self.categoryListIdArray.removeAllObjects()
                                        for element :  NSDictionary in listArray {
                                                                       let item  = element["category_name"]
                                                                       //let itemId = element["category_id"]
                                                                       self.categoryListArray.add(item as Any)
                                                                       self.categoryListIdArray.add(element as Any)
                                        }
                                     /*  print(jsonRespone)
                                        var items = NSDictionary()
                                       items = jsonRespone as! NSDictionary
                                       /*cell.categoryIdLabel.text = "Category Id : \(item["category_id"] ?? "")"
                                       cell.categoryNameLabel.text = "Category Name : \(item["category_name"] ?? "")"*/
                                       self.dataForCatagery = items["category_list"] as! [NSDictionary]
                                        self.dataForCatageryName.removeAll()
                                        for item in self.dataForCatagery
                                        {
                                            self.dataForCatageryName.append(item["category_name"] as! NSString)
                                        }*/
    //
                                       } catch let parsingError {
                                          print("Error", parsingError)
                                     }
                                  // let dataFromServer =
                               }
                           }
                   }
               }
            
        
        func getProductsDataFromServer()
        {
         //print("\(BaseUrl)/productList/\(USERTYPE)/\(self.catgery_id)/0")
         //let url : URL = URL(string:BaseUrl + "/productList/" + USERTYPE + "/" + self.catId + "/0")!
            let forCatId = self.catgeryDic["category_id"] as! String
            let url : URL = URL(string: BaseUrl + "/productList/" + USERTYPE + "/" + forCatId + "/0")!
                    let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                    AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any)// URL response
                        let response1 = response.response
                        if response1?.statusCode == 200
                        {
                             do{
                                  let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                                                        var items = NSDictionary()

                                                                                       items = jsonRespone as! NSDictionary
                                                                        let listArray = items["products_list"] as! [NSDictionary]
                                                                                                   
                                                                        self.itemInformationListArray.removeAllObjects()
                                                                        self.itemInformationListIdArray.removeAllObjects()
                                                                        for element :  NSDictionary in listArray {
                                                                                                       let item  = element["product_name"]
                                                                                                     //  let itemId = element["product_id"]
                                                                                                       self.itemInformationListArray.add(item as Any)
                                                                                                       self.itemInformationListIdArray.add(element as Any)
                                                                            self.pickerView.reloadAllComponents()                       }
                                /*  cell.brandLabel.text = "Brand : \(item["supplier_name"] ?? "")"
                                      cell.nameLabel.text = "Name : \(item["product_name"] ?? "")"
                                      cell.sizeLabel.text = "Size : \(item["unit"] ?? "")"
                                      cell.categoryIdLabel.text = "Category Id : \(item["category_id"] ?? "")"
                                      cell.grossPriceLabel.text = "Gross Price : $\(item["price"] ?? "")"
                                      cell.onHandLabel.text = "On Hand : \(item["actual_qty"] ?? "")"
                                      print("\(item["actual_qty"] ?? "")")*/
                                /* self.dataForProducts = item["products_list"] as! [NSDictionary]
                                                                   self.dataForProductsName.removeAll()
                                                                   for item in self.dataForProducts
                                                                   {
                                                                       self.dataForProductsName.append(item["product_name"] as! NSString)*/
                                        //}
    //                           if self.dataForTableView.count == 0
    //                           {
    //                               Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
    //                           }
    //                             self.manageProductTableView.reloadData()
    //                                 //as! [NSDictionary]

                                } catch let parsingError {
                                   print("Error", parsingError)
                              }
                           // let dataFromServer =
                        }
                    }
        }
//    func getDataCustomerData(){
//        let url = URL.init(string: BaseUrl + "/customerList")
//        var request = URLRequest.init(url: url!)
//        request.httpMethod = "POST"
//        let newTodo: [String: Any] = ["userStatus":"","user_type":"0"]
//
//        let jsonTodo: Data
//        do {
//            jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
//            request.httpBody = jsonTodo
//        } catch {
//            print("Error: cannot create JSON from todo")
//            return
//        }
//        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error  in
//            if error == nil
//            {
//                do{
//                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
//                    print("data \(jsonData)")
//                    DispatchQueue.main.async {
//
//                        let httpResponse = response as? HTTPURLResponse
//                        if httpResponse?.statusCode == 200
//                        {
//                            let listArray = jsonData["customers_list"] as! [NSDictionary]
//
//                            for element :  NSDictionary in listArray {
//                                let item  = element["customer_name"]
//                                let itemId = element["customer_id"]
//                                self.customerListArray.add(item as Any)
//                                self.customerListIdArray.add(itemId as Any)
//                            }
//                        }
//                        else
//                        {
//                            //   let message = jsonData["message"] as? NSString
//                            Alert.showBasic(titte: "Alert", massage:"Try Again!", vc: self)
//                        }
//                    }
//                }
//                catch{
//
//                }
//            }else{
//
//            }
//        }
//        dataTask.resume()
//
//    }
    func setValuesForLabelsInPopUp()
    {
        var quantityValue = Float()
        var discountValue = Float()
        let itemPrice : Float = (Float(productDic?["price"] as! String)!)
        
        if self.quantityTF.text!.count != 0
        {
            quantityValue = Float(self.quantityTF.text!)!
        }
        else
        {
           quantityValue = 0.00
        }
        if  self.discountOnItemTF.text!.count != 0
        {
            discountValue = Float(self.discountOnItemTF.text!)!
        }
        else
        {
           discountValue = 0
        }
        let totalPriceOfItem = itemPrice * quantityValue
         let costOfItemAfterDiscount = totalPriceOfItem * discountValue / 100
         self.totalPriceOfItemLabel.text = String(format : "$%.2f",totalPriceOfItem - costOfItemAfterDiscount)
        self.quantityTF.text = String(format : "%.0f", quantityValue )
        self.discountOnItemTF.text = String(format : "%.0f%", discountValue )
        self.rateOfItemLabel.text = String(format : "$%.2f", itemPrice )
    
    }
    func forCheckingToSelectOrNot() -> String
       {
           var message = String()
            let category_id = self.catgeryDic["category_id"] as? String
           if category_id?.count != nil{
               let product_Id = self.productDic?["product_id"] as? String
               if product_Id?.count != nil
                {
                   
               }
               else
               {
                   message = "Please select product"
               }
           }
           else{
                message = "Please select category"
           }
           return message
       }
    func addQuotation()
    {
         var product_id = String()
        var available_quantity = String()
        var product_quantity = String()
        var product_rate = String()
        var discount = String()
        var total_price = String()
        var tax = String()
        var discount_amount = String()
        var total_tax = String()
        var invoice_discount = String()
        var total_discount = String()
        var shipping_cost = String()
        var grand_total_price = String()
        var previous = String()
        var paid_amount = String()
        var n_total = Double()
        var due_amount = String()
        
      var discountTotalAmount = Float()
        var grandTotalAmount = Float()
         /*f ($product_id == '' || $customer_id == '' || $available_quantity == '' || $grand_total_price == ''  || $n_total == '' || $invoice_date == '' || $product_rate == '' || $total_price == '')*/
        
        /*let item : NSDictionary = ["category_name":self.catgeryDic["category_name"] ?? "" , "category_id":self.catgeryDic["category_id"] ?? "" , "product_name":self.productDic?["product_name"] ?? "" , "Qnty":self.quantityTF.text ?? "" , "unit":self.productDic?["unit"] ?? "" ,"price":self.productDic?["price"] ?? "" , "discount" : self.discountOnItemTF.text ?? "0" , "product_id":self.productDic?["product_id"] ?? "","avQunty":self.productDic?["actual_qty"] ?? ""]*/
        var totalPrice : Float = 0.0
        for item in dataToTableViewArray
        {
        var singleItem : Float = 0.0
        let priceOfItem = Float(item["price"] as! String)!
        let quantityOfItem = Float(item["Qnty"] as! String)!
        singleItem = priceOfItem * quantityOfItem
        totalPrice = totalPrice + singleItem
        if product_id.count == 0 {
            
        product_id = item["product_id"] as! String
            if let avQut = item["avQunty"]
            {
                available_quantity = "\(avQut)"
                    //String(format:"%li", avQut as! NSInteger)
            }
            else
            {
            available_quantity = "" //item["avQunty"] as! String
            }
            //item["avQunty"] as? String
        product_quantity = item["Qnty"] as! String
        product_rate = item["price"] as! String
            let discountPer = Float(item["discount"] as! String)!
            let discount_amountOfItem = singleItem * discountPer / 100
            discount_amount = String(format : "%.2f",discount_amountOfItem)
            discountTotalAmount = discount_amountOfItem
                //item["discount_amount"] as! String
        discount = item["discount"] as! String
        total_price = "\(singleItem)"
        tax = "0"
        }
        else
        {
        product_id = product_id + ","  + (item["product_id"] as! String)
        available_quantity = available_quantity + ","  + "\(item["avQunty"] ?? "")" //String(format:"%li", item["avQunty"] as! NSInteger)
            //(item["available_quantity"] as! String)
        product_quantity = product_quantity + ","  + (item["Qnty"] as! String)
        product_rate = product_rate + ","  + (item["price"] as! String)
            let discountPer = Float(item["discount"] as! String)!
            let discount_amountOfItem = singleItem * discountPer / 100
            discount_amount = discount_amount + "," + String(format : "%.2f",discount_amountOfItem)
             discountTotalAmount =  discountTotalAmount + discount_amountOfItem
        discount = discount + "," + (item["discount"] as! String)
        total_price = total_price + "," + "\(singleItem)"
        tax = tax + ","  + "0"
        }
        }
        var forDeliveryCharges : Float = 0.0
        if totalPrice < 100
        {
        forDeliveryCharges = totalPrice / 10.0
            grandTotalAmount = totalPrice - discountTotalAmount + forDeliveryCharges
        //self.deliveryChargesLabel.text = "Delivery Charges : \(forDeliveryCharges)"
        }
        else
        {
        forDeliveryCharges = 0.0
            grandTotalAmount = totalPrice - discountTotalAmount
        // self.deliveryChargesLabel.text = "Delivery Charges : 0.0"
        }
        var supplierCharge : Float = 0.0
                   if totalPrice < 100
                   {
                    supplierCharge = totalPrice / 10
                       
                   }
                   else{
                       supplierCharge = 0.0
                       
                   }
        var invoiceValue = 0
        if self.invoiceDiscountValue == ""
        {
            self.invoiceDiscountValue = "0"
            invoiceValue = 0
        }
        
        invoiceValue = NSInteger(self.invoiceDiscountValue)!
        
      let n_totalValue = totalPrice + supplierCharge - (totalPrice * Float(invoiceValue))  - customer_balance
        
        
        //var user_type = String()

        let parameters = ["product_id" : product_id ,"available_quantity" : available_quantity , "product_quantity": product_quantity , "product_rate" : product_rate , "discount" : discount , "total_price" : total_price , "tax" : tax, "discount_amount" : discount_amount , "total_tax" : total_tax , "invoice_discount" : String(format :"%.2f",invoiceValue) , "total_discount" : String(format :"%.2f", total_discount) ,"shipping_cost" : String(format :"%.2f", supplierCharge) ,"grand_total_price" : String(format :"%.2f" ,totalPrice) , "previous" : "" , "paid_amount" : "0" ,  "n_total" : String(format :"%.2f", n_totalValue) , "due_amount": "0" , "user_type" : USERTYPE , "customer_id" : self.customerDic!["customer_id"] as! String , "user_id" : USERID, "invoice_date" : self.dateTf.text!]
        //checkout_quotation
        let urlString : String = BaseUrl + "/checkout_quotation"
        //"https://ayersfood.com/erpapi/api/checkout_quotation"
            //BaseUrl + "/checkout_quotation"
        let url : URL = URL(string: urlString)!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                            print(response.request as Any)  // original URL request
                            print(response.response as Any)// URL response
                            let response1 = response.response
                            if response1?.statusCode == 200
                            {
                                 do{
                                      let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                      var items = NSDictionary()

                                      items = jsonRespone as! NSDictionary
                                    self.dataToTableViewArray.removeAll()
                                    self.newQuationTableView.reloadData()
 Alert.showBasic(titte: "Success", massage: "\(items["title"] ?? "The Invoice Created Successfully")", vc: self)
                                    } catch let parsingError {
                                       print("Error", parsingError)
                                  }
                               // let dataFromServer =
                            }
            else
                            {
                                Alert.showBasic(titte: "Sorry", massage: "Please try again", vc: self)
            }
                        }
    }
    /*https://ayersfood.com/erpapi/api/Checkout_quotation
    {
    "product_id":"89654,85748596,85742",
    "available_quantity":"800,500,400",
    "product_quantity":"2,3,1",
    "product_rate":"30.00,36.00,66.00",
    "discount":"0,0,0",
    "total_price":"60.00,108.00,66.00",
    "tax":"0,0,0",
    "discount_amount":"0,0,0",
    "total_tax":"0.00",
    "invoice_discount":"0",
    "total_discount":"0.00",
    "shipping_cost":"0.00",
    "grand_total_price":"234.00",
    "previous":"0",
    "n_total":"234.00",
    "paid_amount":"0",
    "due_amount":"0.00",
    "user_type":"3",
    }
*/
}
