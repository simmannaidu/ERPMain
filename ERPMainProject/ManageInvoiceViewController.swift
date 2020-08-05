//
//  ManageInvoiceViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/23/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class ManageInvoiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var invoiceNOLabel: UILabel!
    @IBOutlet weak var invoiceIdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var invoiceButton: UIButton!
    @IBOutlet weak var minInvoiceButton: UIButton!
    @IBOutlet weak var posInvoiceButton: UIButton!
    @IBOutlet weak var updateButtonView: UIView!
    @IBOutlet weak var deleteButtonView: UIView!
    @IBOutlet weak var cellView: UIView!
    
    
}

class ManageInvoiceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var manageInvoiceTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageInvoiceTableView.delegate = self
        self.manageInvoiceTableView.dataSource = self
        self.transView.isHidden = true
        self.manageInvoiceTableView.tableFooterView =  UIView(frame: .zero)
        desien()
        
    }
    
    // MARK: - Desien
    func desien(){
        
        self.searchView.layer.borderWidth = 1
        self.searchView.layer.borderColor = UIColor.lightGray
    }
    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "ManageInvoiceTableViewCellId", for: indexPath) as! ManageInvoiceTableViewCell

        
        cell.invoiceButton.layer.cornerRadius = 4
        cell.minInvoiceButton.layer.cornerRadius = 4
        cell.posInvoiceButton.layer.cornerRadius = 4
        cell.updateButtonView.layer.cornerRadius = 4
        cell.deleteButtonView.layer.cornerRadius = 4
        

        cell.cellView.layer.shadowColor = UIColor.lightGray
       cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: - ButtonActions
    @IBAction func backBtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func invoiceBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func minInvoiceBtnAction(_ sender: UIButton) {
    }
    @IBAction func posInvoiceBtnAction(_ sender: UIButton) {
    }
    @IBAction func updateBtnAction(_ sender: UIButton) {
    }
    @IBAction func deleteBtnAction(_ sender: UIButton) {
    }
}
