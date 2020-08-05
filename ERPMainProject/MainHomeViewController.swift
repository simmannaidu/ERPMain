//
//  MainHomeViewController.swift
//  CygenERP
//
//  Created by Hari on 18/11/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import CoreCharts
class firstTableViewCell: UITableViewCell {
    @IBOutlet weak var imageOfItems: UIImageView!
       @IBOutlet weak var mainViewInTableView: UIView!
       @IBOutlet weak var nameOfItemLabel: UILabel!
}
class secondTableViewCell: UITableViewCell {
    @IBOutlet weak var viewInCell1: UIView!
    
    @IBOutlet weak var secondViewInTableView: UIView!
}
class topCollectionViewCell : UICollectionViewCell
{
   @IBOutlet weak var imageOfItem: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var mainViewInCell: UIView!
}
class MainHomeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var forPiView: UIView!
    @IBOutlet weak var forChartView: UIView!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var slideMenuView: UIView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var recentBadgeCountView: UIView!
    @IBOutlet weak var outOfStockBadgeCountView: UIView!
    @IBOutlet weak var messageBadgeCountView: UIView!
    @IBOutlet weak var updateApplicationBadgeCountView: UIView!
    @IBOutlet weak var newApplicationBadgeCountView: UIView!
    @IBOutlet weak var mainHomeScrollview1: UIScrollView!
    @IBOutlet weak var forButtonView: UIView!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var secondTableView: UITableView!
    var erpArray = [String]()
       var firstTableViewArray = [String]()
       var setCountLabelArray = [NSInteger]()
    var barChartView = BarChartView()
    var pieChartView = PieChartView()
    var days = [String]()
    //best_sales_products_day,best_customer_datewise_day
    var forProductsSecondTableString = NSString()
    var forCustomerSecondTableString = NSString()
    
    var totalCustomersValue = NSInteger()
    var totalProductsValue = NSInteger()
    var totalSuppliersValue = NSInteger()
    var totalInvoiceValue = NSInteger()
    var todayArray = [NSDictionary]()
    var monthlyArray = [NSDictionary]()
    var weeklyArray = [NSDictionary]()
    var yearlyArray = [NSDictionary]()
    var best_sales_product_Array = [NSDictionary]()
    var weekly_sales_report_Array = [NSDictionary]()
    var yearly_sales_report_Array = [NSDictionary]()
    var monthly_sales_report_Array = [NSDictionary]()

     var secondTableViewData = [NSDictionary]()
     var jsonDic = [String : Any]()
    
     let oneWeekBt = UIButton()
     let oneDayBt = UIButton()
     let fourWeekBt = UIButton()
     let oneYearBt = UIButton()
    var dataForBarChart = [NSDictionary]()
   // var days = [string]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstTableView.delegate = self
        self.firstTableView.dataSource = self
        self.secondTableView.delegate = self
        self.secondTableView.dataSource = self
        self.topCollectionView.delegate = self
        self.topCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        

        
    }
    override func viewWillAppear(_ animated: Bool) {
       forDashBoardData()
    }
    func forDashBoardData()
           {
              let url : URL = URL(string: BaseUrl + "/dashboard")!
                   //"http://infysmart.com/erpapi/api/dashboard")!
                       
               let parameters = ["user_id":USERID,"user_type":USERTYPE]
                       
                       
                       AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
                           print(response.request as Any)  // original URL request
                           print(response.response as Any)// URL response
                           let response1 = response.response
                           if response1?.statusCode == 200
                           {
                                do{
                                   let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                                   print(jsonRespone)
                                    self.jsonDic = jsonRespone

                                    self.setFrameAutoLayout()
                                   self.totalProductsValue = jsonRespone["total_product"] as! NSInteger
                                   self.totalCustomersValue = jsonRespone["total_customer"] as! NSInteger
                                   self.totalSuppliersValue = jsonRespone["total_suppliers"] as! NSInteger
                                   self.totalInvoiceValue = jsonRespone["total_product"] as! NSInteger
                                    
                                    self.setCountLabelArray.removeAll()
                                    self.setCountLabelArray.append(jsonRespone["total_product"] as! NSInteger)
                                     self.setCountLabelArray.append(jsonRespone["total_customer"] as! NSInteger)
                                     self.setCountLabelArray.append(jsonRespone["total_suppliers"] as! NSInteger)
                                     self.setCountLabelArray.append(jsonRespone["total_product"] as! NSInteger)
                                    //weekWiseRevenieMonth
                                    self.monthly_sales_report_Array = jsonRespone["weekWiseRevenieMonth"] as! [NSDictionary]
                                    self.setUpPichart()
                                    self.dataForBarChart = [NSDictionary]()
                                    print("\(self.monthly_sales_report_Array)")
                                    for value in self.monthly_sales_report_Array
                                    {
                                        var valueString = String()
    //                                    guard let valueString = value["amount"]
    //                                    else
    //                                    {
    //                                        return
    //                                    }

                                        if value["amount"] as? String != nil
                                         {
                                            valueString = value["amount"] as! String
                                        }
                                        else
                                        {
                                            valueString = ""
                                        }
                                        let data = ["name":value["day"] as! String , "amount" : valueString] as [String : Any]
                                        self.dataForBarChart.append(data as NSDictionary)
                                    }
                                  //  self.barChartView.dataSource = self
                                    
                                   // self.SetCharts(datapoints: setValuesForBarChart1)
                                   print("self.totalInvoiceValue = \(self.totalInvoiceValue)  self.totalSuppliersValue = \(self.totalSuppliersValue)  self.totalCustomersValue = \(self.totalCustomersValue)  self.totalProductsValue = \(self.totalProductsValue)")
                                   } catch let parsingError {
                                      print("Error", parsingError)
                                 }
                              // let dataFromServer =
                           }
                       }
           }
    //MARK:- Design
    
    func Design(){
        
        self.dropView.layer.shadowColor = UIColor.lightGray
        self.dropView.layer.shadowOpacity = 1
        self.dropView.layer.masksToBounds = false
        self.dropView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.dropView.layer.shadowRadius = 2
        self.dropView.layer.cornerRadius = 4
        
        
        self.outOfStockBadgeCountView.layer.cornerRadius = self.outOfStockBadgeCountView.frame.size.height / 2
        self.outOfStockBadgeCountView.clipsToBounds = true
        self.messageBadgeCountView.layer.cornerRadius = self.messageBadgeCountView.frame.size.height / 2
        self.messageBadgeCountView.clipsToBounds = true
        self.updateApplicationBadgeCountView.layer.cornerRadius = self.updateApplicationBadgeCountView.frame.size.height / 2
        self.updateApplicationBadgeCountView.clipsToBounds = true
        self.newApplicationBadgeCountView.layer.cornerRadius = self.newApplicationBadgeCountView.frame.size.height / 2
        self.newApplicationBadgeCountView.clipsToBounds = true
        self.recentBadgeCountView.layer.cornerRadius = self.recentBadgeCountView.frame.size.height / 2
        self.recentBadgeCountView.clipsToBounds = true
    }
    
//MARK:- TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstTableViewCellId", for: indexPath) as! firstTableViewCell
            return cell
        }
        else{
           let cell = tableView.dequeueReusableCell(withIdentifier: "secondTableViewCell2Id", for: indexPath) as! secondTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
           if tableView.tag == 1
           {
               let view1 = UIView()
               view1.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0)
           return view
           }
           else
           {
               let viewInHeader = UIView()
                   viewInHeader.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60)
               let label = UILabel()
               label.frame = CGRect(x: 15, y: 8, width: self.view.frame.size.width - 30, height: 20)
               //let BottemView = UIView()
               let firstBottemView = UIView()
               let secondBottemView = UIView()
               firstBottemView.frame = CGRect(x: 15, y: 35, width: self.view.frame.size.width - 30, height: 30)
               secondBottemView.frame = CGRect(x: self.view.frame.size.width - 145 , y: 35, width: 131, height: 30)
               firstBottemView.layer.borderWidth = 1
               firstBottemView.layer.borderColor = UIColor.black.cgColor
               secondBottemView.layer.borderWidth = 1
               secondBottemView.layer.borderColor = UIColor.black.cgColor
            
               if(section == 1)
               {
               label.text = "Top 10 Customer's"
                let label1 = UILabel()
                label1.frame = CGRect(x: 0, y: 0, width: firstBottemView.layer.frame.size.width, height:30)
                label1.text = "Customer"
                label1.textAlignment = .center
                firstBottemView.addSubview(label1)
                let label2 = UILabel()
                               label2.frame = CGRect(x: 0, y: 0, width: secondBottemView.layer.frame.size.width, height:30)
                               label2.text = "Total"
                               label2.textAlignment = .center
                               secondBottemView.addSubview(label2)
               }else
               {
                 label.text = "Top 10 Sellable Products"
                let label1 = UILabel()
                               label1.frame = CGRect(x: 0, y: 0, width: firstBottemView.layer.frame.size.width, height:30)
                               label1.text = "Item Name"
                               label1.textAlignment = .center
                               firstBottemView.addSubview(label1)
                               let label2 = UILabel()
                                              label2.frame = CGRect(x: 0, y: 0, width: secondBottemView.layer.frame.size.width, height:30)
                                              label2.text = "Total Sale"
                                              label2.textAlignment = .center
                                              secondBottemView.addSubview(label2)
               }
               label.textColor = custemBlueColor
               viewInHeader.addSubview(firstBottemView)
               viewInHeader.addSubview(secondBottemView)
               viewInHeader.addSubview(label)
               return viewInHeader
               
           }
       }
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           if tableView.tag == 1
           {
           return 0
           }
           else
           {
               return 70
           }
       }
    // MARK: -   COLLECTION VIEW DELEGATE
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCollectionViewCellId", for: indexPath)
        as! topCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width / 2 - 30, height: 110)
    }
    
    
    func setFrameAutoLayout()
        {
            self.erpArray = ["Total Customer","Total Product","Total Supplier","Total Invoice"]
            self.firstTableViewArray = ["Invoice","Customer Receive","Supplier Payment","Purchase"]
            
            self.firstTableView.delegate = self
            self.firstTableView.dataSource = self
            
            self.topCollectionView.delegate = self
            self.topCollectionView.dataSource = self
            self.topCollectionView.reloadData()
            self.topCollectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 220)
            self.firstTableView.frame = CGRect(x:0, y: self.topCollectionView.frame.origin.y + self.topCollectionView.frame.size.height, width: self.view.frame.size.width, height: 300)
            self.forButtonView.frame = CGRect(x:0, y: self.firstTableView.frame.origin.y + self.firstTableView.frame.size.height, width: self.view.frame.size.width, height:60)
            
            self.barChartView.frame = CGRect(x:0, y: self.forButtonView.frame.origin.y + self.forButtonView.frame.size.height, width: self.view.frame.size.width, height:300)
             self.forPiView.frame = CGRect(x:0, y: self.barChartView.frame.origin.y + self.barChartView.frame.size.height, width: self.view.frame.size.width, height:300)

            
        let secondTableData : [NSDictionary] = self.jsonDic["best_customer_datewise_day"] as! [NSDictionary]
        let secondTableData1 : [NSDictionary] = self.jsonDic["best_sales_products_day"] as! [NSDictionary]
            print("secondTableData = \(secondTableData) == secondTableData1 = \(secondTableData1)")
            let heightOfSecondTableView : CGFloat = CGFloat(120 + 50 * (secondTableData.count + secondTableData1.count))
            self.secondTableView.frame = CGRect(x:0.0, y: CGFloat(self.forPiView.frame.origin.y + self.forPiView.frame.size.height), width: CGFloat(self.view.frame.size.width), height:heightOfSecondTableView)
         
            setRevSlaesView2()
            setRevSlaesView()
            
       self.firstTableView.delegate = self
        self.firstTableView.dataSource = self
            
            toSetFrameForButtonView()
          
            
            self.mainHomeScrollview1.contentSize = CGSize(width: self.view.frame.size.width, height: self.secondTableView.frame.origin.y + self.secondTableView.frame.size.height)
            self.mainHomeScrollview1.bounces = false
        }
        
        func toSetFrameForButtonView()
        {
            let oneWeekView = UIView()
            let oneDayView = UIView()
            let fourWeekView = UIView()
            let oneYearView = UIView()
            
            oneDayView.frame = CGRect(x: 12, y: 4, width: 45, height: 45)
            oneWeekView.frame = CGRect(x: oneDayView.frame.origin.x + oneDayView.frame.size.width + 12, y: 4, width: 45, height: 45)
            fourWeekView.frame = CGRect(x: oneWeekView.frame.origin.x + oneWeekView.frame.size.width + 12, y: 4, width: 45, height: 45)
            oneYearView.frame = CGRect(x: 12 + fourWeekView.frame.origin.x + fourWeekView.frame.size.width, y: 4, width: 45, height: 45)
            
           self.oneDayBt.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
                   self.oneWeekBt.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
                   self.fourWeekBt.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
                   self.oneYearBt.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
            
            self.oneDayBt.backgroundColor = UIColor(displayP3Red: 41.0/255, green: 121.0/255, blue: 255.0/255, alpha: 1)
            
            self.oneDayBt.addTarget(self, action: #selector(forOneDayAction), for: .touchUpInside)
            self.oneWeekBt.addTarget(self, action: #selector(forOneWeakAction), for: .touchUpInside)
                self.fourWeekBt.addTarget(self, action: #selector(forFourWeekAction), for: .touchUpInside)
            self.oneYearBt.addTarget(self, action: #selector(forOneYearAction), for: .touchUpInside)
            //self.oneWeekBt.setTitleColor(.white, for: .normal)
            self.forOneDayAction()
            self.oneDayBt.setTitle("1D", for: .normal)
            self.oneWeekBt.setTitle("1W", for: .normal)
            self.fourWeekBt.setTitle("4W", for: .normal)
            self.oneYearBt.setTitle("1Y", for: .normal)
            oneDayView.addSubview(self.oneDayBt)
            oneWeekView.addSubview(self.oneWeekBt)
            fourWeekView.addSubview(self.fourWeekBt)
            oneYearView.addSubview(self.oneYearBt)
            
            oneDayView.layer.cornerRadius = 8
            oneDayView.layer.masksToBounds = false
               oneDayView.layer.shadowColor = UIColor.blue.cgColor
              oneDayView.layer.shadowOpacity = 0.5
               oneDayView.layer.shadowOffset = CGSize(width: 1, height: 1)
              oneDayView.layer.shadowRadius = 1
            
            oneWeekView.layer.cornerRadius = 8
                   oneWeekView.layer.masksToBounds = false
                      oneWeekView.layer.shadowColor = UIColor.blue.cgColor
                     oneWeekView.layer.shadowOpacity = 0.5
                      oneWeekView.layer.shadowOffset = CGSize(width: 1, height: 1)
                     oneWeekView.layer.shadowRadius = 1
            
            fourWeekView.layer.cornerRadius = 8
                   fourWeekView.layer.masksToBounds = false
                      fourWeekView.layer.shadowColor = UIColor.blue.cgColor
                     fourWeekView.layer.shadowOpacity = 0.5
                      fourWeekView.layer.shadowOffset = CGSize(width: 1, height: 1)
                     fourWeekView.layer.shadowRadius = 1
            
            oneYearView.layer.cornerRadius = 8
                   oneYearView.layer.masksToBounds = false
                      oneYearView.layer.shadowColor = UIColor.blue.cgColor
                     oneYearView.layer.shadowOpacity = 0.5
                      oneYearView.layer.shadowOffset = CGSize(width: 1, height: 1)
                     oneYearView.layer.shadowRadius = 1
            
            oneDayView.backgroundColor = .lightText
            oneWeekView.backgroundColor = .lightText
            fourWeekView.backgroundColor = .lightText
            oneYearView.backgroundColor = .lightText
            
            self.forButtonView.addSubview(oneDayView)
            self.forButtonView.addSubview(oneWeekView)
            self.forButtonView.addSubview(fourWeekView)
            self.forButtonView.addSubview(oneYearView)
            
        }
       @objc func forOneWeakAction()
        {//41121255
            self.oneWeekBt.backgroundColor = UIColor(displayP3Red: 41.0/255, green: 121.0/255, blue: 255.0/255, alpha: 1)
            self.oneDayBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
            self.fourWeekBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
            self.oneYearBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
            self.oneWeekBt.setTitleColor(.white, for: .normal)
             self.oneDayBt.setTitleColor(.black, for: .normal)
             self.fourWeekBt.setTitleColor(.black, for: .normal)
             self.oneYearBt.setTitleColor(.black, for: .normal)
            //best_customer_datewise_week
            self.forProductsSecondTableString = "best_sales_products_week"
            self.forCustomerSecondTableString = "best_customer_datewise_week"
             let secondTableData : [NSDictionary] = self.jsonDic[ self.forProductsSecondTableString as String] as! [NSDictionary]
                           let secondTableData1 : [NSDictionary] = self.jsonDic[self.forCustomerSecondTableString as String] as! [NSDictionary]
                          let heightOfSecondTableView : CGFloat = CGFloat(120 + 50 * (secondTableData.count + secondTableData1.count))
                          self.secondTableView.frame = CGRect(x:0.0, y: CGFloat(self.forPiView.frame.origin.y + self.forPiView.frame.size.height), width: CGFloat(self.view.frame.size.width), height:heightOfSecondTableView)
                       
    self.mainHomeScrollview1.contentSize = CGSize(width: self.view.frame.size.width, height:1000)
            self.mainHomeScrollview1.backgroundColor = .red
        //self.mainSecondScrollTableView.frame.origin.y + self.mainSecondScrollTableView.frame.size.height)
           
           // self.oneDayBt.backgroundColor = UIColor(displayP3Red: 41.0/255, green: 121.0/255, blue: 255.0/255, alpha: 1)
        }
        @objc func forOneDayAction()
           {
               self.oneDayBt.backgroundColor = UIColor(displayP3Red: 41.0/255, green: 121.0/255, blue: 255.0/255, alpha: 1)
               self.oneWeekBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
               self.fourWeekBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
               self.oneYearBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
               self.oneDayBt.setTitleColor(.white, for: .normal)
            self.oneWeekBt.setTitleColor(.black, for: .normal)
                    self.fourWeekBt.setTitleColor(.black, for: .normal)
                    self.oneYearBt.setTitleColor(.black, for: .normal)
            self.forProductsSecondTableString = "best_sales_products_day"
            self.forCustomerSecondTableString = "best_customer_datewise_day"
             let secondTableData : [NSDictionary] = self.jsonDic[ self.forProductsSecondTableString as String] as! [NSDictionary]
                           let secondTableData1 : [NSDictionary] = self.jsonDic[self.forCustomerSecondTableString as String] as! [NSDictionary]
                          let heightOfSecondTableView : CGFloat = CGFloat(120 + 50 * (secondTableData.count + secondTableData1.count))
                        //  self.coustmerTableView.frame = CGRect(x:0.0, y: CGFloat(self.revSlaesView2.frame.origin.y + self.revSlaesView2.frame.size.height), width: CGFloat(self.view.frame.size.width), height:heightOfSecondTableView)
    self.mainHomeScrollview1.contentSize = CGSize(width: self.view.frame.size.width, height: self.forPiView.frame.origin.y + self.forPiView.frame.size.height)
                       
           }
        @objc func forOneYearAction()
           {
               self.oneYearBt.backgroundColor = UIColor(displayP3Red: 41.0/255, green: 121.0/255, blue: 255.0/255, alpha: 1)
               self.oneWeekBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
               self.fourWeekBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
               self.oneDayBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
               self.oneYearBt.setTitleColor(.white, for: .normal)
            self.oneDayBt.setTitleColor(.black, for: .normal)
                    self.fourWeekBt.setTitleColor(.black, for: .normal)
                    self.oneWeekBt.setTitleColor(.black, for: .normal)
             self.forProductsSecondTableString = "best_sales_products_year"
            self.forCustomerSecondTableString = "best_customer_datewise_year"
            let secondTableData : [NSDictionary] = self.jsonDic[ self.forProductsSecondTableString as String] as! [NSDictionary]
                    let secondTableData1 : [NSDictionary] = self.jsonDic[self.forCustomerSecondTableString as String] as! [NSDictionary]
                   let heightOfSecondTableView : CGFloat = CGFloat(120 + 50 * (secondTableData.count + secondTableData1.count))
                   self.secondTableView.frame = CGRect(x:0.0, y: CGFloat(self.forPiView.frame.origin.y + self.forPiView.frame.size.height), width: CGFloat(self.view.frame.size.width), height:heightOfSecondTableView)
                self.mainHomeScrollview1.contentSize = CGSize(width: self.view.frame.size.width, height: self.secondTableView.frame.origin.y + self.secondTableView.frame.size.height)
                
           }
        @objc func forFourWeekAction()
           {
               self.fourWeekBt.backgroundColor = UIColor(displayP3Red: 41.0/255, green: 121.0/255, blue: 255.0/255, alpha: 1)
               self.oneWeekBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
               self.oneDayBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)//
               self.oneYearBt.backgroundColor = UIColor(displayP3Red: 250.0/255, green: 250.0/255, blue: 250.0/255, alpha: 1)
                   self.fourWeekBt.setTitleColor(.white, for: .normal)
                     self.oneDayBt.setTitleColor(.black, for: .normal)
                    self.oneWeekBt.setTitleColor(.black, for: .normal)
                    self.oneYearBt.setTitleColor(.black, for: .normal)
            // self.mainScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.revSlaesView2.frame.origin.y + self.revSlaesView2.frame.size.height)
            self.forProductsSecondTableString = "best_sales_products_month"
            self.forCustomerSecondTableString = "best_customer_datewise_month"
             let secondTableData : [NSDictionary] = self.jsonDic[ self.forProductsSecondTableString as String] as! [NSDictionary]
                           let secondTableData1 : [NSDictionary] = self.jsonDic[self.forCustomerSecondTableString as String] as! [NSDictionary]
                          let heightOfSecondTableView : CGFloat = CGFloat(120 + 50 * (secondTableData.count + secondTableData1.count))
                          self.secondTableView.frame = CGRect(x:0.0, y: CGFloat(self.forPiView.frame.origin.y + self.forPiView.frame.size.height), width: CGFloat(self.view.frame.size.width), height:heightOfSecondTableView)
    self.mainHomeScrollview1.contentSize = CGSize(width: self.view.frame.size.width, height: self.secondTableView.frame.origin.y + self.secondTableView.frame.size.height)
                       
           }
        
        func setRevSlaesView()
        {
          let label = UILabel()
            label.text = "Revenue Slaes"
            label.frame = CGRect(x: 10, y: 8, width: 150, height: 20)
            let outerViewForBarChart = UIView()
            outerViewForBarChart.frame = CGRect(x: 4, y: label.frame.origin.y + label.frame.size.height + 10, width: self.view.frame.size.width - 8, height: 250)
            self.barChartView.frame = CGRect(x: 10, y: 10, width: outerViewForBarChart.frame.size.width - 20, height: outerViewForBarChart.frame.size.height - 20)
            outerViewForBarChart.addSubview(self.barChartView)
            self.forChartView.addSubview(outerViewForBarChart)
            self.forChartView.addSubview(label)
            
    //        days = ["Jan", "Feb", "Mar", "Apr", "May"]
    //        let tasks = [20.0, 4.0, 0.0, 3.0, -12.0]
           // SetCharts(datapoints: days , values: tasks)
        }
        
        func setRevSlaesView2()
        {
           let label = UILabel()
           label.text = "Revenue Slaes"
           label.frame = CGRect(x: 10, y: 8, width: 150, height: 20)
           let outerViewForPieChart = UIView()
           outerViewForPieChart.frame = CGRect(x: 4, y: label.frame.origin.y + label.frame.size.height + 10, width: self.view.frame.size.width - 8, height: 250)
           self.pieChartView.frame = CGRect(x: 10, y: 10, width: outerViewForPieChart.frame.size.width - 20, height: outerViewForPieChart.frame.size.height - 20)
           outerViewForPieChart.addSubview(self.pieChartView)
           self.forPiView.addSubview(outerViewForPieChart)
           self.forPiView.addSubview(label)
            
            setUpPichart()
        }
        
        func setUpPichart()
           {
            self.pieChartView.chartDescription?.enabled = false
                       self.pieChartView.drawHoleEnabled = false
                       self.pieChartView.rotationAngle = 0
              //  piView.rotationEnabled = false
               //  piView.isUserInteractionEnabled = false
               
               // piView.legend.enabled = false
               
               var entries : [PieChartDataEntry] = Array()
               entries.append(PieChartDataEntry(value: 50.0, label: ""))
               entries.append(PieChartDataEntry(value: 20.0, label: ""))
               entries.append(PieChartDataEntry(value: 150.0, label: ""))
               entries.append(PieChartDataEntry(value: 30.0, label: ""))
               entries.append(PieChartDataEntry(value: 30.0, label: ""))
               
               
               let dataSet = PieChartDataSet(entries: entries, label: "")
               
               //        let c1 = UIColor.lightGray
               //        let c2 = UIColor.blue
               //        let c3 = UIColor.green
               //        let c4 = UIColor.red
               //        let c5 = UIColor.orange
               let  colorsList = [UIColor(red:14/255 ,green:164/255 ,blue:151/255,alpha:1.0 ),
                                  UIColor(red:28/255 ,green:96/255 ,blue:174/255,alpha:1.0 ),
                                  UIColor(red:114/255 ,green:58/255 ,blue:142/255,alpha:1.0 ),
                                  UIColor(red:250/255 ,green:184/255 ,blue:0/255,alpha:1.0 ),
                                  UIColor(red:117/255 ,green:185/255 ,blue:40/255,alpha:1.0 )]
               dataSet.colors = colorsList
               // dataSet.colors = [c1, c2, c3, c4, c5] as! [NSUIColor]
               dataSet.drawValuesEnabled = false
               
                       self.pieChartView.data = PieChartData(dataSet: dataSet)
               
           }
        
    
    
    // MARK: - barChart
        func SetCharts(datapoints: [String], values : [Double]){
            var dataEntries : [BarChartDataEntry] = []
            for i in 0..<datapoints.count{
                let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
                dataEntries.append(dataEntry)
            }
            
            //        let chartDataset = BarChartDataSet(entries: dataEntries, label: "")
    //        let  chartData = BarChartData()
    //        chartData.addDataSet(chartDataset)
    //        barView.data = chartData
    //        chartDataset.colors = ChartColorTemplates.colorful()
    //        barView.animate(xAxisDuration: 2.0, yAxisDuration : 2.0)
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Units Sold")
           // let chartData = BarChartData(xVals: days, dataSet: chartDataSet)
            let chartData = BarChartData(dataSet: chartDataSet)
            barChartView.data = chartData
            //  chartDataSet.colors = ChartColorTemplates.colorful()
            barChartView.animate(xAxisDuration: 2.0, yAxisDuration : 2.0)
            let  colorsList = [UIColor(red:14/255 ,green:164/255 ,blue:151/255,alpha:1.0 ),
                               UIColor(red:28/255 ,green:96/255 ,blue:174/255,alpha:1.0 ),
                               UIColor(red:114/255 ,green:58/255 ,blue:142/255,alpha:1.0 ),
                               UIColor(red:250/255 ,green:184/255 ,blue:0/255,alpha:1.0 ),
                               UIColor(red:117/255 ,green:185/255 ,blue:40/255,alpha:1.0 )]
            chartDataSet.colors = colorsList
            
    }

    
    
           //MARK :- setBarChart
           func didTouch(entryData: CoreChartEntry) {
               print(entryData.barTitle)
           }
           
           func loadCoreChartData() -> [CoreChartEntry] {
               
               return getTurkeyFamouseCityList(dataInChart: dataForBarChart)
               
           }
           
           
        func getTurkeyFamouseCityList(dataInChart : [NSDictionary])->[CoreChartEntry] {
               var allCityData = [CoreChartEntry]()
            var dateNameArray = [String]()
            var valueArray = [NSInteger]()
            for value in dataInChart
            {
                dateNameArray.append(value["name"] as! String)
                valueArray.append(value["amount"] as! NSInteger)
            }
    //           let cityNames = ["Istanbul","Antalya","Ankara","Trabzon","İzmir"]
    //           let plateNumber = [34,07,06,61,35]
               
               for index in 0..<dateNameArray.count {
                   
                   let newEntry = CoreChartEntry(id: "\(valueArray[index])",
                    barTitle: dateNameArray[index] as String,
                                                 barHeight: Double(valueArray[index]),
                                                 barColor:rainbowColor())
                                                 
                                                
                   allCityData.append(newEntry)
                   
               }
               
               return allCityData
               
           }
    func rainbowColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    // MARK: -   ButtonActiones
    
    @IBAction func newApplicationBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func updateApplicationBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func homeBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func messageBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func outOfStockBtnAction(_ sender: UIButton) {
    }
}
