//
//  SalesReportViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/28/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class SalesReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var salesDateLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var invoiceNoLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
}

class SalesReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var salesReportTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    @IBOutlet weak var totalSalesView: UIView!
    @IBOutlet weak var totalSalesLabel: UILabel!
    @IBOutlet weak var noRecordsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.salesReportTableView.delegate = self
        self.salesReportTableView.dataSource = self
        self.transView.isHidden = true
        self.salesReportTableView.tableFooterView =  UIView(frame: .zero)
        
        self.salesReportTableView.isHidden = true
        self.totalSalesView.isHidden = true
        self.noRecordsLabel.isHidden = false
    }
    

    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "SalesReportTableViewCellId", for: indexPath) as! SalesReportTableViewCell
        
        
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
