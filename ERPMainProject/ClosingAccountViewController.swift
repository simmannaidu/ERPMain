//
//  ClosingAccountViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/24/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class ClosingAccountViewController: UIViewController {

    @IBOutlet weak var closingAccountView: UIView!
    @IBOutlet weak var dayClosing: UIButton!
    
    @IBOutlet weak var cashInHandView: UIView!
    @IBOutlet weak var thousendRsPcsTF: UITextField!
    @IBOutlet weak var fiveHunderedRsPcsTF: UITextField!
    @IBOutlet weak var hunderedRsPcsTF: UITextField!
    @IBOutlet weak var fiftyRsPcsTF: UITextField!
    @IBOutlet weak var twentyRsPcsTF: UITextField!
    @IBOutlet weak var tenRsPcsTF: UITextField!
    @IBOutlet weak var fiveRsPcsTF: UITextField!
    @IBOutlet weak var twoRsPcsTF: UITextField!
    @IBOutlet weak var oneRsPcsTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        desien()
    }
    

    // MARK: - Desien
    func desien(){
        
        self.closingAccountView.layer.shadowColor = UIColor.lightGray
        self.closingAccountView.layer.shadowOpacity = 1
        self.closingAccountView.layer.masksToBounds = false
        self.closingAccountView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.cashInHandView.layer.shadowColor = UIColor.lightGray
        self.cashInHandView.layer.shadowOpacity = 1
        self.cashInHandView.layer.masksToBounds = false
        self.cashInHandView.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.thousendRsPcsTF.layer.borderWidth = 1
        self.thousendRsPcsTF.layer.borderColor = UIColor.lightGray
        self.fiveHunderedRsPcsTF.layer.borderWidth = 1
        self.fiveHunderedRsPcsTF.layer.borderColor = UIColor.lightGray
        self.hunderedRsPcsTF.layer.borderWidth = 1
        self.hunderedRsPcsTF.layer.borderColor = UIColor.lightGray
        self.fiftyRsPcsTF.layer.borderWidth = 1
        self.fiftyRsPcsTF.layer.borderColor = UIColor.lightGray
        self.twentyRsPcsTF.layer.borderWidth = 1
        self.twentyRsPcsTF.layer.borderColor = UIColor.lightGray
        self.tenRsPcsTF.layer.borderWidth = 1
        self.tenRsPcsTF.layer.borderColor = UIColor.lightGray
        self.fiveRsPcsTF.layer.borderWidth = 1
        self.fiveRsPcsTF.layer.borderColor = UIColor.lightGray
        self.twoRsPcsTF.layer.borderWidth = 1
        self.twoRsPcsTF.layer.borderColor = UIColor.lightGray
        self.oneRsPcsTF.layer.borderWidth = 1
        self.oneRsPcsTF.layer.borderColor = UIColor.lightGray
        
        self.dayClosing.layer.cornerRadius = 8
        
    }
   

}
