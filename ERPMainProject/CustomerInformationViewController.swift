//
//  CustomerInformationViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class CustomerInformationViewController: UIViewController {
    @IBOutlet weak var tradingNameLabel: UILabel!
    @IBOutlet weak var companyMobileLabel: UILabel!
    
    @IBOutlet weak var companyEmailLabel: UILabel!
    @IBOutlet weak var companyTelephoneLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var companyABNLabel: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameOfCustomerLabel: UILabel!
    @IBOutlet weak var postalAddressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.toGetDataFromServer()
    }
    
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK :- Network
    func toGetDataFromServer()
       {
           let url : URL = URL(string:BaseUrl + "/customerdetail")!
            //"/invoiceList/" + "\(USERTYPE)/" + "\(USERID)")!
             let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let parameter = [
        "user_type":USERTYPE,
        "user_id":USERID,
        "customer_id":USERID
        ]

            //["customer_id":USERID]
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
            self.companyABNLabel.text = "\(jsonRespone["company_abn"] ?? "")"
            self.companyName.text = "\(companyDetails["company_name"] ?? "")"
                                self.companyEmailLabel.text = "\(companyDetails["email"] ?? "")"
                                self.companyMobileLabel.text = "\(companyDetails["mobile"] ?? "")"
                                self.companyAddressLabel.text = "\(companyDetails["address"] ?? "")"
                                self.companyTelephoneLabel.text = "\(jsonRespone["company_telephone"] ?? "")"
                                
                                /*telephoneLabel: UILabel!
                                @IBOutlet weak var dateOfBirthLabel: UILabel!
                                @IBOutlet weak var mobileLabel: UILabel!
                                @IBOutlet weak var addressLabel: UILabel!
                                @IBOutlet weak var nameOfCustomerLabel: UILabel!
                                @IBOutlet weak var postalAddressLabel: UILabel!*/
                                self.dateOfBirthLabel.text = jsonRespone["customer_date_of_birth"] as? String
                                self.mobileLabel.text = jsonRespone["customer_mobile"] as? String
                                self.addressLabel.text = jsonRespone["customer_address"] as? String
                                self.nameOfCustomerLabel.text = jsonRespone["customer_name"] as? String
                                self.postalAddressLabel.text = jsonRespone["postal_address"] as? String
                                self.telephoneLabel.text = jsonRespone["customer_telephone"] as? String
                                
                               } catch let parsingError {
                                  print("Error", parsingError)
                             }
                       }
                   }
       }
    

}
