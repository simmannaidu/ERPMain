//
//  StringExtention.swift
//  SwiftlearningProject
//
//  Created by Kardas Veeresham on 2/8/19.
//  Copyright © 2019 lancius. All rights reserved.
//

import Foundation
import UIKit


//MARK: - EmailValidation



extension String{
    
    var isValidEmail : Bool {
        let emailFormate = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailpradicate = NSPredicate(format: "SELF MATCHES %@", emailFormate)
        return emailpradicate.evaluate(with:self)
    }
    
    var isValidZipCode : Bool {
        let emailFormate = "[A-Z0-9a-z._-]"
        let emailpradicate = NSPredicate(format: "SELF MATCHES %@", emailFormate)
        return emailpradicate.evaluate(with:self)
    }
    
    var isValidPassword : Bool {
        let emailFormate = "[A-Z0-9a-z._%+-]"
        let emailpradicate = NSPredicate(format: "SELF MATCHES %@", emailFormate)
        return emailpradicate.evaluate(with:self)
    }
    
    var isValidPhoneNumber : Bool{
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
         let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        return phoneTest.evaluate(with:self)
    }
    
}

//MARK: - Alert only Ok Button

class Alert  {
    class func showBasic(titte:String, massage:String, vc:UIViewController ){
        let alert = UIAlertController(title: titte, message: massage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert,animated: true)
        
    }

}


//MARK: - UIAlert   ok and Cancel button
extension UIView
{
    
}
extension UIViewController
{
    func popUpAlert(title: String, message: String, actionTitle: [String],actionStyle: [UIAlertAction.Style], action:[((UIAlertAction) -> Void)]){
        let alert = UIAlertController(title: title, message: message, preferredStyle:  .alert)
        for (index,title) in actionTitle.enumerated(){
            let action = UIAlertAction(title: title, style: actionStyle[index], handler: action[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    func toSetBorderColorForView(view : UIView , color : UIColor , Width : CGFloat , cornerRadius : CGFloat) -> UIView
    {
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = Width
        view.layer.cornerRadius = cornerRadius
        return view
    }
    // Alert Implementation
    
//                self.popUpAlert(title: "Alert", message: "In Valid Email ", actionTitle: ["OK","Cancel"], actionStyle: [.default, .cancel ], action: [
//                    { ok in
//                      print("press Ok")
//                    },
//                    { cancel in
//                        print("press Cancel")
//                    }])
    
    
    
    // VerticalStckView
    func setVStackConstrains(mainView : UIView, scrollView : UIScrollView, subView : UIView, vStack : UIStackView, topHeight : CGFloat, bottomHeight : CGFloat , contantSize : CGSize){
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: topHeight).isActive = true
       // scrollView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        scrollView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: contantSize.height).isActive = true
        scrollView.contentSize = contantSize
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        //subView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        subView.heightAnchor.constraint(equalToConstant: contantSize.height).isActive = true
        subView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        subView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        subView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        subView.backgroundColor = .black
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.topAnchor.constraint(equalTo: subView.topAnchor, constant: 0).isActive = true
        vStack.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: bottomHeight).isActive = true
        vStack.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 0).isActive = true
        vStack.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: 0).isActive = true
        vStack.backgroundColor = .red
        //vStack.heightAnchor.constraint(equalToConstant: contantSize.height).isActive = true
        vStack.axis  = NSLayoutConstraint.Axis.vertical
        vStack.distribution  = UIStackView.Distribution.fill
        vStack.alignment = UIStackView.Alignment.fill
        vStack.spacing   = 0
    }
    //using
    // setVStackConstrains(mainView: self.view, scrollView: self.mainScrollView, subView: self.mainView, vStack: self.verticalStackView, topHeight: 20, bottomHeight: -5)    //implement on nowytor commingsoon viewcontroller



    
    
}


//MARK: - hidekeyboardWhenTappedArround

extension UIViewController
{
    func hidekeyboardWhenTappedArround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBord))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyBord(){
        view.endEditing(true)
    }
    
    
    
    func showActivityIndicatory(view : UIView , isStart : Bool , transView : UIView) {
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.center = self.view.center
        transView.addSubview(activityView)
        transView.backgroundColor = UIColor.init(red: 93, green: 94, blue: 96, a: 1.0)
        
        transView.frame = view.frame
        view.addSubview(transView)
        if isStart
        {
            activityView.startAnimating()
            transView.isHidden = false
        }else
        {
            activityView.stopAnimating()
            // transView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            transView.isHidden = true
        }
        
        
        // activityView.startAnimating()
    }
    
    
    // MARK: - EmptyText
    func textFieldDidBeginEditingOne(_ textField: UITextField) {
        textField.text = ""
    }
    
    // implemenatation
    // self.hidekeyboardWhenTappedArround()
}



//MARK: - UIColor

extension UIColor {
    
    static let customGreen = UIColor(hex: 009459)
    static let transparantBlack = UIColor(hex: 0x000000, a: 0.5)
    static let lightGray = UIColor.init(red: 145.0/255, green: 145.0/255, blue: 145.0/255, alpha: 1).cgColor
    static let customBlue = UIColor.init(red: 41.0/255, green: 121.0/255, blue: 255.0/255, alpha: 1).cgColor
     static let lightGrayBG = UIColor.init(red: 145.0/255, green: 145.0/255, blue: 145.0/255, alpha: 1)
    static let customBlueBG = UIColor.init(red: 41.0/255, green: 121.0/255, blue: 255.0/255, alpha: 1)
    convenience init(red: Int, green: Int, blue: Int, a:CGFloat = 1.0){
        
        self.init(
            red: CGFloat(red)/255.0,
            green: CGFloat(green)/255.0,
            blue: CGFloat(blue)/255.0,
            alpha: a
            
        )
    }
    
    convenience init(hex: Int, a: CGFloat = 1.0){
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
}


//MARK: - String Replace

extension String
{
    func replace(target: String, withString: String) -> String{
        return self.replacingOccurrences(of: target, with: withString)
    }
    
    // implemenatation
    // let newString = "the old bike".replace(target: "old", withString: "new")
    
}

// MARK: - fontSizes
extension UITextField {
    func setSizeFont (font: String, sizeFont: Double) {
        self.font =  UIFont(name: font, size: CGFloat(sizeFont))
        self.sizeToFit()
    }
    func setDarkModeToNormal()
    {
        if #available(iOS 13, *) {
        self.overrideUserInterfaceStyle = .light
        }
        else
        {
            
        }
    }
}
extension UITextView
{
  func setDarkModeToNormal()
    {
        if #available(iOS 13, *) {
        self.overrideUserInterfaceStyle = .light
        }
        else
        {
            
        }
    }
}

//MARK: - ImageFromServerURL
extension UIImageView {
    public func imageFromServerURL( image : String)
    {
        let imageUrlString = image.replacingOccurrences(of: " ", with: "%20")
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: imageUrlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
    
}

