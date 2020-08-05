//
//  PurchaseReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/28/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class PurchaseReportTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var salesDateLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var invoiceNameLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!

}

class PurchaseReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var purchaseReportTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var totalPurchaseLabel: UILabel!
    @IBOutlet weak var totalPurchaseView: UIView!
    @IBOutlet weak var noRecordsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.purchaseReportTableView.delegate = self
        self.purchaseReportTableView.dataSource = self
        self.transView.isHidden = true
        self.purchaseReportTableView.tableFooterView =  UIView(frame: .zero)
        
        
        self.purchaseReportTableView.isHidden = true
        self.totalPurchaseView.isHidden = true
        self.noRecordsLabel.isHidden = false
    }
    

    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "PurchaseReportTableViewCellId", for: indexPath) as! PurchaseReportTableViewCell
        
        
                cell.cellView.layer.shadowColor = UIColor.lightGray
                cell.cellView.layer.shadowOpacity = 1
                cell.cellView.layer.masksToBounds = false
                cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
                cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
