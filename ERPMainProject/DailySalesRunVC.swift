//
//  DailySalesRunVC.swift
//  ERPMainProject
//
//  Created by Hari on 30/05/20.
//  Copyright © 2020 Lancius. All rights reserved.
//

import UIKit
import Alamofire
class DailySalesRunTableViewCell : UITableViewCell
{
    @IBOutlet weak var cellView: UIView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
}
class DailySalesRunVC: UIViewController {
    @IBOutlet weak var dailySalesRunTableView: UITableView!
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
           let cell = tableView .dequeueReusableCell(withIdentifier: "DailySalesRunTableViewCellID", for: indexPath) as! DailySalesRunTableViewCell
           /*
               "dailing_id": "172",
               "customer_userid": "1TTI33968AD6YDI",
               "dail_type": "1",
               "dail_status": "1",
               "dail_by": "Parveen&nbsp;Kumar",
               "dail_detail": "0",
               "dail_date": "23-04-2020",
               "customer_id": "121",
               "customer_name": "FOOD WORLD S/M",
               "customer_address": "FOOD WORLD S/M 13/226 Queen St  (81 Dumerescq St) CAMPBELLTOWN P REDDY :0414 639 364",
               "customer_contact": "REDDY",
               "customer_phone": "0414639364",
               "customer_email": "m.k.reddy@live.com",
               "customer_area": "CAMPBELLTOWN",
               "dailing_day": "FOOD WORLD S/M",
               "created_by": "3oroMCZSrAv32YG",
               "created_date": "2020-04-18 11:56:28",
               "customer_status": "1",
               "sl": 1,
               "dailing_detail": "0",
               "day_class": "clsAllday",
               "dial_class": "dial_green"
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
        cell.nameLabel.text = "Name : \(item["customer_name"] ?? "")"
         cell.dateLabel.text = "Date : \(item["dail_date"] ?? "")"
         cell.addressLabel.text = "Address : \(item["customer_address"] ?? "")"
         cell.emailLabel.text = "Email : \(item["customer_email"] ?? "")"
         cell.phoneLabel.text = "Phone : \(item["customer_phone"] ?? "")"
        
        
           
           return cell
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
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
                 "startdate":"",
                 "dailing_day":"",
                 "dial_range":"",
                 "dail_status":""
             
]
            
            self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
            // http://cygenerp.com/erpapi/api/dealingcrm_list
            let url : URL = URL(string: BaseUrl + "/dealingcrm_list")!
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
                                        self.dailySalesRunTableView.isHidden = true
                                        Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                    }
                                    else
                                    {
                                        self.dailySalesRunTableView.isHidden = false
                                    }
                                    self.dailySalesRunTableView.reloadData()
                                    } catch let parsingError {
                                       print("Error", parsingError)
                                  }
                               // let dataFromServer =
                            }
                }
                        }
            }

}
