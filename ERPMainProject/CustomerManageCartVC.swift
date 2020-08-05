//
//  CustomerManageCartVC.swift
//  AyersERP
//
//  Created by Hari on 28/11/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class CustomerManageCartVCTableViewCell : UITableViewCell
{
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var plusBt: UIButton!
    @IBOutlet weak var subBt: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var priceOfItemLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
}
class CustomerManageCartVC: UIViewController , UITableViewDataSource , UITableViewDelegate{

    
    @IBOutlet weak var noRecordsFoundLabel: UILabel!
    @IBOutlet weak var placeOrderView: UIView!
    @IBOutlet weak var bottemView: UIView!
    @IBOutlet weak var grandTotalLabel: UILabel!
    @IBOutlet weak var deliveryChargesLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var customerManageCartTV: UITableView!
    var dataInTableView = [NSDictionary]()
    var positionValue = NSInteger()
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromCD()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func getDataFromCD()
    {
        dataInTableView = getDataFromCoreData()
        if dataInTableView.count == 0
        {
           self.navigationController?.popViewController(animated: true)
        }
        else
            {
                
        
        print("\(dataInTableView)")
        var totalPrice : Float = 0.0
        var singleItem : Float = 0.0
        for item in dataInTableView
        {
            let priceOfItem = Float(item["total_price"] as! String)!
            let quantityOfItem = Float(item["product_quantity"] as! String)!
            singleItem = priceOfItem * quantityOfItem
            totalPrice = totalPrice + singleItem
        }
        let totalPriceString = String(totalPrice)
        self.subTotalLabel.text = "Sub Total : \(totalPriceString)"
        var forDeliveryCharges : Float = 0.0
        if totalPrice < 100
        {
            forDeliveryCharges = totalPrice / 10.0
            self.deliveryChargesLabel.text = "Delivery Charges : \(forDeliveryCharges)"
        }
        else
        {
          self.deliveryChargesLabel.text = "Delivery Charges : 0.0"
        }
        self.grandTotalLabel.text = "Grand Total : \(totalPrice + forDeliveryCharges)"
        self.customerManageCartTV.reloadData()
        }
    }
    //MARK : - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataInTableView.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView .dequeueReusableCell(withIdentifier: "CustomerManageCartVCTableViewCellId", for: indexPath) as! CustomerManageCartVCTableViewCell
            /*{
                "available_quantity" = 2531;
                discount = 0;
                "discount_amount" = 0;
                image = "http://lanciusitsolutions.com/ayerserp/my-assets/image/product/685f1855386355f0c2e0c3b2021a2297.jpg";
                "product_id" = 89654;
                "product_name" = "SLICED COCONUT";
                "product_quantity" = 1;
                "product_rate" = 30;
                tax = 0;
                "total_price" = 30;
            }*/
            let item = self.dataInTableView[indexPath.row]
            cell.productNameLabel.text = "\(item["product_name"] ?? "")"
            cell.productImage.imageFromServerURL(image: item["image"] as! String)
            cell.priceOfItemLabel.text = "\(item["product_quantity"] ?? "")  * $\(item["product_rate"] ?? "")"
            cell.unitLabel.text = "\(item["unit"] ?? "")"
            cell.productQuantityLabel.text = "\(item["product_quantity"] ?? "")"
            
            cell.cellView.layer.shadowColor = UIColor.lightGray
            cell.cellView.layer.shadowOpacity = 1
            cell.cellView.layer.masksToBounds = false
            cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
            cell.cellView.layer.cornerRadius = 8
            
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 170
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
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
    @IBAction func placeOrderAction(_ sender: UIButton) {
    
        if USERTYPE == "2"
        {
            let vc = UIStoryboard.init(name: "sales", bundle: Bundle.main).instantiateViewController(withIdentifier: "CartViewControllerId") as? CartViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else{
        var product_id = String()
        var available_quantity = String()
        var product_quantity = String()
        var product_rate = String()
        var discount = String()
        var total_price = String()
        var tax = String()
        var discount_amount = String()
        dataInTableView = getDataFromCoreData()
        print("\(dataInTableView)")
        var totalPrice : Float = 0.0
        
        for item in dataInTableView
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
        self.grandTotalLabel.text = "Grand Total : \(totalPrice + forDeliveryCharges)"
            let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let url : URL = URL(string: BaseUrl + "/checkout")!
        let headerData = ["product_id":product_id,"available_quantity":available_quantity,"product_quantity":product_quantity,"product_rate":product_rate,"discount":discount,"total_price":total_price,"tax":tax,"discount_amount":discount_amount,"total_tax":"0","invoice_discount":"0","total_discount":"0","shipping_cost":"\(forDeliveryCharges)","grand_total_price":"\(totalPrice)","previous":"","n_total":"\(totalPrice + forDeliveryCharges)","paid_amount":"0","due_amount":"0","user_type":USERTYPE,"customer_id":USERID,"invoice_date":""]
                AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any)// URL response
                    let response1 = response.response
                    if response1?.statusCode == 200
                    {
                         do{
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                            print(jsonRespone)
                            let item = jsonRespone as! NSDictionary
                            
                                
                            
                            
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                    
                }
        }
    }
    @IBAction func backAction(_ sender: UIButton) {
    }
    
    @IBAction func plusAction(_ sender: UIButton) {
        let item = self.dataInTableView[sender.tag]
        let itemInCart = self.itemInCart(data: item)
              let itemPrice : Float = Float(itemInCart["product_rate"] as! String)!
              let itemQuantity : NSInteger = NSInteger(itemInCart["product_quantity"] as! String)!
              let total_price  = itemPrice * Float(itemQuantity + 1)
        let totalPriceString : String = String(format: "%.2f", total_price)
        updateItemInCoreData(product_id: itemInCart["product_id"] as! String, available_quantity: itemInCart["available_quantity"] as! String, product_quantity: "\(itemQuantity + 1)", product_rate: itemInCart["product_rate"] as! String, discount: "0", total_price: totalPriceString, tax: itemInCart["tax"] as! String, discount_amount: "0", positionValue: self.positionValue ,image : itemInCart["image"] as! String,product_name : item["product_name"] as! String,unit : item["unit"] as! String)
        getDataFromCD()
    }
    @IBAction func subAction(_ sender: UIButton) {
        let item = self.dataInTableView[sender.tag]
                      let itemInCart = self.itemInCart(data: item)
                            let itemPrice : Float = Float(itemInCart["product_rate"] as! String)!
                            let itemQuantity : NSInteger = NSInteger(itemInCart["product_quantity"] as! String)!
               if itemQuantity != 1
               {
                            let total_price  = itemPrice * Float(itemQuantity - 1)
                      let totalPriceString : String = String(format: "%.2f", total_price)
                   updateItemInCoreData(product_id: itemInCart["product_id"] as! String, available_quantity: itemInCart["available_quantity"] as! String, product_quantity: "\(itemQuantity - 1)", product_rate: itemInCart["product_rate"] as! String, discount: "0", total_price: totalPriceString, tax: itemInCart["tax"] as! String, discount_amount: "0", positionValue: self.positionValue , image :itemInCart["image"] as! String ,product_name : item["product_name"] as! String,unit : item["unit"] as! String)
               }
               else
               {
                   delectItemFromCart(position: self.positionValue)
               }
                getDataFromCD()
    }
    /*sudhakar nayak 6:08 PM
    https://ayersfood.com/erpapi/api/checkout
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
    "customer_id":"ZPYJ2DYWK43MDIF",
    "invoice_date":"2019-11-27"
    }*/
    //MARK:- Network
     func placeOrder()
        {
            var product_id = String()
            var available_quantity = String()
            var product_quantity = String()
            var product_rate = String()
            var grand_total_price = String()
            var n_total = String()
            var invoice_date = String()
            let url : URL = URL(string: BaseUrl + "/checkout")!
            let headerData = ["product_id":"","available_quantity":"","product_quantity":"","product_rate":"","discount":"0","total_price":"","tax":"0","discount_amount":"0","total_tax":"0","invoice_discount":"0","total_discount":"0","shipping_cost":"","grand_total_price":"","previous":"","n_total":"","paid_amount":"0","due_amount":"0","due_amount":"","user_type":USERTYPE,"customer_id":USERID,"invoice_date":""]
            let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                    AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any)// URL response
                        let response1 = response.response
                        if response1?.statusCode == 200
                        {
                             do{
                                let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                print(jsonRespone)
                                let item = jsonRespone as! NSDictionary
                                
                                    
                                
                                
                                } catch let parsingError {
                                   print("Error", parsingError)
                              }
                           // let dataFromServer =
                        }
                        else if response1?.statusCode == 200
                        {
                             do{
                                let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
                                print(jsonRespone)
                                let item = jsonRespone as! NSDictionary
                                
                                    Alert.showBasic(titte: "Sorry", massage: item["errorMessage"] as! String, vc: self)
                                
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
