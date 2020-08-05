//
//  CustomerHomeViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/26/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Charts


class CustomerSlideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var slideMenuImage: UIImageView!
    @IBOutlet weak var slideMenutitlelabel: UILabel!
}


class LatestproductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productUnitLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
}



class CustomerHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var verticalStackView: UIStackView!
    
    @IBOutlet weak var messageBadgeView: UIView!
    @IBOutlet weak var messageBadgeLabel: UILabel!
    
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view1SubView: UIView!
    @IBOutlet weak var view1ShadowView: UIView!
    @IBOutlet weak var view1TitleLabel: UILabel!
    @IBOutlet weak var view1LineLabel: UILabel!
    @IBOutlet weak var frequentlyProductOrdersPiView: PieChartView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view2SubView: UIView!
    @IBOutlet weak var view2titleLabel: UILabel!
    @IBOutlet weak var view2LineLabel: UILabel!
    @IBOutlet weak var view2ShadowView: UIView!
    @IBOutlet weak var view2pichartView: PieChartView!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view3SubView: UIView!
    @IBOutlet weak var view3TitleLabel: UILabel!
    @IBOutlet weak var view3LineLabel: UILabel!
    @IBOutlet weak var view3ShadowView: UIView!
    @IBOutlet weak var view3PichartView: PieChartView!
    
    @IBOutlet weak var latestproductsView: UIView!
    @IBOutlet weak var latestProductsSubView: UIView!
    @IBOutlet weak var latestproductTitleLabel: UILabel!
    @IBOutlet weak var latestproductLineLabel: UILabel!
    @IBOutlet weak var latestproductsTableView: UITableView!
    
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var slidemenuView: UIView!
    @IBOutlet weak var slidemenuTableView: UITableView!
    
    
    let SlideMenutitleNames = ["Dashboard","Place Order","manage Order","Customer Center","Manage Message","Logout"]
    //,"Update Profile","Change Password"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setVStackConstrains(mainView: self.view, scrollView: self.mainScrollView, subView: self.mainView, vStack: self.verticalStackView, topHeight: 75, bottomHeight: 0 , contantSize: CGSize(width: self.view.frame.size.width, height: 700.0))
        
        self.latestproductsTableView.delegate = self
        self.latestproductsTableView.dataSource = self
         self.latestproductsTableView.tableFooterView =  UIView(frame: .zero)
        
        self.slidemenuTableView.delegate = self
        self.slidemenuTableView.dataSource = self
        self.slidemenuTableView.tableFooterView =  UIView(frame: .zero)
       
        self.latestproductsTableView.tag = 1
        self.slidemenuTableView.tag = 2
        self.transView.isHidden = true
        self.slidemenuView.isHidden = true
        view1Pichart()
        view2Pichart()
        view3Pichart()
        
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideSlideMenu))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.transView?.addGestureRecognizer(mytapGestureRecognizer)
        
        Design()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideSlideMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         setup()
    }

    
    func Design()
    {
        self.messageBadgeView.layer.cornerRadius = self.messageBadgeView.frame.size.height / 2
    }
    
    
    func setup(){
        

        //Frequently Product's Orders Pichart View
        
        self.view1.heightAnchor.constraint(equalToConstant: 350.0).isActive = true
    
     self.view1SubView.frame = CGRect(x: 5, y: 5, width: self.view1.frame.size.width - 10, height: 340)
        self.view1TitleLabel.frame = CGRect(x: 12, y: 0, width: self.view1SubView.frame.size.width, height: 50)
        self.view1LineLabel.frame = CGRect(x: 0, y:self.view1TitleLabel.frame.size.height + self.view1TitleLabel.frame.origin.y , width: self.view1SubView.frame.size.width, height: 1)
        
         self.view1ShadowView.frame = CGRect(x: 15, y: self.view1LineLabel.frame.size.height + self.view1LineLabel.frame.origin.y + 15, width: self.view1SubView.frame.size.width - 30, height: 260)
        
        self.frequentlyProductOrdersPiView.frame = CGRect(x: 0, y: 0, width: self.view1ShadowView.frame.size.width , height: self.view1ShadowView.frame.size.height)
        
        self.view1SubView.layer.shadowColor = UIColor.lightGray
        self.view1SubView.layer.shadowOpacity = 1
        self.view1SubView.layer.masksToBounds = false
        self.view1SubView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.view1SubView.layer.shadowRadius = 2
       

        self.view1ShadowView.layer.shadowColor = UIColor.lightGray
        self.view1ShadowView.layer.shadowOpacity = 1
        self.view1ShadowView.layer.masksToBounds = false
        self.view1ShadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.view1ShadowView.layer.shadowRadius = 2

        

        //Product purchase By Other Customer's Pichart View
        
        self.view2.heightAnchor.constraint(equalToConstant: 350.0).isActive = true
        
        self.view2SubView.frame = CGRect(x: 5, y: 5, width: self.view2.frame.size.width - 10, height: 340)
        self.view2titleLabel.frame = CGRect(x: 12, y: 0, width: self.view2SubView.frame.size.width, height: 50)
        self.view2LineLabel.frame = CGRect(x: 0, y:self.view2titleLabel.frame.size.height + self.view2titleLabel.frame.origin.y , width: self.view2SubView.frame.size.width, height: 1)
        
        self.view2ShadowView.frame = CGRect(x: 15, y: self.view2LineLabel.frame.size.height + self.view2LineLabel.frame.origin.y + 15, width: self.view2SubView.frame.size.width - 30, height: 260)
        
        self.view2pichartView.frame = CGRect(x: 0, y: 0, width: self.view2ShadowView.frame.size.width , height: self.view2ShadowView.frame.size.height)
        
        self.view2SubView.layer.shadowColor = UIColor.lightGray
        self.view2SubView.layer.shadowOpacity = 1
        self.view2SubView.layer.masksToBounds = false
        self.view2SubView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.view2SubView.layer.shadowRadius = 2
        
        
        self.view2ShadowView.layer.shadowColor = UIColor.lightGray
        self.view2ShadowView.layer.shadowOpacity = 1
        self.view2ShadowView.layer.masksToBounds = false
        self.view2ShadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.view2ShadowView.layer.shadowRadius = 2
        
        
        //Last Order's Chart View
        
        self.view3.heightAnchor.constraint(equalToConstant: 350.0).isActive = true
        
        self.view3SubView.frame = CGRect(x: 5, y: 5, width: self.view3.frame.size.width - 10, height: 340)
        self.view3TitleLabel.frame = CGRect(x: 12, y: 0, width: self.view3SubView.frame.size.width, height: 50)
        self.view3LineLabel.frame = CGRect(x: 0, y:self.view3TitleLabel.frame.size.height + self.view3TitleLabel.frame.origin.y , width: self.view3SubView.frame.size.width, height: 1)
        
        self.view3ShadowView.frame = CGRect(x: 15, y: self.view3LineLabel.frame.size.height + self.view3LineLabel.frame.origin.y + 15, width: self.view3SubView.frame.size.width - 30, height: 260)
        
        self.view3PichartView.frame = CGRect(x: 0, y: 0, width: self.view3ShadowView.frame.size.width , height: self.view3ShadowView.frame.size.height)
        
        self.view3SubView.layer.shadowColor = UIColor.lightGray
        self.view3SubView.layer.shadowOpacity = 1
        self.view3SubView.layer.masksToBounds = false
        self.view3SubView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.view3SubView.layer.shadowRadius = 2
        
        
        self.view3ShadowView.layer.shadowColor = UIColor.lightGray
        self.view3ShadowView.layer.shadowOpacity = 1
        self.view3ShadowView.layer.masksToBounds = false
        self.view3ShadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.view3ShadowView.layer.shadowRadius = 2
        
        

        //Latest Products view
        self.latestproductsView.heightAnchor.constraint(equalToConstant: 350.0).isActive = true
        
        self.latestProductsSubView.frame = CGRect(x: 5, y: 5, width: self.latestproductsView.frame.size.width - 10, height: 340)
        self.latestproductTitleLabel.frame = CGRect(x: 12, y: 0, width: self.latestProductsSubView.frame.size.width, height: 50)
        self.latestproductLineLabel.frame = CGRect(x: 0, y:self.latestproductTitleLabel.frame.size.height + self.latestproductTitleLabel.frame.origin.y , width: self.view3SubView.frame.size.width, height: 1)
        
         self.latestproductsTableView.frame = CGRect(x: 0, y: self.latestproductLineLabel.frame.size.height + self.latestproductLineLabel.frame.origin.y + 15, width: self.latestproductLineLabel.frame.size.width, height: 275)
        
        self.latestProductsSubView.layer.shadowColor = UIColor.lightGray
        self.latestProductsSubView.layer.shadowOpacity = 1
        self.latestProductsSubView.layer.masksToBounds = false
        self.latestProductsSubView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.latestProductsSubView.layer.shadowRadius = 2
        
               
    }
    
    // MARK: - TableView Delegates and Datasources
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
             return 4
        }else{
             return self.SlideMenutitleNames.count
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1 {
            let cell = tableView .dequeueReusableCell(withIdentifier: "LatestproductsTableViewCellId", for: indexPath) as! LatestproductsTableViewCell
            
            cell.cellView.layer.shadowColor = UIColor.lightGray
            cell.cellView.layer.shadowOpacity = 1
            cell.cellView.layer.masksToBounds = false
            cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
            cell.cellView.layer.cornerRadius = 8
            
            return cell
        }else{
            let cell = tableView .dequeueReusableCell(withIdentifier: "CustomerSlideMenuTableViewCellId", for: indexPath) as! CustomerSlideMenuTableViewCell
            
            cell.slideMenutitlelabel.text = self.SlideMenutitleNames[indexPath.row]
            cell.slideMenuImage.image = UIImage(named: self.SlideMenutitleNames[indexPath.row])
            return cell
        }
        
      
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView.tag == 1 {
             return 105
        }else{
             return 50
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerHomeViewControllerId") as? CustomerHomeViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerManageCategoryViewControllerId") as? CustomerManageCategoryViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 2 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerManageOrderViewControllerId") as? CustomerManageOrderViewController
                      
                self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 3 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SlideMenuSubListsViewControllerId") as? SlideMenuSubListsViewController
            vc?.slidemenuSubListArray = ["Customer Information","Accounr Ledger","Support"]
            vc?.sublistTitelName = "CustomerCenter"
                      self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 4 {
            let vc = UIStoryboard.init(name: "sales", bundle: Bundle.main).instantiateViewController(withIdentifier: "SalesManageMessageVCId") as? SalesManageMessageVC
                  
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }else if indexPath.row == 5 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewControllerId") as? LoginViewController
            
                    self.navigationController?.pushViewController(vc!, animated: true)
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UpdateProfileViewControllerId") as? UpdateProfileViewController
//            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 6 {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewControllerId") as? LoginViewController
            
                    self.navigationController?.pushViewController(vc!, animated: true)
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangePasswordViewControllerId") as? ChangePasswordViewController
//             self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewControllerId") as? LoginViewController
            
                    self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    
    
    
    
    // MARK: - ButtonActions

    @IBAction func messageNotificationBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ManageMessagesViewControllerId") as? ManageMessagesViewController
              
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func slideMenuBtnAction(_ sender: UIButton) {
        self.transView.isHidden = false
        UIView.animate(withDuration: 1, animations: {
            self.slidemenuView.frame.origin.x = 0
            self.slidemenuView.isHidden = false
        }) { _ in
            
        }
    }
    
    
    
    @objc func hideSlideMenu()
    {
        var frame : CGRect
        frame = self.slidemenuView.frame
        UIView.animate(withDuration: 1, animations: {
            self.slidemenuView.frame.origin.x = -frame.size.width
            self.transView.isHidden = true
            self.slidemenuView.isHidden = true
        }) { _ in
            
        }
        
    }
    
    func view1Pichart()

    {
        self.frequentlyProductOrdersPiView.chartDescription?.enabled = false
        self.frequentlyProductOrdersPiView.drawHoleEnabled = false
        self.frequentlyProductOrdersPiView.rotationAngle = 0
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

        self.frequentlyProductOrdersPiView.data = PieChartData(dataSet: dataSet)

    }
    

    func view2Pichart()
        
    {
        self.view2pichartView.chartDescription?.enabled = false
        self.view2pichartView.drawHoleEnabled = false
        self.view2pichartView.rotationAngle = 0
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
        
        self.view2pichartView.data = PieChartData(dataSet: dataSet)
        
    }
    
    func view3Pichart()
        
    {
        self.view3PichartView.chartDescription?.enabled = false
        self.view3PichartView.drawHoleEnabled = false
        self.view3PichartView.rotationAngle = 0
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
        
        self.view3PichartView.data = PieChartData(dataSet: dataSet)
        
    }
    
    
}
