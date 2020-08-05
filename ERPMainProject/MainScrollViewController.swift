//
//  MainScrollViewController.swift
//  CygenERP
//
//  Created by Hari on 14/11/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import CoreCharts
let custemBlueColor = UIColor(displayP3Red: 28.0/255, green: 96.0/255, blue: 174.0/255, alpha: 1)
class homeCollectionViewwCell1 : UICollectionViewCell
{
    @IBOutlet weak var mainViewInCollectionView: UIView!
    @IBOutlet weak var nameOfItemLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var imageOfItem: UIImageView!
}
class homeTableViewCell1 : UITableViewCell
{
    @IBOutlet weak var imageOfItems: UIImageView!
    @IBOutlet weak var mainViewInTableView: UIView!
    @IBOutlet weak var nameOfItemLabel: UILabel!
}
class cellInMainScrollTableViewCell : UITableViewCell
{
   // @IBOutlet weak var viewInCell1: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var firstViewInCell: UIView!
    @IBOutlet weak var nameOfProductLabel: UILabel!
    
    @IBOutlet weak var secondViewInCell: UIView!
    //@IBOutlet weak var secondViewInTableView: UIView!
}

class SlideTableViewCell : UITableViewCell
{
    
    @IBOutlet weak var nameInSlide: UILabel!
    
    @IBOutlet weak var imageInSlide: UIImageView!
}



class MainScrollViewController: UIViewController, UICollectionViewDelegate
, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource , UIScrollViewDelegate{
    @IBOutlet weak var forSlideMenuTransView: UIView!
    
    @IBOutlet weak var userMailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var recentInvoiceBadgeCountLabel: UILabel!
    @IBOutlet weak var outOfStockBadgeCountLabel: UILabel!
    @IBOutlet weak var messageBadgeCountLabel: UILabel!
    @IBOutlet weak var updateApplicationBadgeLabel: UILabel!
    @IBOutlet weak var newApplicationBadgeLabel: UILabel!
    @IBOutlet weak var forCenterButtonView: UIView!
    @IBOutlet weak var slideTableView: UITableView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var mainTypeCollectionView: UICollectionView!
    @IBOutlet weak var revSlaesView2: UIView!
    
    @IBOutlet weak var mainSecondScrollTableView: UITableView!
    @IBOutlet weak var revSlaesView: UIView!
    @IBOutlet weak var forButtonView: UIView!
    
    
    @IBOutlet weak var recentInvoiceBadgeCountView: UIView!
    @IBOutlet weak var dropDowenView: UIView!
    @IBOutlet weak var newApplicationBadgeCountView: UIView!
    @IBOutlet weak var updateApplicationBadgeCountView: UIView!
    @IBOutlet weak var messageBadgeCountView: UIView!
    @IBOutlet weak var outOfStockBadgeCountView: UIView!
    
    @IBOutlet weak var totalSupplerPopLabel: UILabel!
    @IBOutlet weak var totalInvoicePopLabel: UILabel!
    @IBOutlet weak var totalProductsPopLabel: UILabel!
    @IBOutlet weak var totalCustomerPopLabel: UILabel!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var slideMenuView: UIView!
    var slideMenuArray = [String]()
    var erpArray = [String]()
    var firstTableViewArray = [String]()
    var setCountLabelArray = [NSInteger]()
    var barChartView = BarChartView()
    var pieChartView = PieChartView()
    var days = [String]()
    var forProductsSecondTableString = NSString()
    var forCustomerSecondTableString = NSString()
    
    var totalCustomersValue = NSInteger()
    var totalProductsValue = NSInteger()
    var totalSuppliersValue = NSInteger()
    var totalInvoiceValue = NSInteger()
     var jsonDic = [String : Any]()
     let oneWeekBt = UIButton()
     let oneDayBt = UIButton()
     let fourWeekBt = UIButton()
     let oneYearBt = UIButton()
    let noRecordsLabelForSales1 = UILabel()
    let noRecordsLabelForSales2 = UILabel()
    
    var monthly_sales_report_Array = [NSDictionary]()
    var dataForBarChart = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.slideMenuArray =  ["Dashboard","Invoice","Quotations","Accounts","Category","Product","Customer","Unit","Supplier","Purchase","Return","Tax","Stock","Report","Manage Message","Software Settings","Role Permission","CMR", "Manage Customer Product Price","Logout"]
         Design()
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideSlideMenu))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.forSlideMenuTransView?.addGestureRecognizer(mytapGestureRecognizer)
       
        self.forCenterButtonView.layer.cornerRadius = 20
        self.forCenterButtonView.clipsToBounds = true
        self.userNameLabel.text = USERNAME
        self.userMailLabel.text = USEREMAIL
        //self.slideMenuTableView.tableFooterView =  UIView(frame: .zero)
        //self.mainScrollView.backgroundColor = .red
        //self.view1.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
        //self.view1.backgroundColor = .black
     //   self.mainScrollView.addSubview(self.view1)
        // Do any additional setup after loading the view.
    }
    @objc func hideSlideMenu()
    {
        var frame : CGRect
        frame = self.slideMenuView.frame
        UIView.animate(withDuration: 1, animations: {
            self.slideMenuView.frame.origin.x = -frame.size.width
            self.forSlideMenuTransView.isHidden = true
            self.slideMenuView.isHidden = true
        }) { _ in
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.noRecordsLabelForSales2.text = "No Records Found"
        self.noRecordsLabelForSales1.text = "No Records Found"
        self.noRecordsLabelForSales2.textColor = .black
        self.noRecordsLabelForSales1.textColor = .black
        self.noRecordsLabelForSales2.textAlignment = .center
        self.noRecordsLabelForSales1.textAlignment = .center
        let tableviewBackgroundView = UIView()
        tableviewBackgroundView.backgroundColor = .white
        self.firstTableView.backgroundView = tableviewBackgroundView
        self.mainSecondScrollTableView.backgroundView = tableviewBackgroundView
        self.firstTableView.tableFooterView = tableviewBackgroundView
        self.mainSecondScrollTableView.tableFooterView = tableviewBackgroundView
        self.mainScrollView.isHidden = false
        self.mainScrollView.backgroundColor = .red
        if CheckInternet.Connection(){
                   forDashBoardData()
               }else{
                   Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
               }
        
    }
    
    
    //MARK:- Design
       
       func Design(){
           
           self.dropDowenView.layer.shadowColor = UIColor.lightGray
           self.dropDowenView.layer.shadowOpacity = 1
           self.dropDowenView.layer.masksToBounds = false
           self.dropDowenView.layer.shadowOffset = CGSize(width: 1, height: 1)
           self.dropDowenView.layer.shadowRadius = 2
           self.dropDowenView.layer.cornerRadius = 4
           
           
           self.outOfStockBadgeCountView.layer.cornerRadius = self.outOfStockBadgeCountView.frame.size.height / 2
           self.outOfStockBadgeCountView.clipsToBounds = true
           self.messageBadgeCountView.layer.cornerRadius = self.messageBadgeCountView.frame.size.height / 2
           self.messageBadgeCountView.clipsToBounds = true
           self.updateApplicationBadgeCountView.layer.cornerRadius = self.updateApplicationBadgeCountView.frame.size.height / 2
           self.updateApplicationBadgeCountView.clipsToBounds = true
           self.newApplicationBadgeCountView.layer.cornerRadius = self.newApplicationBadgeCountView.frame.size.height / 2
           self.newApplicationBadgeCountView.clipsToBounds = true
           self.recentInvoiceBadgeCountView.layer.cornerRadius = self.recentInvoiceBadgeCountView.frame.size.height / 2
           self.recentInvoiceBadgeCountView.clipsToBounds = true
       }
    
    
    
    func setFrameAutoLayout()
    {
        self.erpArray = ["Total Customer","Total Product","Total Supplier","Total Invoice"]
        self.firstTableViewArray = ["Invoice","Supplier Payment"]
        self.forProductsSecondTableString = "best_sales_products_day"
        self.forCustomerSecondTableString = "best_customer_datewise_day"
        self.firstTableView.delegate = self
        self.firstTableView.dataSource = self
        self.mainScrollView.delegate = self
        self.mainTypeCollectionView.delegate = self
        self.mainTypeCollectionView.dataSource = self
        self.mainTypeCollectionView.reloadData()
        self.mainTypeCollectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 220)
        self.firstTableView.frame = CGRect(x:0, y: self.mainTypeCollectionView.frame.origin.y + self.mainTypeCollectionView.frame.size.height, width: self.view.frame.size.width, height: 0)
        self.forButtonView.frame = CGRect(x:0, y: self.firstTableView.frame.origin.y + self.firstTableView.frame.size.height + 20, width: self.view.frame.size.width, height:60)
        
        self.revSlaesView.frame = CGRect(x:0, y: self.forButtonView.frame.origin.y + self.forButtonView.frame.size.height + 10, width: self.view.frame.size.width, height:300)
         self.revSlaesView2.frame = CGRect(x:0, y: self.revSlaesView.frame.origin.y + self.revSlaesView.frame.size.height + 10, width: self.view.frame.size.width, height:300)

        
let secondTableData : [NSDictionary] = self.jsonDic["best_customer_datewise_day"] as! [NSDictionary]
    let secondTableData1 : [NSDictionary] = self.jsonDic["best_sales_products_day"] as! [NSDictionary]
        print("secondTableData = \(secondTableData) == secondTableData1 = \(secondTableData1)")
        let heightOfSecondTableView : CGFloat = CGFloat(250 + 56 * (secondTableData.count + secondTableData1.count))
        self.mainSecondScrollTableView.frame = CGRect(x:0.0, y: CGFloat(self.revSlaesView2.frame.origin.y + self.revSlaesView2.frame.size.height), width: CGFloat(self.view.frame.size.width), height:heightOfSecondTableView)
     
        setRevSlaesView2()
setRevSlaesView()
        
   self.mainSecondScrollTableView.delegate = self
    self.mainSecondScrollTableView.dataSource = self
        
        toSetFrameForButtonView()
      
        
        self.mainScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.mainSecondScrollTableView.frame.origin.y + self.mainSecondScrollTableView.frame.size.height + 50)
        self.mainScrollView.bounces = false
        self.mainScrollView.isHidden = false
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
                      let heightOfSecondTableView : CGFloat = CGFloat(190 + 56 * (secondTableData.count + secondTableData1.count))
                      self.mainSecondScrollTableView.frame = CGRect(x:0.0, y: CGFloat(self.revSlaesView2.frame.origin.y + self.revSlaesView2.frame.size.height), width: CGFloat(self.view.frame.size.width), height:heightOfSecondTableView)
                   
        self.mainScrollView.contentSize = CGSize(width: self.view.frame.size.width, height:self.mainSecondScrollTableView.frame.size.height + self.mainSecondScrollTableView.frame.origin.y + 50 )
     //   self.mainScrollView.backgroundColor = .red
        self.mainSecondScrollTableView.reloadData()
        self.setDataForBarChatBasedOnButtons(parameter: "reveniewWeek")
        self.setUpPichart(paramater :"reveniewWeek")
        
        
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
                      let heightOfSecondTableView : CGFloat = CGFloat(190 + 56 * (secondTableData.count + secondTableData1.count))
                      self.mainSecondScrollTableView.frame = CGRect(x:0.0, y: CGFloat(self.revSlaesView2.frame.origin.y + self.revSlaesView2.frame.size.height), width: CGFloat(self.view.frame.size.width), height:heightOfSecondTableView)
self.mainScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.mainSecondScrollTableView.frame.origin.y + self.mainSecondScrollTableView.frame.size.height + 50)
        self.mainSecondScrollTableView.reloadData()
        self.setDataForBarChatBasedOnButtons(parameter: "reveniewToday")
        self.setUpPichart(paramater :"reveniewToday")
            
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
               let heightOfSecondTableView : CGFloat = CGFloat(190 + 56 * (secondTableData.count + secondTableData1.count))
               self.mainSecondScrollTableView.frame = CGRect(x:0.0, y: CGFloat(self.revSlaesView2.frame.origin.y + self.revSlaesView2.frame.size.height), width: CGFloat(self.view.frame.size.width), height:heightOfSecondTableView)
            self.mainScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.mainSecondScrollTableView.frame.origin.y + self.mainSecondScrollTableView.frame.size.height + 50)
        self.mainSecondScrollTableView.reloadData()
        self.setDataForBarChatBasedOnButtons(parameter: "reveniewYear")
        self.setUpPichart(paramater :"reveniewYear")
            
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
                      let heightOfSecondTableView : CGFloat = CGFloat(190 + 56 * (secondTableData.count + secondTableData1.count))
                      self.mainSecondScrollTableView.frame = CGRect(x:0.0, y: CGFloat(self.revSlaesView2.frame.origin.y + self.revSlaesView2.frame.size.height), width: CGFloat(self.view.frame.size.width), height:heightOfSecondTableView)
self.mainScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.mainSecondScrollTableView.frame.origin.y + self.mainSecondScrollTableView.frame.size.height + 50)
        self.mainSecondScrollTableView.reloadData()
        self.setDataForBarChatBasedOnButtons(parameter: "weekWiseRevenieMonth")
        self.setUpPichart(paramater :"weekWiseRevenieMonth")
                   
       }
    func setDataForBarChatBasedOnButtons(parameter : String)
    {
        self.monthly_sales_report_Array.removeAll()
        self.dataForBarChart.removeAll()
        self.monthly_sales_report_Array = self.jsonDic[parameter] as! [NSDictionary]
            //jsonRespone["weekWiseRevenieMonth"] as! [NSDictionary]

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
                                                valueString = "0"
                                            }
                                            //month
                                            let data = ["amount" : valueString] as [String : Any]
                                            self.dataForBarChart.append(data as NSDictionary)
                                        }
                                        self.getTurkeyFamouseCityList(dataInChart: self.dataForBarChart)
    }
    func setRevSlaesView()
    {
      let label = UILabel()
        label.text = "Revenue Sales"
         label.textColor = .black
        label.frame = CGRect(x: 10, y: 8, width: 150, height: 20)
        let outerViewForBarChart = UIView()
        self.noRecordsLabelForSales1.frame = CGRect(x: 10, y: 10, width: outerViewForBarChart.frame.size.width - 20, height: outerViewForBarChart.frame.size.height - 20)
        outerViewForBarChart.frame = CGRect(x: 4, y: label.frame.origin.y + label.frame.size.height + 10, width: self.view.frame.size.width - 8, height: 250)
        self.barChartView.frame = CGRect(x: 10, y: 10, width: outerViewForBarChart.frame.size.width - 20, height: outerViewForBarChart.frame.size.height - 20)
        outerViewForBarChart.addSubview(self.noRecordsLabelForSales1)

        outerViewForBarChart.addSubview(self.barChartView)
       // self.barChartView.dataSource = self
        self.revSlaesView.addSubview(outerViewForBarChart)
        self.revSlaesView.addSubview(label)
       // self.revSlaesView.backgroundColor = .red
        days = ["Jan", "Feb", "Mar", "Apr", "May"]
       let tasks = [20.0, 4.0, 0.0, 3.0, -12.0]
        SetCharts(datapoints: days , values: tasks)
        
    }
    func SetCharts(datapoints: [String], values : [Double]){
               var dataEntries : [BarChartDataEntry] = []
        if datapoints.count == 0
        {
            self.noRecordsLabelForSales2.isHidden = false
            self.pieChartView.isHidden = true
        }
        else
        {
            self.noRecordsLabelForSales2.isHidden = true
             self.pieChartView.isHidden = false
               for i in 0..<datapoints.count{
                   let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
                   dataEntries.append(dataEntry)
               }
        }
               
               //        let chartDataset = BarChartDataSet(entries: dataEntries, label: "")
       //        let  chartData = BarChartData()
       //        chartData.addDataSet(chartDataset)
       //        barView.data = chartData
       //        chartDataset.colors = ChartColorTemplates.colorful()
       //        barView.animate(xAxisDuration: 2.0, yAxisDuration : 2.0)
               
              // let chartData = BarChartData(xVals: days, dataSet: chartDataSet)
        
        
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
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
    func setRevSlaesView2()
    {
       let label = UILabel()
       label.text = "Revenue Sales"
        label.textColor = .black
       label.frame = CGRect(x: 10, y: 8, width: 150, height: 20)
       let outerViewForPieChart = UIView()
       outerViewForPieChart.frame = CGRect(x: 4, y: label.frame.origin.y + label.frame.size.height + 10, width: self.view.frame.size.width - 8, height: 250)
        self.noRecordsLabelForSales2.frame = CGRect(x: 10, y: 10, width: outerViewForPieChart.frame.size.width - 20, height: outerViewForPieChart.frame.size.height - 20)
             outerViewForPieChart.addSubview(self.noRecordsLabelForSales2)
       self.pieChartView.frame = CGRect(x: 10, y: 10, width: outerViewForPieChart.frame.size.width - 20, height: outerViewForPieChart.frame.size.height - 20)
       outerViewForPieChart.addSubview(self.pieChartView)
        
       self.revSlaesView2.addSubview(outerViewForPieChart)
       self.revSlaesView2.addSubview(label)
        //self.revSlaesView2.backgroundColor = .blue
        
    }
    
    func setUpPichart(paramater : String)
       {
        self.pieChartView.chartDescription?.enabled = false
                   self.pieChartView.drawHoleEnabled = false
                   self.pieChartView.rotationAngle = 0
          //  piView.rotationEnabled = false
           //  piView.isUserInteractionEnabled = false
           
           // piView.legend.enabled = false
           //reveniewYear
        /* {
                   "year": "2019",
                   "month": "September",
                   "monthDate": "9",
                   "amount": "30079",
                   "customer_ledger": "87"
               }*/
        /*reveniewWeek,reveniewToday,reveniewYear,weekWiseRevenieMonth*/
        let itemes : [NSDictionary] = self.jsonDic[paramater] as! [NSDictionary]
        //var value = [NSInteger]()
        var entries : [PieChartDataEntry] = Array()
        if itemes.count == 0
        {
            self.noRecordsLabelForSales1.isHidden = false
            self.barChartView.isHidden = true
        }
        else
        {
            self.noRecordsLabelForSales1.isHidden = true
             self.barChartView.isHidden = false
        for item in itemes
        {
           // value.append(item["amount"] as! NSInteger)
            let valueInInt = Double(item["amount"] as! String)
                //item["amount"]
            if paramater == "reveniewYear"
            {
            entries.append(PieChartDataEntry(value:valueInInt!, label: item["month"] as? String))
            }
            else if paramater == "reveniewToday"
            {
            entries.append(PieChartDataEntry(value:valueInInt!, label: item["date"] as? String))
            }
            else if paramater == "weekWiseRevenieMonth"
            {
            entries.append(PieChartDataEntry(value:valueInInt!, label: item["date"] as? String))
            }
            else
            {
            entries.append(PieChartDataEntry(value:valueInInt!, label: item["date"] as? String))
            }
            
        }
        }
        
           
//           entries.append(PieChartDataEntry(value: 50.0, label: ""))
//           entries.append(PieChartDataEntry(value: 20.0, label: ""))
//           entries.append(PieChartDataEntry(value: 150.0, label: ""))
//           entries.append(PieChartDataEntry(value: 30.0, label: ""))
//           entries.append(PieChartDataEntry(value: 30.0, label: ""))
           
           
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
    
       //MARK :- setBarChart
       func didTouch(entryData: CoreChartEntry) {
           print(entryData.barTitle)
       }
       
//       func loadCoreChartData() -> [CoreChartEntry] {
//
//           return getTurkeyFamouseCityList(dataInChart: dataForBarChart)
//
//       }
       
       
    func getTurkeyFamouseCityList(dataInChart : [NSDictionary]) {
           var allCityData = [CoreChartEntry]()
        var dateNameArray = [String]()
        var valueArray = [NSInteger]()
        print("dataInChart : \(dataInChart)")
        var dataEntries : [BarChartDataEntry] = []
        var i = 0
        for value in dataInChart
        {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(value["amount"] as! String) ?? 0.0)
            dataEntries.append(dataEntry)
            
           // dateNameArray.append(value["name"] as! String)
           // print("\(NSInteger(Float(value["amount"] as! String) ?? 0.0))")
            //valueArray.append(NSInteger(Float(value[] as! String) ?? 0.0))
            i = i + 1
        }
        
        
                     
                    
              let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
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
        
        
//           let cityNames = ["Istanbul","Antalya","Ankara","Trabzon","İzmir"]
//           let plateNumber = [34,07,06,61,35]

//           for index in 0..<dateNameArray.count {
//
//               let newEntry = CoreChartEntry(id: "\(valueArray[index])",
//                barTitle: dateNameArray[index] as String,
//                                             barHeight: Double(valueArray[index]),
//                                             barColor: rainbowColor())
//
//
//               allCityData.append(newEntry)
//
//           }
//
//           return allCityData
        
       
           
       }
    
    //MARK: - CollectionViewDelegate
      func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return self.erpArray.count
      }
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewwCell1Id", for: indexPath) as! homeCollectionViewwCell1
          cell.imageOfItem.image = UIImage(named: self.erpArray[indexPath.row])
        if indexPath.row == 0 {
            cell.mainViewInCollectionView.backgroundColor = UIColor(displayP3Red: 14.0/255, green: 164.0/255, blue: 151.0/255, alpha: 1)
        }
        else if indexPath.row == 1 {
            cell.mainViewInCollectionView.backgroundColor = UIColor(displayP3Red: 28.0/255, green: 96.0/255, blue: 174.0/255, alpha: 1)
        }
        else if indexPath.row == 2 {
            cell.mainViewInCollectionView.backgroundColor = UIColor(displayP3Red: 144.0/255, green: 58.0/255, blue: 142.0/255, alpha: 1)
        }
        else
        {
            cell.mainViewInCollectionView.backgroundColor = UIColor(displayP3Red: 117.0/255, green: 185.0/255, blue: 40.0/255, alpha: 1)
        }
                 cell.nameOfItemLabel.text = self.erpArray[indexPath.row]
          
          cell.imageOfItem.frame = CGRect(x: 15, y: 10, width: 30, height: 30)
         
          cell.countLabel.frame = CGRect(x: 40, y: 10, width: self.view.frame.size.width / 2 - 55 , height: 30)
          
           cell.nameOfItemLabel.frame = CGRect(x: 5, y: 45, width: self.view.frame.size.width / 2 - 30 , height: 40)
        cell.nameOfItemLabel = self.setLabelCount(label: cell.countLabel , value: self.setCountLabelArray[indexPath.row])
        cell.mainViewInCollectionView.layer.cornerRadius = 8
          return cell
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: self.view.frame.size.width/2 - 1 , height: 110)
      }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCustomerViewControllerId") as? ManageCustomerViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 1
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageProductViewControllerId") as? ManageProductViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 2
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageSupplierViewControllerId") as? ManageSupplierViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecentInvoiceViewControllerId") as? RecentInvoiceViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    //MARK: - tableViewViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 1
        {
        return 1
        }
        else if tableView.tag == 3
        {
            return 1
        }
        else
        {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1
        {
      return self.firstTableViewArray.count
        }
            else if tableView.tag == 3
            {
                return self.slideMenuArray.count
            }
        else
        {
            
            print("\(self.forProductsSecondTableString)")
            if section == 0
            {
                if self.forProductsSecondTableString.length != 0
                {
                let data : [NSDictionary] = self.jsonDic[self.forProductsSecondTableString as String] as! [NSDictionary]
                return data.count
                }
                else
                {
                    return 0
                }
            }
            else
            {
                /* self.forProductsSecondTableString = "best_sales_products_week"
                       self.forCustomerSecondTableString = "best_customer_datewise_week"*/
                print("\(self.forCustomerSecondTableString)")
                if self.forCustomerSecondTableString.length != 0
                {
                     print("\(jsonDic)")
                    print("\(jsonDic[self.forCustomerSecondTableString as String] ?? "")")
                let data : [NSDictionary] = self.jsonDic[self.forCustomerSecondTableString as String] as! [NSDictionary]
                return data.count
                }
                else
                {
                   
                    return 0
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell1Id", for: indexPath) as! homeTableViewCell1
        cell.mainViewInTableView.layer.cornerRadius = 8
        
        cell.mainViewInTableView.layer.masksToBounds = false
           cell.mainViewInTableView.layer.shadowColor = UIColor.black.cgColor
           cell.mainViewInTableView.layer.shadowOpacity = 0.5
           cell.mainViewInTableView.layer.shadowOffset = CGSize(width: 1, height: 1)
           cell.mainViewInTableView.layer.shadowRadius = 1
        
        cell.nameOfItemLabel.text = self.firstTableViewArray[indexPath.row]
        cell.imageOfItems.image = UIImage(named: self.firstTableViewArray[indexPath.row])
        return cell
        }
         else if tableView.tag == 3
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SlideTableViewCellId", for: indexPath) as! SlideTableViewCell
            cell.nameInSlide.text = self.slideMenuArray[indexPath.row]
            cell.imageInSlide.image = UIImage(named: self.slideMenuArray[indexPath.row])
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellInMainScrollTableViewCellId", for: indexPath) as! cellInMainScrollTableViewCell
                  // cell.mainViewInTableView.layer.cornerRadius = 8
            cell.firstViewInCell.layer.borderWidth = 1
            cell.firstViewInCell.layer.borderColor = UIColor.black.cgColor
            
            cell.secondViewInCell.layer.borderWidth = 1
            cell.secondViewInCell.layer.borderColor = UIColor.black.cgColor
            
            cell.firstViewInCell.frame = CGRect(x: 15, y: -1, width: self.view.frame.size.width - 145, height:55 )
            cell.secondViewInCell.frame = CGRect(x: self.view.frame.size.width - 145, y: -1, width: 131, height:55 )
            cell.nameOfProductLabel.frame = CGRect(x: 0, y: 0, width: cell.firstViewInCell.frame.size.width, height:cell.firstViewInCell.frame.size.height )
            cell.amountLabel.frame = CGRect(x: 0, y: 0, width: cell.secondViewInCell.frame.size.width, height:cell.secondViewInCell.frame.size.height )
            
            cell.amountLabel.textAlignment = .center
            cell.nameOfProductLabel.textAlignment = .center
            
            //best_customer_datewise_day
            //best_sales_products_month
            //best_sales_products_week
           // best_sales_products_day
           // best_sales_products_year
            /*{
                "product_id": "5000154",
                "product_name": "CHYAWANPRASH MANGO",
                "sale": "14731",
                "quantity": "55",
                "supplier_rate": "133.92",
                "rate": "133.92"
            }*/
            if indexPath.section == 0
            {
            var productArray = [NSDictionary]()
               // best_customer_datewise_year
                //best_customer_datewise_month
           if self.forProductsSecondTableString.isEqual(to: "best_sales_products_month")
           {
               productArray = self.jsonDic["best_sales_products_month"] as! [NSDictionary]
           }
           else if self.forProductsSecondTableString.isEqual(to: "best_sales_products_week")
           {
              productArray = self.jsonDic["best_sales_products_week"] as! [NSDictionary]
           }
           else if self.forProductsSecondTableString.isEqual(to: "best_sales_products_day")
           {
             productArray = self.jsonDic["best_sales_products_day"] as! [NSDictionary]
           }
           else
           {
             productArray = self.jsonDic["best_sales_products_year"] as! [NSDictionary]
           }
            let productItem = productArray[indexPath.row]
            cell.nameOfProductLabel.text = productItem["product_name"] as? String
                cell.amountLabel.text = productItem["sale"] as? String
            }
            else
            {
                var productArray = [NSDictionary]()
                
                if self.forProductsSecondTableString.isEqual(to: "best_customer_datewise_month")
                           {
                               productArray = self.jsonDic["best_customer_datewise_month"] as! [NSDictionary]
                           }
                           else if self.forProductsSecondTableString.isEqual(to: "best_customer_datewise_week")
                           {
                              productArray = self.jsonDic["best_customer_datewise_week"] as! [NSDictionary]
                           }
                           else if self.forProductsSecondTableString.isEqual(to: "best_customer_datewise_day")
                           {
                             productArray = self.jsonDic["best_customer_datewise_day"] as! [NSDictionary]
                           }
                           else
                           {
                             productArray = self.jsonDic["best_customer_datewise_year"] as! [NSDictionary]
                           }
                /*{
                    "customer_email": "thomas@lanciusit.com",
                    "customer_mobile": "888888888888888",
                    "customer_name": "Thomas",
                    "customer_id": "XKVYC4J5HCPSV7R",
                    "sale": "160000"
                }*/
                let productItem = productArray[indexPath.row]
                cell.nameOfProductLabel.text = productItem["customer_name"] as? String
                    cell.amountLabel.text = productItem["sale"] as? String
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1
        {
        return 70
        }
        else
        {
        return 55
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        if tableView.tag == 2
        {
            let viewInHeader = UIView()
                viewInHeader.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 70)
            let label = UILabel()
            label.frame = CGRect(x: 15, y: 13.5, width: self.view.frame.size.width - 30, height: 18)
            //let BottemView = UIView()
            let firstBottemView = UIView()
            let secondBottemView = UIView()
            firstBottemView.frame = CGRect(x: 15, y: 45, width: self.view.frame.size.width - 159, height: 45)
            secondBottemView.frame = CGRect(x: self.view.frame.size.width - 145 , y: 45, width: 131, height: 45)
            firstBottemView.layer.borderWidth = 1
            firstBottemView.layer.borderColor = UIColor.black.cgColor
            secondBottemView.layer.borderWidth = 1
            secondBottemView.layer.borderColor = UIColor.black.cgColor
            if(section == 1)
            {
            label.text = "Top 10 Customer's"
                
             let nameOfItem = UILabel()
             nameOfItem.frame = CGRect(x: 0, y: 0, width: firstBottemView.layer.frame.size.width, height:45)
             nameOfItem.text = "Customer"
                nameOfItem.textColor = .black
             nameOfItem.textAlignment = .center
             firstBottemView.addSubview(nameOfItem)
             let label2 = UILabel()
                            label2.frame = CGRect(x: 0, y: 0, width: secondBottemView.layer.frame.size.width, height:45)
                            label2.text = "Total"
                label2.textColor = .black
                            label2.textAlignment = .center
                            secondBottemView.addSubview(label2)
                 nameOfItem.font = UIFont(name: "Helvetica", size: 16)
                 label2.font = UIFont(name: "Helvetica", size: 16)
            }else
            {
              label.text = "Top 10 Sellable Products"
             let nameOfItem = UILabel()
                            nameOfItem.frame = CGRect(x: 0, y: 0, width: firstBottemView.layer.frame.size.width, height:45)
                            nameOfItem.text = "Item Name"
                nameOfItem.textColor = .black
                            nameOfItem.textAlignment = .center
                            firstBottemView.addSubview(nameOfItem)
                            let label2 = UILabel()
                                           label2.frame = CGRect(x: 0, y: 0, width: secondBottemView.layer.frame.size.width, height:45)
                                           label2.text = "Total Sale"
                label2.textColor = .black
                                           label2.textAlignment = .center
                                           secondBottemView.addSubview(label2)
                nameOfItem.font = UIFont(name: "Helvetica", size: 16)
                                label2.font = UIFont(name: "Helvetica", size: 16)
            }
             label.font = UIFont(name: "Helvetica-Bold", size: 16)
            label.textColor = custemBlueColor
            viewInHeader.addSubview(firstBottemView)
            viewInHeader.addSubview(secondBottemView)
            viewInHeader.addSubview(label)
            viewInHeader.backgroundColor = UIColor.white
            return viewInHeader
        }
        else
        {
            let view = UIView()
                view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0)
            return view
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.tag == 2
        {
        return 90
        }
        else
        {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1
        {
            if indexPath.row == 0
            {
                self.goToManageInvoiceScreen()
            }
            if indexPath.row == 1
                       {
                        self.goToSupplierScreen()
                       }
        }
        
        if tableView.tag == 3
        {
            self.hideSlideMenu()
          if indexPath.row == 1
          {
              self.goToManageInvoiceScreen()
          }
          if indexPath.row == 2
          {
                self.goToQuotationsScreen()
           }
            if indexPath.row == 3
            {
                self.goToAccountScreen()
            }
            if indexPath.row == 4
            {
                self.goToCategoryScreen()
            }
            if indexPath.row == 5
            {
                self.goToProductScreen()
            }
            if indexPath.row == 6
            {
                self.goToManageCustomerScreen()
            }
              if indexPath.row == 7
              {
                self.goToUnitScreen()
              }
              if indexPath.row == 8
            {
            self.goToSupplierScreen()
            }
            if indexPath.row == 9
            {
             self.goToPurchaseScreen()
            }
            if indexPath.row == 10
            {
                self.goToReturnScreen()
            }
            if indexPath.row == 11
            {
                self.goToTaxScreen()
            }
            if indexPath.row == 12
            {
                self.goToStockScreen()
            }
            if indexPath.row == 13
            {
                self.goToReportScreen()
            }
            if indexPath.row == 14
            {
                self.goToMessageScreen()
            }
            if indexPath.row == 15
            {
                self.goToSoftwareSettingScreen()
                
            }
            if indexPath.row == 16
            {
                self.goToRollPermissionScreen()
            }
            if indexPath.row == 17
            {
                 self.goToCMR()
                //self.goToUpdateProflieScreen()
            }
            if indexPath.row == 18
            {
                 self.gotoManageCustomerProductPriceViewController()
              //  self.goToChangePasswordScreen()
            }
            if indexPath.row == 19
            {
                self.goToLoginScreenScreen()
            }
        }
    }
   //MARK: - SCROLLVIEW DELEGATE
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
           if (self.mainScrollView.contentOffset.y > 200) {
               UIView.animate(withDuration: 2, animations: {
                //   self.dropedView.frame.origin.x = 0
                   self.dropDowenView.isHidden = false
               }) { _ in
                   
               }
           }else{
               var frame : CGRect
               frame = self.dropDowenView.frame
               UIView.animate(withDuration: 2, animations: {
                 //  self.dropedView.frame.origin.x = -frame.size.width
                   self.dropDowenView.isHidden = true
               }) { _ in
                   
               }
           }
       }
    //MARK: - ButtonActiones
    
    @IBAction func invoiceBtAction(_ sender: UIButton) {
        
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecentInvoiceViewControllerId") as? RecentInvoiceViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func totalSupplierBtAction(_ sender: UIButton) {
        
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageSupplierViewControllerId") as? ManageSupplierViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    @IBAction func totalProductsBtAction(_ sender: UIButton) {
        
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageProductViewControllerId") as? ManageProductViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
    
    }
    @IBAction func totalCustomerBtAction(_ sender: UIButton) {
    
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCustomerViewControllerId") as? ManageCustomerViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func newApplicationBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageNewApplicationViewControllerId") as? ManageNewApplicationViewController
               
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func updateApplicationBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCustomerUpdateApplicantsViewControllerId") as? ManageCustomerUpdateApplicantsViewController
               
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func homeBtnAction(_ sender: UIButton) {
        
    }
    
    
    @IBAction func messageBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageMessagesViewControllerId") as? ManageMessagesViewController
               
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func outOfStockBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OutOfStockViewControllerId") as? OutOfStockViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func recentInvoiceBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecentInvoiceViewControllerId") as? RecentInvoiceViewController
               
               self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func slideMenuBtnAction(_ sender: UIButton) {
        self.forSlideMenuTransView.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            self.slideMenuView.frame.origin.x = 0
            self.slideMenuView.isHidden = false
        }) { _ in
            
        }
    }
    
    
    func goToManageInvoiceScreen()
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecentInvoiceViewControllerId") as? RecentInvoiceViewController
                   
                   self.navigationController?.pushViewController(vc!, animated: true)
    }
    func goToQuotationsScreen()
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageQuotationViewControllerId") as? ManageQuotationViewController
                   
                   self.navigationController?.pushViewController(vc!, animated: true)
    }
    func goToCategoryScreen()
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCategoryViewControllerId") as? ManageCategoryViewController
                   
                   self.navigationController?.pushViewController(vc!, animated: true)
    }
    func goToProductScreen()
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageProductViewControllerId") as? ManageProductViewController
                   
                   self.navigationController?.pushViewController(vc!, animated: true)
    }
    func goToManageCustomerScreen()
    {
         let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
        vc?.slidemenuSubListArray = ["Manage New Applicants ","Manage customer","Manage Customer Update","Manage Active Customer","Manage Inactive Customer"]
        vc?.sublistTitelName = "Customer"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func goToCMR()
    {
    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
           vc?.slidemenuSubListArray = ["Daily Sales Run ","Manage Customer "]
           vc?.sublistTitelName = "CMR"
           self.navigationController?.pushViewController(vc!, animated: true)
       }
    func goToUnitScreen()
       {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageUnitViewControllerId") as? ManageUnitViewController
                      
                      self.navigationController?.pushViewController(vc!, animated: true)
       }
    func goToSupplierScreen()
       {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageSupplierViewControllerId") as? ManageSupplierViewController
                      
                      self.navigationController?.pushViewController(vc!, animated: true)
       }
   func gotoManageCustomerProductPriceViewController()
   {
    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCustomerProductPriceViewControllerId") as? ManageCustomerProductPriceViewController
    
    self.navigationController?.pushViewController(vc!, animated: true)
    }
    func goToUpdateProflieScreen()
          {
              let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UpdateProfileViewControllerId") as? UpdateProfileViewController
                         
                         self.navigationController?.pushViewController(vc!, animated: true)
          }
    func goToChangePasswordScreen()
          {
              let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangePasswordViewControllerId") as? ChangePasswordViewController
                         
                         self.navigationController?.pushViewController(vc!, animated: true)
          }
    func goToLoginScreenScreen()
          {
              let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewControllerId") as? LoginViewController
            
                    self.navigationController?.pushViewController(vc!, animated: true)
          }
    
    func goToPurchaseScreen()
       {
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManagePurchaseViewControllerId") as? ManagePurchaseViewController
                      
                      self.navigationController?.pushViewController(vc!, animated: true)
       }
    //084610011021288
    //ANDB0000846
    //6305984990
    func goToMessageScreen()
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageMessagesViewControllerId") as? ManageMessagesViewController
                   self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func goToAccountScreen()
    {
         let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
        vc?.slidemenuSubListArray = ["Cash Book","Inventory Ledger"]
        vc?.sublistTitelName = "Accounts"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func goToReturnScreen()
    {
         let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
         vc?.slidemenuSubListArray = ["Stock Return List","Supplier Return List","Wastage Return List"]
         vc?.sublistTitelName = "Return"
         self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func goToStockScreen()
    {
          let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
         vc?.slidemenuSubListArray = ["Stock Report","Stock Report (Supplier Wise)","Stock Report (Product Wise)"]
         vc?.sublistTitelName = "Stock"
         self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func goToTaxScreen()
    {
          let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageTaxViewControllerId") as? ManageTaxViewController
    
         self.navigationController?.pushViewController(vc!, animated: true)
    }
    func goToRollPermissionScreen()
    {

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
                vc?.slidemenuSubListArray = ["Role List","User Assign Role"]
                vc?.sublistTitelName = "Role Permission"
                self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func goToReportScreen()
    {
          let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
          vc?.slidemenuSubListArray = ["Closing Report","Todays Report","Todays Customer Receipt","Sales Report","Due Report","Shipping Cost Report","Purchase Report","Category wise purchase report","Product Wise Sales Report","Category wise sales report"]
          vc?.sublistTitelName = "Report"
          self.navigationController?.pushViewController(vc!, animated: true)
    }
    func goToSoftwareSettingScreen()
       {
             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
             vc?.slidemenuSubListArray = ["Add User","Manage Users"]
             vc?.sublistTitelName = "Software Settings"
             self.navigationController?.pushViewController(vc!, animated: true)
       }
    
    //MARK :- Network
    func forDashBoardData()
       {
        

        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\n    \"user_type\":\"1\",\n    \"user_id\":\"HKTg6h4ngYLCuMt\"\n}\n\n\n"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://cygenerp.com/erpapi/api/dashboardios")!,timeoutInterval: Double.infinity)
        request.addValue("81dc9bdb52d04dc20036dbd8313ed055", forHTTPHeaderField: "x-api-key")
        request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.addValue("PHPSESSID=969a58ca446036198f31b06edc85ddfc0e93e8cc", forHTTPHeaderField: "Cookie")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            do{
                
                                               let jsonRespone = try JSONSerialization.jsonObject(with:data, options: []) as! [String : Any]
                                               DispatchQueue.main.async {
                                               print(jsonRespone)
                                                self.jsonDic = jsonRespone

                                                self.setFrameAutoLayout()
                                              /* self.totalProductsValue = jsonRespone["total_product"] as! NSInteger
                                               self.totalCustomersValue = jsonRespone["total_customer"] as! NSInteger
                                               self.totalSuppliersValue = jsonRespone["total_suppliers"] as! NSInteger
                                               self.totalInvoiceValue = jsonRespone["total_product"] as! NSInteger
                                                
                                                self.setCountLabelArray.removeAll()
                                                 */
                                                
                                                let total_customer = NSInteger(jsonRespone["total_customer"] as! String)
                                                let total_product = NSInteger(jsonRespone["total_product"] as! NSInteger)
                                                let total_suppliers = NSInteger(jsonRespone["total_suppliers"] as! NSInteger)
                                                let total_sales = NSInteger(jsonRespone["total_sales"] as! NSInteger)
                                                    
                                                self.setCountLabelArray.append(total_customer!)
                                                self.setCountLabelArray.append(total_product)
                                                 self.setCountLabelArray.append(total_suppliers)
                                                 self.setCountLabelArray.append(total_sales)
                                                //weekWiseRevenieMonth
                                                //self.setUpPichart()
                                                self.dataForBarChart = [NSDictionary]()
                                                self.setDataForBarChatBasedOnButtons(parameter: "reveniewToday")
                                                self.setUpPichart(paramater :"reveniewToday")
                //                                self.monthly_sales_report_Array = jsonRespone["weekWiseRevenieMonth"] as! [NSDictionary]
                //
                //                                print("\(self.monthly_sales_report_Array)")
                //                                for value in self.monthly_sales_report_Array
                //                                {
                //                                    var valueString = String()
                ////                                    guard let valueString = value["amount"]
                ////                                    else
                ////                                    {
                ////                                        return
                ////                                    }
                //
                //                                    if value["amount"] as? String != nil
                //                                     {
                //                                        valueString = value["amount"] as! String
                //                                    }
                //                                    else
                //                                    {
                //                                        valueString = "0"
                //                                    }
                //                                    let data = ["name":value["day"] as! String , "amount" : valueString] as [String : Any]
                //                                    self.dataForBarChart.append(data as NSDictionary)
                //                                }
                //                                self.getTurkeyFamouseCityList(dataInChart: self.dataForBarChart)
                                                
                                                
                                                
                                                
                                                
                                                
                                              //  self.barChartView.dataSource = self
                                                
                                               // self.SetCharts(datapoints: setValuesForBarChart1)
                                              print("self.totalInvoiceValue = \(self.setCountLabelArray[3])  self.totalSuppliersValue = \(self.setCountLabelArray[2])  self.totalCustomersValue = \(self.setCountLabelArray[1])  self.totalProductsValue = \(self.setCountLabelArray[0])")
                                                self.totalProductsPopLabel.text = "\(self.setCountLabelArray[1])"
                                                self.totalInvoicePopLabel.text = "\(self.setCountLabelArray[3])"
                                                self.totalSupplerPopLabel.text = "\(self.setCountLabelArray[2])"
                                                self.totalCustomerPopLabel.text = "\(self.setCountLabelArray[0])"
                                                
                                                self.getNotification()
                //                                self.days = ["Jan", "Feb", "Mar", "Apr", "May"]
                //                                        let tasks = [120.0, 4.0, 0.0, 3.0, -112.0]
                //                                self.SetCharts(datapoints: self.days , values: tasks)
                                                }
                                               } catch
                                                let parsingError {
                                                  print("Error", parsingError)
                                             }

          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        /*self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
           let url : URL = URL(string: BaseUrl + "/dashboardios")!
               //"http://infysmart.com/erpapi/api/dashboard")!
        //http://infysmart.com/erpapi/api/dashboardios
             let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
//           let parameters = ["user_id":USERID,"user_type":USERTYPE]
         let parameters = ["user_id":"HKTg6h4ngYLCuMt","user_type":"1"]
               
                   
                   AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                       print(response.request as Any)  // original URL request
                       print(response.response as Any)// URL response
                       let response1 = response.response
                    
                                           self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                       if response1?.statusCode == 200
                       {
                            do{
                               let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                               DispatchQueue.main.async {
                               print(jsonRespone)
                                self.jsonDic = jsonRespone

                                self.setFrameAutoLayout()
                              /* self.totalProductsValue = jsonRespone["total_product"] as! NSInteger
                               self.totalCustomersValue = jsonRespone["total_customer"] as! NSInteger
                               self.totalSuppliersValue = jsonRespone["total_suppliers"] as! NSInteger
                               self.totalInvoiceValue = jsonRespone["total_product"] as! NSInteger
                                
                                self.setCountLabelArray.removeAll()
                                 */
                                
                                let total_customer = NSInteger(jsonRespone["total_customer"] as! String)
                                let total_product = NSInteger(jsonRespone["total_product"] as! NSInteger)
                                let total_suppliers = NSInteger(jsonRespone["total_suppliers"] as! NSInteger)
                                let total_sales = NSInteger(jsonRespone["total_sales"] as! NSInteger)
                                    
                                self.setCountLabelArray.append(total_customer!)
                                self.setCountLabelArray.append(total_product)
                                 self.setCountLabelArray.append(total_suppliers)
                                 self.setCountLabelArray.append(total_sales)
                                //weekWiseRevenieMonth
                                //self.setUpPichart()
                                self.dataForBarChart = [NSDictionary]()
                                self.setDataForBarChatBasedOnButtons(parameter: "reveniewToday")
                                self.setUpPichart(paramater :"reveniewToday")
//                                self.monthly_sales_report_Array = jsonRespone["weekWiseRevenieMonth"] as! [NSDictionary]
//
//                                print("\(self.monthly_sales_report_Array)")
//                                for value in self.monthly_sales_report_Array
//                                {
//                                    var valueString = String()
////                                    guard let valueString = value["amount"]
////                                    else
////                                    {
////                                        return
////                                    }
//
//                                    if value["amount"] as? String != nil
//                                     {
//                                        valueString = value["amount"] as! String
//                                    }
//                                    else
//                                    {
//                                        valueString = "0"
//                                    }
//                                    let data = ["name":value["day"] as! String , "amount" : valueString] as [String : Any]
//                                    self.dataForBarChart.append(data as NSDictionary)
//                                }
//                                self.getTurkeyFamouseCityList(dataInChart: self.dataForBarChart)
                                
                                
                                
                                
                                
                                
                              //  self.barChartView.dataSource = self
                                
                               // self.SetCharts(datapoints: setValuesForBarChart1)
                              print("self.totalInvoiceValue = \(self.setCountLabelArray[3])  self.totalSuppliersValue = \(self.setCountLabelArray[2])  self.totalCustomersValue = \(self.setCountLabelArray[1])  self.totalProductsValue = \(self.setCountLabelArray[0])")
                                self.totalProductsPopLabel.text = "\(self.setCountLabelArray[1])"
                                self.totalInvoicePopLabel.text = "\(self.setCountLabelArray[3])"
                                self.totalSupplerPopLabel.text = "\(self.setCountLabelArray[2])"
                                self.totalCustomerPopLabel.text = "\(self.setCountLabelArray[0])"
                                
                                self.getNotification()
//                                self.days = ["Jan", "Feb", "Mar", "Apr", "May"]
//                                        let tasks = [120.0, 4.0, 0.0, 3.0, -112.0]
//                                self.SetCharts(datapoints: self.days , values: tasks)
                                }
                               } catch
                                let parsingError {
                                  print("Error", parsingError)
                             }
                          // let dataFromServer =
                       }
                   
        }*/
       }
    //http://lanciusit.com/demo/erpapi/api/notification
    func getNotification()
        {
         self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
            let url : URL = URL(string:BaseUrl + "/notification")!
                    
                    let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                    AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                        print(response.request as Any)  // original URL request
                        print(response.response as Any)// URL response
                        let response1 = response.response
                     DispatchQueue.main.async {
                                            self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
                        if response1?.statusCode == 200
                        {
                            /*
                                "title": "notification",
                                "out_of_stock": 3,
                                "balance": "$ 317.5",
                                "message": 10,
                                "incompleteUser": 0,
                                "invoice": 12,
                                "newApplicant": 0
                            }*/
                            do{
                            let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                            self.newApplicationBadgeLabel.text = "\(jsonRespone["newApplicant"] ?? "")"
                                self.updateApplicationBadgeLabel.text = "\(jsonRespone["incompleteUser"] ?? "")"
                                self.messageBadgeCountLabel.text = "\(jsonRespone["message"] ?? "")"
                                self.outOfStockBadgeCountLabel.text = "\(jsonRespone["out_of_stock"] ?? "")"
                                self.recentInvoiceBadgeCountLabel.text = "\(jsonRespone["invoice"] ?? "")"
                            }
                            catch
                            {
                                
                            }
                        }
                        
                        }
            }
    }
    //MARK :- Help functions
    func setLabelCount(label : UILabel , value : NSInteger) -> UILabel
    {
        let duration: Double = 3.0 //seconds
               DispatchQueue.global().async {
                   for i in 0 ..< (value + 1) {
                       let sleepTime = UInt32(duration/Double(value) * 1000000.0)
                       usleep(sleepTime)
                       DispatchQueue.main.async {
                           label.text = "\(i)"
                       }
                   }
               }
        return label
    }
}
