//
//  SalesHomeScreenVC.swift
//  ERP
//
//  Created by Hari on 02/01/20.
//  Copyright © 2020 Lancius. All rights reserved.
//

import UIKit
import Alamofire
class forSalesHomeScreenSideMenuCell : UITableViewCell
{
    
    @IBOutlet weak var nameOfItem: UILabel!
    @IBOutlet weak var imageOfItem: UIImageView!
}
class SalesHomeCollectionViewCell : UICollectionViewCell
{
    @IBOutlet weak var imageOfItem: UIImageView!
    
    @IBOutlet weak var subNameOfItemLabel: UILabel!
    @IBOutlet weak var nameOfItemLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var cellMainView: UIView!
}
class SalesHomeScreenVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate
, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    var dataForCollectionView = [String]()
    var dataFromServer = [NSInteger]()
   
    @IBOutlet weak var totalCustomerLabel: UILabel!
    @IBOutlet weak var totalCustomerView: UIView!
    @IBOutlet weak var totalProductLabel: UILabel!
    @IBOutlet weak var totalProductsView: UIView!
    @IBOutlet weak var totalSuppliersLabel: UILabel!
    @IBOutlet weak var totalSuppliersView: UIView!
    @IBOutlet weak var totalInvoiceView: UIView!
    @IBOutlet weak var totalInvoiceLabel: UILabel!
    // @IBOutlet weak var selesCollectionView: UICollectionView!
    @IBOutlet weak var transView: UIView!
   // @IBOutlet weak var forSlideTransView: UIView!
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var slideTableView: UITableView!
    @IBOutlet weak var forNetWorkTransView: UIView!
    var slideMenuArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.slideMenuArray =  ["Dashboard","Place Order","Invoice","Quotations","Customer","Manage Message","Message IM","Logout"]
        self.dataForCollectionView = ["Total Customer","Total Product","Total Supplier","Total Invoice"]
        
        self.totalProductsView.layer.cornerRadius = 10
        self.totalCustomerView.layer.cornerRadius = 10
        self.totalInvoiceView.layer.cornerRadius = 10
        self.totalSuppliersView.layer.cornerRadius = 10
        
        //,"Manage MI","Manage Logs"
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideSlideMenu))
        //self.selesCollectionView.delegate = self
        //self.selesCollectionView.dataSource = self
               mytapGestureRecognizer.numberOfTapsRequired = 1
               self.forNetWorkTransView?.addGestureRecognizer(mytapGestureRecognizer)
               if CheckInternet.Connection(){
                   forDashBoardData()
               }else{
                   Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
               }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.hideSlideMenu()
       switch UIDevice.current.userInterfaceIdiom {
       case .phone:
        UIInterfaceOrientationMask.portrait
        break
            // It's an iPhone
        case .pad:
        UIInterfaceOrientationMask.portrait
        break
            // It's an iPad
        case .unspecified:
        break
            // Uh, oh! What could it be?
       case .tv:
        break
       case .carPlay:
        break
       @unknown default:
        break
        }
    }
    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait ]
           }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.slideMenuArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forSalesHomeScreenSideMenuCellId", for: indexPath) as! forSalesHomeScreenSideMenuCell
        cell.nameOfItem.text = self.slideMenuArray[indexPath.row]
        cell.imageOfItem.image = UIImage(named: self.slideMenuArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.hideSlideMenu()
        }
        else if indexPath.row == 1 {
        self.gotoCatgaryScreen()
          }
        else if indexPath.row == 2 {
            self.gotoInvoiceScreen()
        }
        else if indexPath.row == 3 {
           self.gotoQuotationsScreen()
        }
        else if indexPath.row == 4 {
           self.gotoCustomerScreen()
        }
        else if indexPath.row == 5 {
          self.gotoManageMessageScreen()
        }
        else if indexPath.row == 6 {
            self.gotoManageMIScreen()
           //self.goToLoginScreenScreen()
        }
        else if indexPath.row == 7 {
               self.goToLoginScreenScreen()
            }
        else
        {
            self.goToLoginScreenScreen()
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataFromServer.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SalesHomeCollectionViewCellId", for: indexPath) as! SalesHomeCollectionViewCell
        if indexPath.row < 4
        {

            cell.imageOfItem.image = UIImage(named: self.dataForCollectionView[indexPath.row])
       // cell.imageOfItem.image = UIImage(named: self.dataForCollectionView[indexPath.row] )
             cell.nameOfItemLabel.text = self.dataForCollectionView[indexPath.row]
            cell.subNameOfItemLabel.text = self.dataForCollectionView[indexPath.row]
        }
     if indexPath.row == 0 {
         cell.cellMainView.backgroundColor = UIColor(displayP3Red: 14.0/255, green: 164.0/255, blue: 151.0/255, alpha: 1)
     }
     else if indexPath.row == 1 {
         cell.cellMainView.backgroundColor = UIColor(displayP3Red: 28.0/255, green: 96.0/255, blue: 174.0/255, alpha: 1)
     }
     else if indexPath.row == 2 {
         cell.cellMainView.backgroundColor = UIColor(displayP3Red: 144.0/255, green: 58.0/255, blue: 142.0/255, alpha: 1)
     }
     else
     {
         cell.cellMainView.backgroundColor = UIColor(displayP3Red: 117.0/255, green: 185.0/255, blue: 40.0/255, alpha: 1)
     }
       
       
       cell.imageOfItem.frame = CGRect(x: 15, y: 10, width: 30, height: 30)
      
       cell.countLabel.frame = CGRect(x: 40, y: 10, width: self.view.frame.size.width / 2 - 55 , height: 30)
       
        cell.nameOfItemLabel.frame = CGRect(x: 5, y: 45, width: self.view.frame.size.width / 2 - 30 , height: 40)
        if self.dataFromServer[indexPath.row] > 0
        {
           cell.nameOfItemLabel = self.setLabelCount(label: cell.countLabel , value: self.dataFromServer[indexPath.row])
        }
        else
        {
            cell.nameOfItemLabel.text = "0"
        }
        
     cell.cellMainView.layer.cornerRadius = 8
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 2, height: 150)
    }
    func gotoInvoiceScreen()
    {
     let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecentInvoiceViewControllerId") as? RecentInvoiceViewController
     self.navigationController?.pushViewController(vc!, animated: true)
    }
    func gotoCatgaryScreen()
    {
    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerManageCategoryViewControllerId") as? CustomerManageCategoryViewController
    
    self.navigationController?.pushViewController(vc!, animated: true)
    }
    func gotoQuotationsScreen()
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
               vc?.slidemenuSubListArray = ["New Quotations","Manage Quotations"]
               vc?.sublistTitelName = "Quotations"
               self.navigationController?.pushViewController(vc!, animated: true)
    }
//    func gotoQuotationsScreen()
//       {
//           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageQuotationViewControllerId") as? ManageQuotationViewController
//
//           self.navigationController?.pushViewController(vc!, animated: true)
//       }
    func gotoCustomerScreen()
       {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
           vc?.slidemenuSubListArray = ["Manage customer","Manage Customer Update","Manage Active Customer","Manage Inactive Customer", "Credit Customer" , "Paid Customer"]
            //, "Credit Customer" , "Paid Customer"
           vc?.sublistTitelName = "Customer"
           self.navigationController?.pushViewController(vc!, animated: true)
       }
    func gotoManageMessageScreen()
       {
           let vc = UIStoryboard.init(name: "sales", bundle: Bundle.main).instantiateViewController(withIdentifier: "SalesManageMessageVCId") as? SalesManageMessageVC
        
           self.navigationController?.pushViewController(vc!, animated: true)
       }
    func gotoManageMIScreen()
       {
          let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
           vc?.slidemenuSubListArray = ["Message IM Inbox" , "Message IM Outbox", "Send IM Message"]
        //
           vc?.sublistTitelName = "Manage IM"
           self.navigationController?.pushViewController(vc!, animated: true)
       }
    func gotoManageLogsScreen()
       {
           
       }
    func goToLoginScreenScreen()
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewControllerId") as? LoginViewController
      
              self.navigationController?.pushViewController(vc!, animated: true)
    }
    func goToSupply()
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageSupplierViewControllerId") as? ManageSupplierViewController
      
              self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func hideSlideMenu()
      {
          var frame : CGRect
          frame = self.slideView.frame
          UIView.animate(withDuration: 1, animations: {
              self.slideView.frame.origin.x = -frame.size.width
              self.forNetWorkTransView.isHidden = true
              self.slideView.isHidden = true
          }) { _ in
              
          }
          
      }
    @IBAction func forMenuBtAction(_ sender: UIButton) {
        self.forNetWorkTransView.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            self.slideView.frame.origin.x = 0
            self.slideView.isHidden = false
        }) { _ in
            
        }
    }
    
    @IBAction func invoiceAction(_ sender: Any) {
        self.gotoInvoiceScreen()
    }
    func forDashBoardData()
           {
            self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
               let url : URL = URL(string: BaseUrl + "/dashboard")!
             let parameter = ["user_type":USERTYPE , "saler_id" : USERID]
            print(parameter)
                AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                           print(response.request as Any)  // original URL request
                           print(response.response as Any)// URL response
                           let response1 = response.response
                        DispatchQueue.main.async {
      self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                           if response1?.statusCode == 200
                           {
                                do{
                                   let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                                    
                                   print(jsonRespone)
                                   // self.jsonDic = jsonRespone
                                    self.dataFromServer.removeAll()
                                   
                                   
                                    //self.setCountLabelArray.append(totalCust.integerValue)
                                    self.dataFromServer.append(jsonRespone["total_product"] as! NSInteger)
                                    self.dataFromServer.append(jsonRespone["total_suppliers"] as! NSInteger)
                                    self.dataFromServer.append(jsonRespone["total_sales"] as! NSInteger)
                                    
//                                    if self.dataFromServer[indexPath.row] > 0
//                                           {
//
//                                           }
//                                           else
//                                           {
//
//                                           }
                                    if let count = jsonRespone["total_sales"]
                                    {
                                     self.totalInvoiceLabel = self.setLabelCount(label: self.totalInvoiceLabel, value: count as! NSInteger)
                                    }
                                    else
                                    {
                                        self.totalInvoiceLabel.text = "0"
                                        //= self.setLabelCount(label: self.totalInvoiceLabel, value: jsonRespone["total_sales"] as! NSInteger)
                                    }
                                    
                                    if let total_product = jsonRespone["total_product"]
                                    {
                                      self.totalProductLabel = self.setLabelCount(label: self.totalProductLabel, value: total_product as! NSInteger)
                                    }
                                    else
                                    {
                                        self.totalProductLabel.text = "0"
                                        //= self.setLabelCount(label: self.totalProductLabel, value: jsonRespone["total_product"] as! NSInteger)
                                    }
                                    
                                    if let total_suppliers = jsonRespone["total_suppliers"]
                                    {
                                        self.totalSuppliersLabel = self.setLabelCount(label: self.totalSuppliersLabel, value:total_suppliers as! NSInteger)
                                    }
                                    else
                                    {
                                        self.totalSuppliersLabel.text = "0"
                                        //= self.setLabelCount(label: self.totalSuppliersLabel, value: jsonRespone["total_suppliers"] as! NSInteger)
                                    }
                                    
                                    let totalCust = jsonRespone["total_customer"] as! NSString
                                                    //self.totalCustomersValue = totalCust.integerValue
                                    if totalCust != "0" || totalCust.length != 0
                                        
                                    {
                                       self.totalCustomerLabel = self.setLabelCount(label: self.totalCustomerLabel, value: totalCust.integerValue)
                                    }
                                    else
                                    {
                                        self.totalCustomerLabel.text = "0"
                                            //self.setLabelCount(label: self.totalCustomerLabel, value: totalCust.integerValue)
                                    }
                                    self.dataFromServer.append(totalCust.integerValue)
                                    
                                   // self.selesCollectionView.reloadData()
/*self.setCountLabelArray.append(jsonRespone["total_customer"] as! NSInteger)
self.setCountLabelArray.append(jsonRespone["total_product"] as! NSInteger)
 self.setCountLabelArray.append(jsonRespone["total_suppliers"] as! NSInteger)
 self.setCountLabelArray.append(jsonRespone["total_sales"] as! NSInteger)*/
                                    
//                                   print("self.totalInvoiceValue = \(self.setCountLabelArray[3])  self.totalSuppliersValue = \(self.setCountLabelArray[2])  self.totalCustomersValue = \(self.setCountLabelArray[1])  self.totalProductsValue = \(self.setCountLabelArray[0])")
//                                    self.totalProductsPopLabel.text = "\(self.setCountLabelArray[1])"
//                                    self.totalInvoicePopLabel.text = "\(self.setCountLabelArray[3])"
//                                    self.totalSupplerPopLabel.text = "\(self.setCountLabelArray[2])"
//                                    self.totalCustomerPopLabel.text = "\(self.setCountLabelArray[0])"
                                    
                                    
                                    
                                    
//                                    self.getNotification()
    //                                self.days = ["Jan", "Feb", "Mar", "Apr", "May"]
    //                                        let tasks = [120.0, 4.0, 0.0, 3.0, -112.0]
    //                                self.SetCharts(datapoints: self.days , values: tasks)
                                   } catch let parsingError {
                                      print("Error", parsingError)
                                 }
                              // let dataFromServer =
                           }
                       }
            }
           }
    func setLabelCount(label : UILabel , value : NSInteger) -> UILabel
    {
        let duration: Double = 3.0 //seconds
               DispatchQueue.global().async {
                   for i in 0 ..< (value + 1) {
                    if value != 0
                    {
                       let sleepTime = UInt64(duration/Double(value) * 1000000.0)
                    usleep(useconds_t(sleepTime))
                    }
                       DispatchQueue.main.async {
                           label.text = "\(i)"
                       }
                   }
               }
        return label
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func totalSupplyAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageSupplierViewControllerId") as? ManageSupplierViewController
             
             self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func totalProductsAction(_ sender: UIButton) {
        self.gotoCatgaryScreen()
    }
    @IBAction func totalCustomerAction(_ sender: UIButton) {
        self.gotoCustomerScreen()
    }
    @IBAction func goToProductBTAction(_ sender: Any) {
      //  self.gotoCustomerScreen()
         self.gotoCatgaryScreen()
    }
    @IBAction func totalInvoiceAction(_ sender: UIButton) {
        self.gotoInvoiceScreen()
    }
}
