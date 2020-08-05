//
//  UpdateSttingsViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 10/31/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit

class UpdateSttingsViewController: UIViewController {

    @IBOutlet weak var companyLogoView: UIView!
    @IBOutlet weak var companyLogobrowserButton: UIButton!
    @IBOutlet weak var invoiceLogoView: UIView!
    @IBOutlet weak var invoiceBrowserButton: UIButton!
    @IBOutlet weak var faviIconView: UIView!
    @IBOutlet weak var faviBrowserButoon: UIButton!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencyTF: UITextField!
    @IBOutlet weak var currencyPositionView: UIView!
    @IBOutlet weak var currencyPostionTF: UITextField!
    @IBOutlet weak var footerTextView: UIView!
    @IBOutlet weak var footerTextTF: UITextField!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var languageTF: UITextField!
    @IBOutlet weak var ltrRtrView: UIView!
    @IBOutlet weak var lrtRtrTF: UITextField!
    @IBOutlet weak var capchaView: UIView!
    @IBOutlet weak var capchaTF: UITextField!
    @IBOutlet weak var capchaSiteKeyView: UIView!
    @IBOutlet weak var captchaSiteKeyTF: UITextField!
    @IBOutlet weak var captchSecretKeyView: UIView!
    @IBOutlet weak var captchaSecreatKeyTF: UITextField!
    @IBOutlet weak var discountTypeView: UIView!
    @IBOutlet weak var discountTypeTF: UITextField!
    @IBOutlet weak var updateProfileButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        Design()
    }
    

    func Design()
    {
        self.companyLogoView.layer.borderWidth = 1
        self.companyLogoView.layer.borderColor = UIColor.lightGray
        self.companyLogoView.layer.cornerRadius = 8
        
        self.invoiceLogoView.layer.borderWidth = 1
        self.invoiceLogoView.layer.borderColor = UIColor.lightGray
        self.invoiceLogoView.layer.cornerRadius = 8
        
        self.faviIconView.layer.borderWidth = 1
        self.faviIconView.layer.borderColor = UIColor.lightGray
        self.faviIconView.layer.cornerRadius = 8
        
        self.currencyView.layer.borderWidth = 1
        self.currencyView.layer.borderColor = UIColor.lightGray
        self.currencyView.layer.cornerRadius = 8
        
        self.currencyPositionView.layer.borderWidth = 1
        self.currencyPositionView.layer.borderColor = UIColor.lightGray
        self.currencyPositionView.layer.cornerRadius = 8
        
        self.footerTextView.layer.borderWidth = 1
        self.footerTextView.layer.borderColor = UIColor.lightGray
        self.footerTextView.layer.cornerRadius = 8
        
        self.languageView.layer.borderWidth = 1
        self.languageView.layer.borderColor = UIColor.lightGray
        self.languageView.layer.cornerRadius = 8
        
        self.ltrRtrView.layer.borderWidth = 1
        self.ltrRtrView.layer.borderColor = UIColor.lightGray
        self.ltrRtrView.layer.cornerRadius = 8
        
        self.capchaView.layer.borderWidth = 1
        self.capchaView.layer.borderColor = UIColor.lightGray
        self.capchaView.layer.cornerRadius = 8
        
        self.capchaSiteKeyView.layer.borderWidth = 1
        self.capchaSiteKeyView.layer.borderColor = UIColor.lightGray
        self.capchaSiteKeyView.layer.cornerRadius = 8
        
        self.captchSecretKeyView.layer.borderWidth = 1
        self.captchSecretKeyView.layer.borderColor = UIColor.lightGray
        self.captchSecretKeyView.layer.cornerRadius = 8
        
        self.discountTypeView.layer.borderWidth = 1
        self.discountTypeView.layer.borderColor = UIColor.lightGray
        self.discountTypeView.layer.cornerRadius = 8
        
        self.updateProfileButton.layer.cornerRadius = 8
        self.companyLogobrowserButton.layer.cornerRadius = 8
        self.invoiceBrowserButton.layer.cornerRadius = 8
        self.faviBrowserButoon.layer.cornerRadius = 8
        
        
    }
    
   
    // MARK: - ButtonActions

    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func updateProfileBtnAction(_ sender: UIButton) {
    }
}
