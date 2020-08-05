//
//  SuccessViewController.swift
//  AyerERP
//
//  Created by Hari on 21/12/19.
//  Copyright © 2019 Lancius. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func showHomeBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "CustomerHomeViewControllerId") as? CustomerHomeViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

}
