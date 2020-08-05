//
//  CustomerManageProductViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class CustomerManageProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var plusAndSubView: UIView!
    
}

class CustomerManageProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var catId = String()
    var dataForTableView = [NSDictionary]()
    var positionValue = NSInteger()
    @IBOutlet weak var forCartCountLabel: UILabel!
    @IBOutlet weak var forCartCountView: UIView!
    @IBOutlet weak var manageCustomerTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    var allDataForTableView = [NSDictionary]()
       var nameOfProductArray = [String]()
       var filteredData = [String]()
  //  @IBOutlet weak var searchView: UIView!
     @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.manageCustomerTableView.delegate = self
        self.manageCustomerTableView.dataSource = self
        self.forCartCountView.layer.cornerRadius = 10
        
    setShowToSearchView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getDataFromServer()
        self.setCountForCart()
    }

    func setCountForCart()
    {
        let cartArray = getDataFromCoreData()
        self.forCartCountLabel.text = "\(cartArray.count)"
    }
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "CustomerManageProductTableViewCellId", for: indexPath) as! CustomerManageProductTableViewCell
        
         let item = self.dataForTableView[indexPath.row]
        /*{
            "id": "33",
            "supplier_id": "M5HLOM3YVTDLN2JR6H4J",
            "supplier_name": "AYERS",
            "address": "AYERS\r\n",
            "mobile": "0",
            "details": "AYERS\r\n",
            "status": "1",
            "product_id": "89654",
            "category_id": "W15LDBOFCPYPMQ8",
            "product_name": "SLICED COCONUT",
            "price": "30",
            "unit": "400g x 12",
            "tax": "0",
            "serial_no": "8585858",
            "product_model": "ARTPL741585",
            "product_details": "SLICED COCONUT",
            "image": "http://lanciusitsolutions.com/ayerserp/my-assets/image/product/685f1855386355f0c2e0c3b2021a2297.jpg",
            "productNew": "0",
            "number_of_pieces": "12",
            "price_per_pieces": "2.50",
            "supplier_pr_id": "581",
            "products_model": "0",
            "supplier_price": "29.4",
            "sl": 2,
            "categoryName": "FROZEN",
            "actual_qty": "2532"
        }*/
    if isInCart(data: item)
        {
            let itemInCart : NSDictionary = self.itemInCart(data: item)
            cell.productCountLabel.text = "\(itemInCart["product_quantity"] ?? "")"
            cell.plusAndSubView.isHidden = false
            cell.addButton.isHidden = true
        }
        else
    {
        cell.productCountLabel.text = ""
        cell.plusAndSubView.isHidden = true
        cell.addButton.isHidden = false
        }
        cell.productImage.imageFromServerURL(image: item["image"] as! String)
        cell.productNameLabel.text = "\(item["product_name"] ?? "")"
        
        cell.productQuantityLabel.text = "Available in : \(item["unit"] ?? "") $ \(item["price"] ?? "")"
        cell.addButton.tag = indexPath.row
        cell.subButton.tag = indexPath.row
        cell.plusButton.tag = indexPath.row
        
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
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func gotoCartAction(_ sender: Any) {
        let cartArray = getDataFromCoreData()
        if cartArray.count == 0
        {
            Alert.showBasic(titte: "Sorry", massage: "Please add item to cart", vc: self)
        }
        else
        {
        let main = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = main.instantiateViewController(withIdentifier: "CustomerManageCartVCId") as! CustomerManageCartVC
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func checkOutBtnAction(_ sender: UIButton) {
        let cartArray = getDataFromCoreData()
        if cartArray.count == 0
        {
            Alert.showBasic(titte: "Sorry", massage: "Please add item to cart", vc: self)
        }
        else
        {
        let main = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = main.instantiateViewController(withIdentifier: "CustomerManageCartVCId") as! CustomerManageCartVC
        self.navigationController?.pushViewController(vc, animated: true)
        }
//        let main = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = main.instantiateViewController(withIdentifier: "CustomerManageCartVCId") as! CustomerManageCartVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addBtnAction(_ sender: UIButton) {
        /*{
            "id": "33",
            "supplier_id": "M5HLOM3YVTDLN2JR6H4J",
            "supplier_name": "AYERS",
            "address": "AYERS\r\n",
            "mobile": "0",
            "details": "AYERS\r\n",
            "status": "1",
            "product_id": "89654",
            "category_id": "W15LDBOFCPYPMQ8",
            "product_name": "SLICED COCONUT",
            "price": "30",
            "unit": "400g x 12",
            "tax": "0",
            "serial_no": "8585858",
            "product_model": "ARTPL741585",
            "product_details": "SLICED COCONUT",
            "image": "http://lanciusitsolutions.com/ayerserp/my-assets/image/product/685f1855386355f0c2e0c3b2021a2297.jpg",
            "productNew": "0",
            "number_of_pieces": "12",
            "price_per_pieces": "2.50",
            "supplier_pr_id": "581",
            "products_model": "0",
            "supplier_price": "29.4",
            "sl": 2,
            "categoryName": "FROZEN",
            "actual_qty": "2532"
        }*/
        let item = self.dataForTableView[sender.tag]
        
        /*{
            "id": "33",
            "supplier_id": "M5HLOM3YVTDLN2JR6H4J",
            "supplier_name": "AYERS",
            "address": "AYERS\r\n",
            "mobile": "0",
            "details": "AYERS\r\n",
            "status": "1",
            "product_id": "5000521",
            "category_id": "4IFM69QPC1669F4",
            "product_name": "TVP SOYA MEAL",
            "price": "22",
            "unit": "",
            "tax": "0",
            "serial_no": "",
            "product_model": "AYER-1171",
            "product_details": "TVP SOYA MEAL",
            "image": "http://lanciusitsolutions.com/ayerserp/my-assets/image/product.png",
            "productNew": "0",
            "number_of_pieces": "1",
            "price_per_pieces": "22.00",
            "supplier_pr_id": "618",
            "products_model": "0",
            "supplier_price": "22",
            "sl": 2,
            "categoryName": "TVP",
            "actual_qty": 1000
        }*/
        
        toAddItemInCoredata(product_id: item["product_id"] as! String, available_quantity: "\(item["actual_qty"] as! String)", product_quantity: "1", product_rate: item["price"] as! String, discount: "0", total_price: item["price"] as! String, tax: item["tax"] as! String, discount_amount: "0", image : item["image"] as! String ,product_name : item["product_name"] as! String,unit : item["unit"] as! String)
        self.setCountForCart()
      self.manageCustomerTableView.reloadData()
    }
    @IBAction func plusBtnAction(_ sender: UIButton) {
        let item = self.dataForTableView[sender.tag]
        let itemInCart = self.itemInCart(data: item)
              let itemPrice : Float = Float(itemInCart["product_rate"] as! String)!
              let itemQuantity : NSInteger = NSInteger(itemInCart["product_quantity"] as! String)!
              let total_price  = itemPrice * Float(itemQuantity + 1)
        let totalPriceString : String = String(total_price)
        updateItemInCoreData(product_id: itemInCart["product_id"] as! String, available_quantity: itemInCart["available_quantity"] as! String, product_quantity: "\(itemQuantity + 1)", product_rate: itemInCart["product_rate"] as! String, discount: "0", total_price: totalPriceString, tax: itemInCart["tax"] as! String, discount_amount: "0", positionValue: self.positionValue ,image : itemInCart["image"] as! String,product_name : item["product_name"] as! String,unit : item["unit"] as! String)
        self.setCountForCart()
        self.manageCustomerTableView.reloadData()
    }
    @IBAction func subButtonAction(_ sender: UIButton) {
        let item = self.dataForTableView[sender.tag]
               let itemInCart = self.itemInCart(data: item)
                     let itemPrice : Float = Float(itemInCart["product_rate"] as! String)!
                     let itemQuantity : NSInteger = NSInteger(itemInCart["product_quantity"] as! String)!
        if itemQuantity != 1
        {
                     let total_price  = itemPrice * Float(itemQuantity - 1)
               let totalPriceString : String = String(total_price)
            updateItemInCoreData(product_id: itemInCart["product_id"] as! String, available_quantity: itemInCart["available_quantity"] as! String, product_quantity: "\(itemQuantity - 1)", product_rate: itemInCart["product_rate"] as! String, discount: "0", total_price: totalPriceString, tax: itemInCart["tax"] as! String, discount_amount: "0", positionValue: self.positionValue , image :itemInCart["image"] as! String ,product_name : item["product_name"] as! String,unit : item["unit"] as! String)
        }
        else
        {
            delectItemFromCart(position: self.positionValue)
        }
        self.setCountForCart()
         self.manageCustomerTableView.reloadData()
    }
    func itemInCart(data : NSDictionary) -> NSDictionary
    {
        let dataProductId = data["product_id"] as! String
        var j = 0
        let array = getDataFromCoreData()
        for cart in array
        {
            let  productId = cart["product_id"] as! String
            if productId == dataProductId
            {
                self.positionValue = NSInteger(j)
                // self.positionString = NSInteger(j)
                return cart
            }
             j = j + 1
        }
        return data
    }
    func isInCart(data : NSDictionary) -> Bool
    {
        let dataProductId = data["product_id"] as! String
        let array = getDataFromCoreData()
        var j = 0
        for cart in array
        {
            let  productId = cart["product_id"] as! String
            if productId == dataProductId
            {
                self.positionValue = NSInteger(j)
               // self.positionString = NSInteger(j)
                return true
            }
            j = j + 1
        }
        return false
    }
    //MARK :- Network
    func getDataFromServer()
       {
        print("\(BaseUrl)/productList/\(USERTYPE)/\(self.catId)/0")
        let url : URL = URL(string:BaseUrl + "/productList/" + USERTYPE + "/" + self.catId + "/0")!
        let dic = [
            "user_id" : USERID,
          "user_type" : USERTYPE,
          "cat_id" : self.catId

        ]

        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                    AF.request(url, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                       print(response.request as Any)  // original URL request
                       print(response.response as Any)// URL response
                       let response1 = response.response
                       if response1?.statusCode == 200
                       {
                            do{
                                let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                               print(jsonRespone)
                                let item = jsonRespone as NSDictionary
                                self.dataForTableView = item["products_list"] as! [NSDictionary]
                                self.allDataForTableView = self.dataForTableView
                                self.filteredData.removeAll()
                                for item in self.allDataForTableView
                                {
                                    self.filteredData.append(item["product_name"] as! String)
                                }
                                if self.dataForTableView.count == 0
                                {
                                    Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                }
                                self.manageCustomerTableView.reloadData()
                                    //as! [NSDictionary]

                               } catch let parsingError {
                                  print("Error", parsingError)
                             }
                          // let dataFromServer =
                       }
                   }
       }
    func getItemDetails(itemName : String , itemsArray : [NSDictionary] , itemType : String) -> NSDictionary
    {
        let emptyDic = NSDictionary()
      for item in itemsArray
      {
        if itemName == item[itemType] as! String
        {
            return item
        }
        }
        return emptyDic
    }
    /* http://ayersfood.com/erpapi/api/productActiveparams:{
    "user_type":"1",
    "productId":"748598",
    "product_status":"0"
    }*/
    
    
    @IBAction func searchValueChange(_ sender: UITextField) {
        if self.searchTextField.text?.count != 0
        {
            forSearchAction(searchText: self.searchTextField.text!)
        }
        else
        {
            self.dataForTableView = self.allDataForTableView
            self.manageCustomerTableView.reloadData()
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
            for product in self.allDataForTableView
            {
                if item == product["product_name"] as! String
                {
                    itemsArray.append(product)
                }
            }
        }
        
        self.dataForTableView.removeAll()
        self.dataForTableView = itemsArray
        self.manageCustomerTableView.reloadData()
    }
    func setShowToSearchView()
    {
                   self.searchView.layer.shadowColor = UIColor.lightGray
                   self.searchView.layer.shadowOpacity = 1
                   self.searchView.layer.masksToBounds = false
                   self.searchView.layer.shadowOffset = CGSize(width: 1, height: 1)
                   self.searchView.layer.cornerRadius = 8
                   self.searchTextField.setDarkModeToNormal()
    }
}
/*{
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
"customer_id":"ZPYJ2DYWK43MDIF",
"invoice_date":"2019-11-27"
}


*/
