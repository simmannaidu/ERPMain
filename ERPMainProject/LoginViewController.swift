//
//  LoginViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/14/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
//http://lanciusit.com/demo/erpapi/api/purchaseList/1
//https://ayersfood.com/erpapi/api/checkout_quotation
let BaseUrl = "http://cygenerp.com/erpapi/api"
//"http://lanciusit.com/demo_erp/erpapi/api"
//https://ayersfood.com/erpapi/api"
let bouderColor = UIColor(displayP3Red: 28.0/255, green: 96.0/255, blue: 174.0/255, alpha: 1)
 //dashboard
var USERID = String()
var USERTYPE = String()
var USEREMAIL = String()
var USERNAME = String()

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordview: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var forgotPasswordPopUpView: UIView!
    @IBOutlet weak var forgotPasswordEmailView: UIView!
    @IBOutlet weak var forgotPasswordEmailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transView.isHidden = true
        self.forgotPasswordPopUpView.isHidden = true
       self.userNameTF.text = "divyaadmin@gmail.com"
        self.passwordTF.text = "123456"
        self.Design()
         self.fontsAndColors()
        if #available(iOS 13, *) {
            self.userNameTF.overrideUserInterfaceStyle = .light
            self.passwordTF.overrideUserInterfaceStyle = .light
            self.view.overrideUserInterfaceStyle = .light
            // use UICollectionViewCompositionalLayout
        } else {
            // show sad face emoji
        }

//        if (@available(iOS 13.0,*))
//        {
//            self.companyNameTF.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//             self.designationTF.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//             self.descriptionTF.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//             self.firldOfStudyTF.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//             self.yourCollegeNameTF.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//             self.yourYearOfPassTf.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//            self.officeContactNuberTF.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//
//        }
    }
    
    // MARK: - colors And Fonts
    func fontsAndColors(){
   
        self.userNameTF.setSizeFont(font: "Helvetica Neue", sizeFont: 17.0)
        self.passwordTF.setSizeFont(font: "Helvetica Neue", sizeFont: 17.0)
        
    }
    
    func forLoging()
    {
      //  import Foundation

        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "\n{\n\"username\":\"divyaadmin@gmail.com\",\n\"password\":\"123456\"\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://cygenerp.com/erpapi/api/signIn")!,timeoutInterval: Double.infinity)
        request.addValue("81dc9bdb52d04dc20036dbd8313ed055", forHTTPHeaderField: "x-api-key")
        request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.addValue("PHPSESSID=5cc9d9cf0646c689c08c1f1e6233082a8f009add", forHTTPHeaderField: "Cookie")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
             
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)

              let httpResponse = response as! HTTPURLResponse
              let statusCode = httpResponse.statusCode

              if(statusCode == 200)
              {
                
                  do {
                  //  DispatchQueue.main.async {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    let item = jsonResponse as! NSDictionary
                                                USERID = item["user_id"] as! String
                                                USERTYPE = item["user_type"] as! String
                                                USERNAME = item["user_name"] as! String
                                                USEREMAIL = item["user_email"] as! String
                      print(jsonResponse as! NSDictionary)
//                    print(jsonRespone)
                                                //let item = jsonResponse as! NSDictionary
                                                USERID = item["user_id"] as! String
                                                USERTYPE = item["user_type"] as! String
                                                USERNAME = item["user_name"] as! String
                                                USEREMAIL = item["user_email"] as! String
                     DispatchQueue.main.async {
                                                if USERTYPE == "2"
                                                {
                                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainScrollViewControllerId") as? MainScrollViewController
                    //                                                               self.navigationController?.pushViewController(vc!, animated: true)
                            //let vc = self.storyboard?.instantiateViewController(identifier: "MainScrollViewControllerId") as? MainScrollViewController
                                                //let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainScrollViewControllerId") as? MainScrollViewController
                                                    self.navigationController!.pushViewController(vc!, animated: true)
                                               }
                                                else if USERTYPE == "1"
                                                {
                                                   let vc = UIStoryboard.init(name: "sales", bundle:Bundle.main).instantiateViewController(withIdentifier: "SalesHomeScreenVCId") as? SalesHomeScreenVC
                                                    self.navigationController!.pushViewController(vc!, animated: true)
                    
                                                }else{
                    
                                                let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "CustomerHomeViewControllerId") as? CustomerHomeViewController
                                                self.navigationController!.pushViewController(vc!, animated: true)
                                                }
                    }
                                                UserDefaults.standard.set(jsonResponse, forKey: "USERDETAILS")
                                                } catch let parsingError {
                                                   print("Error", parsingError)
                                        }
//                                                if USERTYPE == "1"
//                                                {
//                                                   // DispatchQueue.main.async {
//                                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CashBookViewControllerId") as? CashBookViewController
//                     self.navigationController!.pushViewController(vc!, animated: true)
//
//                    //}
//
//                  }
//
            
          semaphore.signal()
        }
        }
        
        task.resume()
        semaphore.wait()
        
//        showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
//        let url : URL = URL(string: BaseUrl + "/signIn")!
//       // let headerHeader = HTTPHeader(name: "X-API-KEY", value: "81dc9bdb52d04dc20036dbd8313ed055")
//            let headerData = ["username":self.userNameTF.text,"password":self.passwordTF.text]
//        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
//
//                AF.request(url, method: .post, parameters: headerData, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
//                    DispatchQueue.main.async {
//                        self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
//                    print(response.request as Any)  // original URL request
//                    print(response.response as Any)// URL response
//                    let response1 = response.response
//                    if response1?.statusCode == 200
//                    {
//                         do{
//                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: [])
//                            print(jsonRespone)
//                            let item = jsonRespone as! NSDictionary
//                            USERID = item["user_id"] as! String
//                            USERTYPE = item["user_type"] as! String
//                            USERNAME = item["user_name"] as! String
//                            USEREMAIL = item["user_email"] as! String
//                            if USERTYPE == "1"
//                            {
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainScrollViewControllerId") as? MainScrollViewController
////                                                               self.navigationController?.pushViewController(vc!, animated: true)
//        //let vc = self.storyboard?.instantiateViewController(identifier: "MainScrollViewControllerId") as? MainScrollViewController
//                            //let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainScrollViewControllerId") as? MainScrollViewController
//                                self.navigationController!.pushViewController(vc!, animated: true)
//                           }
//                            else if USERTYPE == "2"
//                            {
//                               let vc = UIStoryboard.init(name: "sales", bundle:Bundle.main).instantiateViewController(withIdentifier: "SalesHomeScreenVCId") as? SalesHomeScreenVC
//                                self.navigationController!.pushViewController(vc!, animated: true)
//
//                            }else{
//
//                            let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "CustomerHomeViewControllerId") as? CustomerHomeViewController
//                            self.navigationController!.pushViewController(vc!, animated: true)
//                            }
//
//                            UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
//                            } catch let parsingError {
//                               print("Error", parsingError)
//                    }
//                    }
//                        else if response1?.statusCode == 400
//                        {
//                        do{
//                        let jsonRespone12 = try JSONSerialization.jsonObject(with: response.data!, options: [])
//                        //print(jsonRespone)
//                            let item = jsonRespone12 as! NSDictionary
//                            Alert.showBasic(titte: "Sorry", massage: item["errorMessage"]
//                                as! String, vc: self)
//                            } catch let parsingError {
//                                                          print("Error", parsingError)
//                            }
//                        }
//                        else
//                         {
//                            Alert.showBasic(titte: "Sorry", massage: "Please try again", vc: self)
//                        }
//                        }
//                }
    }
    // MARK: - Design
    func Design()
    {
        self.userNameView.layer.borderWidth = 1
         self.userNameView.layer.borderColor = UIColor.customBlue
         self.userNameView.layer.cornerRadius = 8
        
        self.passwordview.layer.borderWidth = 1
        self.passwordview.layer.borderColor = UIColor.customBlue
        self.passwordview.layer.cornerRadius = 8
        
        self.forgotPasswordEmailView.layer.borderWidth = 1
        self.forgotPasswordEmailView.layer.borderColor = UIColor.customBlue
        self.forgotPasswordEmailView.layer.cornerRadius = 8
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func loginBtnAction(_ sender: UIButton) {
        let messageSuccess = Validation()
        if messageSuccess == "" {
            if CheckInternet.Connection(){
                forLoging()
            }else{
                Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
            }
        }
        else
        {
            Alert.showBasic(titte: "Alert", massage: messageSuccess, vc: self)
        }
        
    }
    @IBAction func forgotPasswordBtnAction(_ sender: UIButton) {
        
        self.transView.isHidden = false
        self.forgotPasswordPopUpView.isHidden = false
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewControllerId") as? SignUpViewController
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func popUpCloseBtnAction(_ sender: UIButton) {
        self.transView.isHidden = true
        self.forgotPasswordPopUpView.isHidden = true
    }
    
    @IBAction func forgotPasswordSubmitBtnAction(_ sender: UIButton) {
        self.transView.isHidden = true
        self.forgotPasswordPopUpView.isHidden = true
    }
    
   
    // MARK: - Network
    // MARK: - Validation
    func Validation() -> String {
           var successMessage = ""
        if userNameTF.text?.count == 0
               {
                   successMessage = "Please Enter User Name"
                   return successMessage
               }
        if passwordTF.text?.count == 0
        {
            successMessage = "Please Enter Password"
            return successMessage
        }
            return successMessage
    }
}

