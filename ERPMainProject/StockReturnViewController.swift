//
//  StockReturnViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/27/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class StockReturnTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellview: UIView!
    @IBOutlet weak var invoiceIdLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var deleteView: UIView!
}
class StockReturnViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var stockReturnTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    var dataForTableView = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.stockReturnTableView.delegate = self
        self.stockReturnTableView.dataSource = self
        self.transView.isHidden = true
        self.stockReturnTableView.tableFooterView =  UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        let cell = tableView .dequeueReusableCell(withIdentifier: "StockReturnTableViewCellId", for: indexPath) as! StockReturnTableViewCell
        
        let item = self.dataForTableView[indexPath.row]
//          cell.name.text = "Product Name : \(item[""] ?? "")"
//          cell.productModellabel.text = "Product Model : \(item["product_model"] ?? "")"
//              //cell..text = "Unit : \(item["unit"] ?? "")"
//          cell.inQntyLabel.text = "In Qnty : \(item["SubTotalIn"] ?? "")"
//          cell.stockLabel.text = "Stock : \(item["stok_quantity_cartoon"] ?? "")"
//        //  cell.salePriceLabel.text = "Sale Price : \(item["sales_price"] ?? "")"
//          cell.outQntyLabel.text = "Out Qnty : \(item["SubTotalOut"] ?? "")"
//          cell.stockSalesPriceLabel.text = "Stock Sales Price: \(item["total_sale_price"] ?? "")"
//
        
       // let item = self.dataForTableView[indexPath.row]
        cell.invoiceIdLabel.text = "Invoice Id : \(item["invoice_id"] ?? "")"
        cell.categoryNameLabel.text = "Customer Name : \(item["customer_name"] ?? "")"
        cell.dateLabel.text = "Date : \(item["date_return"] ?? "")"
        cell.amountLabel.text = "Total Amount : $\(item["total_ret_amount"] ?? "")"
        
        cell.cellview.layer.shadowColor = UIColor.lightGray
        cell.cellview.layer.shadowOpacity = 1
        cell.cellview.layer.masksToBounds = false
        cell.cellview.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellview.layer.cornerRadius = 8
        
        
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
    @IBAction func deleteButtonAction(_ sender: UIButton) {
    }
    // MARK: - NETWORK
    func getDataForManageCustomer()
    {
     
        /*{
        "customer_id":"1",
        "dtpFromDate":"2019-09-04",
        "dtpToDate":"2019-06-04",
        "search":"1"
        }*/
        self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        //http://lanciusit.com/demo/erpapi/api/returnlist
        let url : URL = URL(string: BaseUrl + "/returnlist")!
        let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
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
                               self.dataForTableView = items["return_list"] as! [NSDictionary]
                                if self.dataForTableView.count == 0
                                {
                                    Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                }
                                self.stockReturnTableView.reloadData()
                                } catch let parsingError {
                                   print("Error", parsingError)
                              }
                           // let dataFromServer =
                        }
            }
                    }
        }
}
