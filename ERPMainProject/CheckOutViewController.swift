//
//  CheckOutViewController.swift
//  SupportFromERP
//
//  Created by Kardas Veeresham on 12/6/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class CheckOutTableViewCell: UITableViewCell {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}

class CheckOutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var CheckOutTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var deliveryChargeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!
    var dataForTableView = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CheckOutTableView.delegate = self
        self.CheckOutTableView.dataSource = self
        self.transView.isHidden = true
        self.setDataForTableView()
        self.CheckOutTableView.tableFooterView =  UIView(frame: .zero)
    }
    
    func setDataForTableView()
    {
        self.dataForTableView = getDataFromCoreData()
        self.CheckOutTableView.reloadData()
    }
    
    // MARK: - Tableview Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "CheckOutTableViewCellId", for: indexPath) as! CheckOutTableViewCell
        
        let item = self.dataForTableView[indexPath.row]
        cell.productNameLabel.text = "\(item["product_name"] ?? "")"
        cell.quantityLabel.text = "\(item["product_quantity"] ?? "")"
        
        let quantityValue : Float = Float(item["product_quantity"] as! String)!
        let totalAmount : Float = Float(item["product_quantity"] as! String)!
        let finalVale : Float = quantityValue * totalAmount
        
        cell.priceLabel.text = "\(item["product_quantity"] ?? "")  * $\(item["product_rate"] ?? "") = \(finalVale)"
        
        
//        cell.productImage.imageFromServerURL(image: item["image"] as! String)
//        cell.priceOfItemLabel.text = "\(item["product_quantity"] ?? "")  * $\(item["product_rate"] ?? "")"
//        cell.unitLabel.text = "\(item["unit"] ?? "")"
//        cell.productQuantityLabel.text = "\(item["product_quantity"] ?? "")"
//
//        cell.cellView.layer.shadowColor = UIColor.lightGray
//        cell.cellView.layer.shadowOpacity = 1
//        cell.cellView.layer.masksToBounds = false
//        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
//        cell.cellView.layer.cornerRadius = 8
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

   
    @IBAction func placeOrderBtnAction(_ sender: UIButton) {
    
        
    }
    func toGetDataFromServer()
         {
             let url : URL = URL(string:BaseUrl + "/customerdetail")!
              //"/invoiceList/" + "\(USERTYPE)/" + "\(USERID)")!
                let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
          let parameter = [
            "user_type" : USERTYPE,
          "user_id": USERID,
          "customer_id": ""
          ]

            //["customer_id" : USERID]
                     AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                         print(response.request as Any)  // original URL request
                         print(response.response as Any)// URL response
                         let response1 = response.response
                         if response1?.statusCode == 200
                         {
                              do{
                                 let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                                 print(jsonRespone)
                                  /*                                    "company_info": [
                                         {
                                             "company_id": "1",
                                             "company_name": "Ayers Rock Trading ",
                                             "email": "sales@ayersrocktrading.com.au",
                                             "address": "Block C, Unit 4-5 102 Station Road, Seven Hills, 2147, NSW Australia",
                                             "mobile": "(61) 296362091",
                                             "website": "https://ayersrocktrading.com.au/",
                                             "status": "1"
                                         }
                                     ],
                                     "currency": "$",
                                     "position": "0"*/
                                 // self.jsonDic = jsonRespone
                                  let companyDetailsArray = jsonRespone["company_info"] as! [NSDictionary]
                                  let companyDetails = companyDetailsArray[0]
                                  
                                  
                               
                                  
                                 } catch let parsingError {
                                    print("Error", parsingError)
                               }
                         }
                     }
         }
      
}
