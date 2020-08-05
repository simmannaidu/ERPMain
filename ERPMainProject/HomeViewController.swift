//
//  HomeViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/16/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Charts
import Alamofire
class SlideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var slidemenuImage: UIImageView!
    @IBOutlet weak var slidemenuNameLabel: UILabel!
}
class homeCollectionViewCell : UICollectionViewCell
{
    @IBOutlet weak var imageOfItem: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var mainViewInCell: UIView!
}
class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate,UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    enum slideMenuList : Int{
        case Dashbord = 0
        case Invoice = 1
        case Quotations = 2
        case Accounts = 3
        case category = 4
        case Product = 5
        case Customer = 6
        case Unit = 7
        case Supplier = 8
        case purchase = 9
        case Stock = 10
        case Report = 11
        case manageMessage = 12
        case SoftwareSettings = 13
        case RolePermission = 14
        case UpdateProfile = 15
        case ChangePassword = 16
        case Logout = 17
    }
    
    var totalCustomersValue = NSInteger()
    var totalProductsValue = NSInteger()
    var totalSuppliersValue = NSInteger()
    var totalInvoiceValue = NSInteger()
    var todayArray = NSArray()
    var monthlyArray = NSArray()
    var weeklyArray = NSArray()
    var yearlyArray = NSArray()
    var best_sales_product_Array = NSArray()
    var weekly_sales_report_Array = NSArray()
    var yearly_sales_report_Array = NSArray()
   var mainScrollView = UIScrollView()
    @IBOutlet weak var firstViewInMainScrollView: UIView!
    
   
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var viewInsideFirstVie: UIView!
    @IBOutlet weak var secondViewInMainScrollView: UIView!
    @IBOutlet weak var thirdViewInMainScrollView: UIView!
    @IBOutlet weak var forthViewInMainScrollView: UIView!
    @IBOutlet weak var fiftyViewInMainScrollView: UIView!
    @IBOutlet weak var sixthViewInMainScrollView: UIView!
    @IBOutlet weak var seventhViewInMainScrollView: UIView!
    @IBOutlet weak var ninthViewInMainScrollView: UIView!
    
    @IBOutlet weak var eleventhViewInMainScrollView: UIView!
    @IBOutlet weak var tenthInMainScrollView: UIView!
    @IBOutlet weak var eightViewInMainScrollView: UIView!
    
    @IBOutlet weak var homeScrollView: UIScrollView!
   
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var homeDataView: UIView!
    @IBOutlet weak var profileBadgeView: UIView!
    @IBOutlet weak var invoiceBadgeView: UIView!
    @IBOutlet weak var stockBadgeView: UIView!
    @IBOutlet weak var messagesBadgeView: UIView!
    @IBOutlet weak var newApplicationBadgeView: UIView!
    
    
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var slideMenuView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var slideMenuTableView: UITableView!
    
 //   @IBOutlet weak var totalCustomersView: UIView!
    @IBOutlet weak var totalProductsView: UIView!
    @IBOutlet weak var totalSuppliersView: UIView!
    @IBOutlet weak var totalInvoiceView: UIView!
    @IBOutlet weak var totalSuppliersCountLabel: UILabel!
    @IBOutlet weak var totalInvoiceCountLabel: UILabel!
  //  @IBOutlet weak var totalCustomersCountLabel: UILabel!
  //  @IBOutlet weak var totalProductsCountLabel: UILabel!
    
    @IBOutlet weak var invoiceView: UIView!
    @IBOutlet weak var invoiceSubView: UIView!
    @IBOutlet weak var customerServiceView: UIView!
    @IBOutlet weak var customerServiceSubView: UIView!
    @IBOutlet weak var supplierPaymentView: UIView!
    @IBOutlet weak var suplierPaymentSubView: UIView!
    @IBOutlet weak var purchaseView: UIView!
    @IBOutlet weak var purchaseSubView: UIView!
    
    @IBOutlet weak var dropedView: UIView!
    
    @IBOutlet weak var onedayView: UIView!
    @IBOutlet weak var oneWeekView: UIView!
    @IBOutlet weak var fourWeekView: UIView!
    @IBOutlet weak var oneYearView: UIView!
    
    @IBOutlet weak var barchartRevenueSalesLabel: UILabel!
    @IBOutlet weak var pieChartRevenueSalesLabel: UILabel!
    @IBOutlet weak var barChartMainView: UIView!
    @IBOutlet weak var barChartMain2View: UIView!
    @IBOutlet weak var pieChartMainView: UIView!
    @IBOutlet weak var pieChartMain2View: UIView!
    @IBOutlet weak var pieView: PieChartView!
    @IBOutlet weak var barView: BarChartView!
    var days : [String]!
    
    var erpArray = [String]()
     let SlideMenutitleNames = ["Dashboard","Invoice","Quotations","Accounts","category","Product","Customer","Unit","Supplier","purchase","Stock","Report","Manage Message","Software Settings","Role Permission","Update Profile","Change Password","Logout"]
    let totalCounts = ["Total Customer","Total Product","Total Supplier","Total Invoice"]
    var actionButton : ActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //  setUpButtons()
        desien()
        
        forDashBoardData()
        self.slideMenuTableView.delegate = self
        self.slideMenuTableView.dataSource = self
        self.mainScrollView.showsVerticalScrollIndicator = false
         self.slideMenuTableView.showsVerticalScrollIndicator = false
      
        self.dropedView.isHidden = true
        
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideSlideMenu))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.transView?.addGestureRecognizer(mytapGestureRecognizer)
        self.slideMenuTableView.tableFooterView =  UIView(frame: .zero)
        
        currentDate()
        
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
                            self.totalProductsValue = jsonRespone["total_product"] as! NSInteger
                            self.totalCustomersValue = jsonRespone["total_customer"] as! NSInteger
                            self.totalSuppliersValue = jsonRespone["total_suppliers"] as! NSInteger
                            self.totalInvoiceValue = jsonRespone["total_product"] as! NSInteger
                            print("self.totalInvoiceValue = \(self.totalInvoiceValue)  self.totalSuppliersValue = \(self.totalSuppliersValue)  self.totalCustomersValue = \(self.totalCustomersValue)  self.totalProductsValue = \(self.totalProductsValue)")
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                }

    }
    func  currentDate(){
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let currentDate = formatter.string(from: currentDateTime)
        self.barchartRevenueSalesLabel.text = "Revenue Slaes by \(currentDate)"
        self.pieChartRevenueSalesLabel.text = "Revenue Slaes by \(currentDate)"
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setFrameForHomeScreen()
        self.transView.isHidden = true
        self.slideMenuView.isHidden = true
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.slideMenuTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
        
        let duration: Double = 3.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (100 + 1) {
                let sleepTime = UInt32(duration/Double(100) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.totalSuppliersCountLabel.text = "\(i)"
                 //   self.totalCustomersCountLabel.text = "\(i)"
                    self.totalInvoiceCountLabel.text = "\(i)"
                   // self.totalProductsCountLabel.text = "\(i)"
                }
            }
        }
        
        
        
        setUpPichart()
        days = ["Jan", "Feb", "Mar", "Apr", "May"]
        let tasks = [20.0, 4.0, 0.0, 3.0, -12.0]
        SetCharts(datapoints: days , values: tasks)
        

    }
    func setFrameForHomeScreen()
    {
         self.mainScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
        self.mainScrollView.frame = CGRect(x: 0, y: 75, width: self.view.frame.size.width, height: self.view.frame.size.height - 110)
        self.firstViewInMainScrollView.frame = CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: 220)
        self.mainScrollView.addSubview(self.firstViewInMainScrollView)
        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.backgroundColor = .magenta
        toSetFirstView()
        
    }
    func toSetFirstView()
    {
        //self.viewInsideFirstVie.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100)
        //
        self.erpArray = ["Total Customer","Total Product","Total Supplier","Total Invoice"]
        
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
        self.homeCollectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 220)
    }
    @objc func hideSlideMenu()
    {
        var frame : CGRect
        frame = self.slideMenuView.frame
        UIView.animate(withDuration: 1, animations: {
            self.slideMenuView.frame.origin.x = -frame.size.width
            self.transView.isHidden = true
            self.slideMenuView.isHidden = true
        }) { _ in
            
        }
        
    }

    //MARK: - CollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.erpArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCellId", for: indexPath) as! homeCollectionViewCell
        cell.imageOfItem.image = UIImage(named: self.erpArray[indexPath.row])
               cell.countLabel.text = self.erpArray[indexPath.row]
        
        cell.imageOfItem.frame = CGRect(x: 15, y: 15, width: 25, height: 25)
       
        cell.nameLabel.frame = CGRect(x: 40, y: 15, width: self.view.frame.size.width / 2 - 55 , height: 20)
        
         cell.countLabel.frame = CGRect(x: 5, y: 45, width: self.view.frame.size.width / 2 - 30 , height: 40)
       // cell.mainViewInCell.layer.cornerRadius = 8
        cell.backgroundColor = .magenta
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/2 - 1, height: 100)
    }
    // MARK: - statusBar Text Color change
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Scrollview Delegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.mainScrollView.contentOffset.y > 200) {
            UIView.animate(withDuration: 2, animations: {
             //   self.dropedView.frame.origin.x = 0
                self.dropedView.isHidden = false
            }) { _ in
                
            }
        }else{
            var frame : CGRect
            frame = self.dropedView.frame
            UIView.animate(withDuration: 2, animations: {
              //  self.dropedView.frame.origin.x = -frame.size.width
                self.dropedView.isHidden = true
            }) { _ in
                
            }
        }
    }
    
  // MARK: - buttonFlotting
    func setUpButtons(){
        
        let invoice = ActionButtonItem(title: "Invoice", image: UIImage(named: "dashboard") )
        let customerRecive = ActionButtonItem(title: "customerRecive", image: UIImage(named: "dashboard"))
        let SuplierPayment = ActionButtonItem(title: "SuplierPayment", image: UIImage(named: "dashboard"))
        let Purchase = ActionButtonItem(title: "Purchase", image: UIImage(named: "dashboard"))
        
        actionButton = ActionButton(attachedToView: self.view, items: [invoice, customerRecive, SuplierPayment, Purchase])
        actionButton.setTitle("+", forState: UIControl.State())
        
    actionButton.backgroundColor = UIColor.red
        actionButton.action = {button in button.toggleMenu()}
       
    }
    
    // MARK: - Desien
    func desien(){
        self.profileBadgeView.layer.cornerRadius = self.profileBadgeView.frame.size.height / 2
        self.profileBadgeView.clipsToBounds = true
        self.invoiceBadgeView.layer.cornerRadius = self.invoiceBadgeView.frame.size.height / 2
        self.invoiceBadgeView.clipsToBounds = true
        self.stockBadgeView.layer.cornerRadius = self.stockBadgeView.frame.size.height / 2
        self.stockBadgeView.clipsToBounds = true
        self.messagesBadgeView.layer.cornerRadius = self.messagesBadgeView.frame.size.height / 2
        self.messagesBadgeView.clipsToBounds = true
        self.newApplicationBadgeView.layer.cornerRadius = self.newApplicationBadgeView.frame.size.height / 2
        self.newApplicationBadgeView.clipsToBounds = true
    
     //   self.totalCustomersView.layer.cornerRadius = 8
       //  self.totalProductsView.layer.cornerRadius = 8
         self.totalSuppliersView.layer.cornerRadius = 8
         self.totalInvoiceView.layer.cornerRadius = 8
        
        self.invoiceView.layer.shadowColor = UIColor.lightGray
        self.invoiceView.layer.shadowOpacity = 1
        self.invoiceView.layer.masksToBounds = false
        self.invoiceView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
         self.invoiceView.layer.cornerRadius = 4
        self.invoiceView.layer.shadowRadius = 1
        
        self.invoiceSubView.layer.shadowColor = UIColor.lightGray
        self.invoiceSubView.layer.shadowOpacity = 1
        self.invoiceSubView.layer.masksToBounds = false
        self.invoiceSubView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.invoiceSubView.layer.cornerRadius = 4
        self.invoiceView.layer.shadowRadius = 1
        
        self.customerServiceView.layer.shadowColor = UIColor.lightGray
        self.customerServiceView.layer.shadowOpacity = 1
        self.customerServiceView.layer.masksToBounds = false
        self.customerServiceView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.invoiceSubView.layer.cornerRadius = 4
        self.invoiceSubView.layer.shadowRadius = 1
        
        self.customerServiceSubView.layer.shadowColor = UIColor.lightGray
        self.customerServiceSubView.layer.shadowOpacity = 1
        self.customerServiceSubView.layer.masksToBounds = false
        self.customerServiceSubView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.customerServiceSubView.layer.cornerRadius = 4
        self.customerServiceSubView.layer.shadowRadius = 1
        
        self.supplierPaymentView.layer.shadowColor = UIColor.lightGray
        self.supplierPaymentView.layer.shadowOpacity = 1
        self.supplierPaymentView.layer.masksToBounds = false
        self.supplierPaymentView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.supplierPaymentView.layer.cornerRadius = 4
        self.supplierPaymentView.layer.shadowRadius = 1
        
        self.suplierPaymentSubView.layer.shadowColor = UIColor.lightGray
        self.suplierPaymentSubView.layer.shadowOpacity = 1
        self.suplierPaymentSubView.layer.masksToBounds = false
        self.suplierPaymentSubView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.suplierPaymentSubView.layer.cornerRadius = 4
        self.suplierPaymentSubView.layer.shadowRadius = 1
        
        self.purchaseView.layer.shadowColor = UIColor.lightGray
        self.purchaseView.layer.shadowOpacity = 1
        self.purchaseView.layer.masksToBounds = false
        self.purchaseView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.purchaseView.layer.cornerRadius = 4
        self.purchaseView.layer.shadowRadius = 1
        
        self.purchaseSubView.layer.shadowColor = UIColor.lightGray
        self.purchaseSubView.layer.shadowOpacity = 1
        self.purchaseSubView.layer.masksToBounds = false
        self.purchaseSubView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.purchaseSubView.layer.cornerRadius = 4
        self.purchaseSubView.layer.shadowRadius = 1
        
        self.dropedView.layer.shadowColor = UIColor.lightGray
        self.dropedView.layer.shadowOpacity = 1
        self.dropedView.layer.masksToBounds = false
        self.dropedView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.dropedView.layer.shadowRadius = 2
        self.dropedView.layer.cornerRadius = 4
        
        self.onedayView.backgroundColor = UIColor.init(red: 28/255, green: 96/255, blue: 174/255, alpha: 1)
        self.oneWeekView.backgroundColor = UIColor.white
        self.fourWeekView.backgroundColor = UIColor.white
        self.oneYearView.backgroundColor = UIColor.white
        
        self.onedayView.layer.shadowColor = UIColor.lightGray
        self.onedayView.layer.shadowOpacity = 1
        self.onedayView.layer.masksToBounds = false
        self.onedayView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.onedayView.layer.shadowRadius = 2
        
        self.oneWeekView.layer.shadowColor = UIColor.lightGray
        self.oneWeekView.layer.shadowOpacity = 1
        self.oneWeekView.layer.masksToBounds = false
        self.oneWeekView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.oneWeekView.layer.shadowRadius = 2
        
        self.fourWeekView.layer.shadowColor = UIColor.lightGray
        self.fourWeekView.layer.shadowOpacity = 1
        self.fourWeekView.layer.masksToBounds = false
        self.fourWeekView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.fourWeekView.layer.shadowRadius = 2
        
        self.oneYearView.layer.shadowColor = UIColor.lightGray
        self.oneYearView.layer.shadowOpacity = 1
        self.oneYearView.layer.masksToBounds = false
        self.oneYearView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.oneYearView.layer.shadowRadius = 2
        
        
        self.barChartMainView.layer.shadowColor = UIColor.lightGray
        self.barChartMainView.layer.shadowOpacity = 1
        self.barChartMainView.layer.masksToBounds = false
        self.barChartMainView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.barChartMainView.layer.shadowRadius = 2
        //self.barChartMainView.layer.cornerRadius = 4
        
        self.barChartMain2View.layer.shadowColor = UIColor.lightGray
        self.barChartMain2View.layer.shadowOpacity = 1
        self.barChartMain2View.layer.masksToBounds = false
        self.barChartMain2View.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.barChartMain2View.layer.shadowRadius = 2
        
        self.pieChartMainView.layer.shadowColor = UIColor.lightGray
        self.pieChartMainView.layer.shadowOpacity = 1
        self.pieChartMainView.layer.masksToBounds = false
        self.pieChartMainView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.pieChartMainView.layer.shadowRadius = 2
      //  self.pieChartMainView.layer.cornerRadius = 4
        
        self.pieChartMain2View.layer.shadowColor = UIColor.lightGray
        self.pieChartMain2View.layer.shadowOpacity = 1
        self.pieChartMain2View.layer.masksToBounds = false
        self.pieChartMain2View.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.pieChartMain2View.layer.shadowRadius = 2
        
//        self.sliderView.layer.shadowPath = UIBezierPath(rect: self.sliderView.bounds).cgPath
//        self.sliderView.backgroundColor = UIColor.white
    }
    
    
    // MARK: - pichart
    
    
    func setUpPichart()
    {
        pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = false
        pieView.rotationAngle = 0
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
        
        pieView.data = PieChartData(dataSet: dataSet)
        
    }
    
    
    // MARK: - barChart
    func SetCharts(datapoints: [String], values : [Double]){
        
        var dataEntries : [BarChartDataEntry] = []

        for i in 0..<datapoints.count{
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

//        let chartDataset = BarChartDataSet(entries: dataEntries, label: "")
//        let  chartData = BarChartData()
//        chartData.addDataSet(chartDataset)
//        barView.data = chartData
//        chartDataset.colors = ChartColorTemplates.colorful()
//        barView.animate(xAxisDuration: 2.0, yAxisDuration : 2.0)
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Units Sold")
        //let chartData = BarChartData(xVals: days, dataSet: chartDataSet)
    
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
        
      //  chartDataSet.colors = ChartColorTemplates.colorful()
        barView.animate(xAxisDuration: 2.0, yAxisDuration : 2.0)
       
        let  colorsList = [UIColor(red:14/255 ,green:164/255 ,blue:151/255,alpha:1.0 ),
                           UIColor(red:28/255 ,green:96/255 ,blue:174/255,alpha:1.0 ),
                           UIColor(red:114/255 ,green:58/255 ,blue:142/255,alpha:1.0 ),
                           UIColor(red:250/255 ,green:184/255 ,blue:0/255,alpha:1.0 ),
                           UIColor(red:117/255 ,green:185/255 ,blue:40/255,alpha:1.0 )]
        chartDataSet.colors = colorsList
       
    
    }
    
    // MARK: - Tableview Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.SlideMenutitleNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "SlideMenuTableViewCellId", for: indexPath) as! SlideMenuTableViewCell
        cell.slidemenuNameLabel.text = SlideMenutitleNames[indexPath.row]
        cell.slidemenuImage.image = UIImage(named: SlideMenutitleNames[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == slideMenuList.Dashbord.rawValue {

            var frame : CGRect
            frame = self.slideMenuView.frame
            UIView.animate(withDuration: 1, animations: {
                self.slideMenuView.frame.origin.x = -frame.size.width
                self.transView.isHidden = true
            }) { _ in
                
            }
            
        }else if indexPath.row == slideMenuList.Invoice.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageInvoiceViewControllerId") as? ManageInvoiceViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.Quotations.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageQuotationViewControllerId") as? ManageQuotationViewController
    
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.Accounts.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
            vc?.slidemenuSubListArray = ["Customer Receive","Vocher Approval"]
            vc?.sublistTitelName = "Accounts"
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.category.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCategoryViewControllerId") as? ManageCategoryViewController
           
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.Product.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageProductViewControllerId") as? ManageProductViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.Customer.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
            vc?.slidemenuSubListArray = ["Add customer","Manage customer","Manage Active Customer","Manage Inactive Customer","credit customer","Paid Customer"]
            vc?.sublistTitelName = "Customer"
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.Unit.rawValue{
            
        }
        
        else if indexPath.row == slideMenuList.Supplier.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
            vc?.slidemenuSubListArray = ["Add Supplier","Manage Supplier","supplier ledger","Supplier Sales Details"]
            vc?.sublistTitelName = "Supplier"
            self.navigationController?.pushViewController(vc!, animated: true)
        }
            
        else if indexPath.row == slideMenuList.purchase.rawValue{
            
        }
        else if indexPath.row == slideMenuList.Stock.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
            vc?.slidemenuSubListArray = ["Stock Report","Stock Report (Supplier Wise)","Stock Report (Product Wise)"]
            vc?.sublistTitelName = "Stock"
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.Report.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
            vc?.slidemenuSubListArray = ["Cosing Account","Closing Report","Todays Report","Todays Customer Receipt","Sales Report","Due Report","Shipping Cost Report","Purchase Report","purchase report(Category wise)","Sales Report (Product Wise)","sales report(Category wise)"]
            vc?.sublistTitelName = "Report"
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.manageMessage.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SendMessageViewControllerId") as? SendMessageViewController
          
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.SoftwareSettings.rawValue{
        
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UpdateSttingsViewControllerId") as? UpdateSttingsViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.RolePermission.rawValue{
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserAssignRoleViewControllerId") as? UserAssignRoleViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.UpdateProfile.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UpdateProfileViewControllerId") as? UpdateProfileViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.ChangePassword.rawValue{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangePasswordViewControllerId") as? ChangePasswordViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == slideMenuList.Logout.rawValue{
            
            var frame : CGRect
            frame = self.slideMenuView.frame
            UIView.animate(withDuration: 1, animations: {
                self.slideMenuView.frame.origin.x = -frame.size.width
                self.transView.isHidden = true
            }) { _ in
                
            }
        }
        
    }
    
    
    
    
    
    
    // MARK: - ButtonActions
    @IBAction func slideMenuBtnAction(_ sender: UIButton) {
    
        self.transView.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            self.slideMenuView.frame.origin.x = 0
            self.slideMenuView.isHidden = false
        }) { _ in
            
        }
    }
    
    
    @IBAction func newApplicationBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageNewApplicationViewControllerId") as? ManageNewApplicationViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func updateApplicationBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageCustomerUpdateApplicantsViewControllerId") as? ManageCustomerUpdateApplicantsViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func homebtnAction(_ sender: UIButton) {
        
    }
    @IBAction func messagesBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageMessagesViewControllerId") as? ManageMessagesViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func outofStockbtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OutOfStockViewControllerId") as? OutOfStockViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func recentInvoiceBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecentInvoiceViewControllerId") as? RecentInvoiceViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func invoiceBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageInvoiceViewControllerId") as? ManageInvoiceViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func customerServiceBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerReceiveViewControllerId") as? CustomerReceiveViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func purchasebtnAction(_ sender: UIButton) {
        
    }
    
    
    @IBAction func oneDayBtnAction(_ sender: UIButton) {
    
        self.onedayView.backgroundColor = UIColor.init(red: 28/255, green: 96/255, blue: 174/255, alpha: 1)
        self.oneWeekView.backgroundColor = UIColor.white
        self.fourWeekView.backgroundColor = UIColor.white
        self.oneYearView.backgroundColor = UIColor.white
    }
    
    @IBAction func oneWeekBtnAction(_ sender: UIButton) {
        self.onedayView.backgroundColor = UIColor.white
        self.oneWeekView.backgroundColor = UIColor.init(red: 28/255, green: 96/255, blue: 174/255, alpha: 1)
        self.fourWeekView.backgroundColor = UIColor.white
        self.oneYearView.backgroundColor = UIColor.white
    }
    @IBAction func fourWeekBtnAction(_ sender: UIButton) {
        self.onedayView.backgroundColor = UIColor.white
        self.oneWeekView.backgroundColor = UIColor.white
        self.fourWeekView.backgroundColor = UIColor.init(red: 28/255, green: 96/255, blue: 174/255, alpha: 1)
        self.oneYearView.backgroundColor = UIColor.white
    }
    @IBAction func oneYearBtnAction(_ sender: UIButton) {
        self.onedayView.backgroundColor = UIColor.white
        self.oneWeekView.backgroundColor = UIColor.white
        self.fourWeekView.backgroundColor = UIColor.white
        self.oneYearView.backgroundColor = UIColor.init(red: 28/255, green: 96/255, blue: 174/255, alpha: 1)
    }
}
