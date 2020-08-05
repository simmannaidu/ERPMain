//
//  ManageCustomerProductPriceViewController.swift
//  ERPMainProject
//
//  Created by Hari on 01/06/20.
//  Copyright © 2020 Lancius. All rights reserved.
//

import UIKit
import Alamofire
class ManageCustomerProductPriceCell : UITableViewCell
{
    @IBOutlet weak var cellView: UIView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var finalPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
}

class ManageCustomerProductPriceViewController: UIViewController {
    @IBOutlet weak var manageCustomerProductPriceTableView: UITableView!
          @IBOutlet weak var transView: UIView!
          var dataForTableView = [NSDictionary]()
       override func viewDidLoad() {
           super.viewDidLoad()

           // Do any additional setup after loading the view.
       }
       
       override func viewWillAppear(_ animated: Bool) {
           if CheckInternet.Connection(){
                                       self.getDataForServer()
                                   }else{
                                       Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                                   }
                  
              }

             
              // MARK: - Tableview Delegates
              func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                  return self.dataForTableView.count
              }
              func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                  let cell = tableView .dequeueReusableCell(withIdentifier: " ManageCustomerProductPriceCellId", for: indexPath) as! ManageCustomerProductPriceCell
                  /*
                       {
                                 "id": "2",
                                 "customer_id": "8CMUZD32GD6X7TX",
                                 "product_id": "12355265",
                                 "new_price": "20.00",
                                 "status": "1",
                                 "sl": 2,
                                 "customer_name": "MASONQ<br/> Ta-MASONQTR",
                                 "old_price": "30.00",
                                 "product_name": "SOYA PROTEIN",
                                 "unit": "500g X 7"
                             }

                  }*/
                  let item = self.dataForTableView[indexPath.row]
                  //cell.invoiceId.text = "Invoice Id : \(item["invoice_id"] ?? "")"
                 // cell.categoryNameLabel.text = "Customer Name : \(item["customer_name"] ?? "")"
                //  cell.dateLabel.text = "Date : \(item["date_return"] ?? "")"
                 // cell.amountLabel.text = "Total Amount : $\(item["total_ret_amount"] ?? "")"
                  
                          cell.cellView.layer.shadowColor = UIColor.lightGray
                          cell.cellView.layer.shadowOpacity = 1
                          cell.cellView.layer.masksToBounds = false
                          cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                          cell.cellView.layer.cornerRadius = 8
               cell.nameLabel.text = "Customer Name : \(item["customer_name"] ?? "")"
                cell.oldPriceLabel.text = "$ : \(item["new_price"] ?? "")"
                cell.finalPriceLabel.text = "$ : \(item["new_price"] ?? "")"
                cell.productNameLabel.text = "Product Name : \(item["product_name"] ?? "")"
                cell.unitLabel.text = "Unit : \(item["unit"] ?? "")"
               
               
                  
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

           @IBAction func deleteButtonView(_ sender: UIButton) {
           }

           /*
           // MARK: - Navigation

           // In a storyboard-based application, you will often want to do a little preparation before navigation
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               // Get the new view controller using segue.destination.
               // Pass the selected object to the new view controller.
           }
           */
           func getDataForServer()
               {
                let date = Date()
                let formatter = DateFormatter()


                formatter.dateFormat = "dd-MM-yyyy"


                let currentDateString = formatter.string(from: date)
                   
                   /*{
                   "customer_id":"1",
                   "dtpFromDate":"2019-09-04",
                   "dtpToDate":"2019-06-04",
                   "search":"1"
                   }*/
           //        let parameter = [
           //            "customer_id" : USERID , "dtpFromDate" : "2019-09-04",
           //            "dtpToDate" : currentDateString ,
           //            "search" : "1"]
                    let headerData = [
                        
                            "user_type":USERTYPE,
                            "customer":USERID,
                            "area":"",
                            "dailing_day":""
                        
                    
       ]
                   
                   self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
                   // http://cygenerp.com/erpapi/api/dealingcrm_list
                   let url : URL = URL(string: BaseUrl + "/crm_list")!
                   let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
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
                                           print(jsonRespone)
                                            var items = NSDictionary()
                                           items = jsonRespone as! NSDictionary
                                          self.dataForTableView = items["crm_list"] as! [NSDictionary]
                                           if self.dataForTableView.count == 0
                                           {
                                               self.manageCustomerProductPriceTableView.isHidden = true
                                               Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                           }
                                           else
                                           {
                                               self.manageCustomerProductPriceTableView.isHidden = false
                                           }
                                           self.manageCustomerProductPriceTableView.reloadData()
                                           } catch let parsingError {
                                              print("Error", parsingError)
                                         }
                                      // let dataFromServer =
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


