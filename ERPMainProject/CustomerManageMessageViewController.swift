//
//  CustomerManageMessageViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/28/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit


class CustomerManageMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}

class CustomerManageMessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var manageMessageTableView: UITableView!
    @IBOutlet weak var transView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageMessageTableView.delegate = self
        self.manageMessageTableView.dataSource = self
        self.transView.isHidden = true
        self.manageMessageTableView.tableFooterView =  UIView(frame: .zero)
    }
    

    
    // MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "CustomerManageMessageTableViewCellId", for: indexPath) as! CustomerManageMessageTableViewCell
        
        
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        
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

}
