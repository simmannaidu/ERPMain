//
//  CustomerManageCategoryViewController.swift
//  CygenERP
//
//  Created by Kardas Veeresham on 11/26/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import Alamofire
class CustomerManageCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
}

class CustomerManageCategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var dataForCollectionView = [NSDictionary]()
    @IBOutlet weak var manageCategoryCollectionView: UICollectionView!
    @IBOutlet weak var searchTFView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.manageCategoryCollectionView.delegate = self
        self.manageCategoryCollectionView.dataSource = self
        
        Design()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getDataFromServer()
    }

    func Design(){
        self.searchTFView.layer.cornerRadius = 4
        self.searchTFView.layer.borderWidth = 1
    //    self.searchTFView.layer.borderColor = (UIColor.darkGray as! CGColor)
        
    }
    
    
    
    // MARK: - CollectionView Delegate And DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataForCollectionView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomerManageCategoryCollectionViewCellId", for: indexPath) as! CustomerManageCategoryCollectionViewCell
        let item = self.dataForCollectionView[indexPath.row]
        /*{
            "cat_image" = 0;
            "category_id" = UCDK4LJM7PRF85H;
            "category_name" = MACHINE;
            id = 40;
            status = 1;
        }*/
        cell.categoryNameLabel.text = "\(item["category_name"] ?? "")"
        cell.categoryImage.imageFromServerURL(image: item["cat_image"] as! String)
        print("image url = %@",item["cat_image"] as! String)
        cell.cellView.layer.shadowColor = UIColor.lightGray
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.cellView.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width: self.manageCategoryCollectionView.frame.width / 2 - 6, height:160 )
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*{
            "cat_image" = 0;
            "category_id" = UCDK4LJM7PRF85H;
            "category_name" = MACHINE;
            id = 40;
            status = 1;
        }*/
        let item = self.dataForCollectionView[indexPath.row]
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerManageProductViewControllerId") as? CustomerManageProductViewController
        vc?.catId = item["category_id"] as! String
                self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    // MARK: - ButtonAction
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //http://infysmart.com/erpapi/api/categoryList/0
    //MARK :- Network
        func getDataFromServer()
           {
               let url : URL = URL(string:BaseUrl + "/categoryList/0")!
                   let headers: HTTPHeaders =  ["X-API-KEY":"81dc9bdb52d04dc20036dbd8313ed055"]
                       
                       AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                           print(response.request as Any)  // original URL request
                           print(response.response as Any)// URL response
                           let response1 = response.response
                           if response1?.statusCode == 200
                           {
                                do{
                                    let jsonRespone = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                                   print(jsonRespone)
                                    let item = jsonRespone as NSDictionary
                                    self.dataForCollectionView = item["category_list"] as! [NSDictionary]
                                    if self.dataForCollectionView.count == 0
                                    {
                                        Alert.showBasic(titte: "Sorry", massage: "No records found", vc: self)
                                    }
                                    self.manageCategoryCollectionView.reloadData()
                                        //as! [NSDictionary]

                                   } catch let parsingError {
                                      print("Error", parsingError)
                                 }
                              // let dataFromServer =
                           }
                       }
           }
}

