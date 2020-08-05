//
//  SupplierwiseStockReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class SupplierwiseStockReportTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productModellabel: UILabel!
    @IBOutlet weak var inQntyLabel: UILabel!
    @IBOutlet weak var outQntyLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var stockSalesPriceLabel: UILabel!
}

class SupplierwiseStockReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
var dataForTableView = [NSDictionary]()
    @IBOutlet weak var supplierWiseStockReportTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var TotalAmountView: UIView!
    @IBOutlet weak var totalInQntyLabel: UILabel!
    @IBOutlet weak var totalOutQntyLabel: UILabel!
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var totalStockSalePriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.supplierWiseStockReportTableView.delegate = self
        self.supplierWiseStockReportTableView.dataSource = self
        self.transView.isHidden = true
        self.supplierWiseStockReportTableView.tableFooterView =  UIView(frame: .zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.getDataForManageCustomer()
        if CheckInternet.Connection(){
                               self.getDataForManageCustomer()
                           }else{
                               Alert.showBasic(titte: "Alert", massage: "Your device is not connection with internet", vc: self)
                           }
    }
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataForTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "SupplierwiseStockReportTableViewCellId", for: indexPath) as! SupplierwiseStockReportTableViewCell
        
        
                cell.cellView.layer.shadowColor = UIColor.lightGray
                cell.cellView.layer.shadowOpacity = 1
                cell.cellView.layer.masksToBounds = false
                cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        /*{
            "product_name": "SHREDDED COCONUT",
            "product_id": "1020",
            "price": "46",
            "product_model": "ARTPL100",
            "totalSalesQnty": "49",
            "totalPurchaseQnty": "3100",
            "date": "2019-10-08",
            "sl": 1,
            "stok_quantity_cartoon": 3051,
            "SubTotalOut": 49,
            "SubTotalIn": 3100,
            "SubTotalStock": 3051,
            "SubTotalinQnty": 3100,
            "total_sale_price": 140346,
            "SubTotaloutQnty": 49
        }*/
        let item = self.dataForTableView[indexPath.row]
        cell.productNameLabel.text = "Product Name : \(item[""] ?? "")"
        cell.productModellabel.text = "Product Model : \(item["product_model"] ?? "")"
            //cell..text = "Unit : \(item["unit"] ?? "")"
        cell.inQntyLabel.text = "In Qnty : \(item["SubTotalIn"] ?? "")"
        cell.stockLabel.text = "Stock : \(item["stok_quantity_cartoon"] ?? "")"
      //  cell.salePriceLabel.text = "Sale Price : \(item["sales_price"] ?? "")"
        cell.outQntyLabel.text = "Out Qnty : \(item["SubTotalOut"] ?? "")"
        cell.stockSalesPriceLabel.text = "Stock Sales Price: \(item["total_sale_price"] ?? "")"
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
//MARK:- NETWORK
    func getDataForManageCustomer()
    {
     
        /*{
        "customer_id":"1",
        "dtpFromDate":"2019-09-04",
        "dtpToDate":"2019-06-04",
        "search":"1"
        }*/
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
        let url : URL = URL(string: BaseUrl + "/stockreportsupplierwise")!
        //let headerData = ["customer_id":USERID,"dtpFromDate":"", "dtpToDate":"","search":"1"]
                AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
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
                           self.dataForTableView = items["stok_report"] as! [NSDictionary]
                            if self.dataForTableView.count == 0
                            {
                                Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                            }
                            self.dateLabel.text = "Date :\(items["date"] ?? "")"
                            self.totalStockLabel.text = "Total Stock : \(items["sub_total_stock"] ?? "")"
                            self.totalInQntyLabel.text = "Total In Stock : \(items["sub_total_in"] ?? "")"
                            self.totalOutQntyLabel.text = "Total Out Stock : \(items["sub_total_out"] ?? "")"
                            self.totalStockSalePriceLabel.text = "Stock Sales Price :\(items["sub_total_stock"] ?? "") "
                            self.supplierWiseStockReportTableView.reloadData()
                           // UserDefaults.standard.set(jsonRespone, forKey: "USERDETAILS")
                            } catch let parsingError {
                               print("Error", parsingError)
                          }
                       // let dataFromServer =
                    }
                }
        }
    }

}
