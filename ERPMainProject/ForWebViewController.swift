//
//  ForWebViewController.swift
//  AyersERP
//
//  Created by Hari on 02/12/19.
//  Copyright © 2019 infinity Smart Solutions. All rights reserved.
//

import UIKit
import WebKit
class ForWebViewController: UIViewController , WKNavigationDelegate , UIWebViewDelegate{
var webView : WKWebView!
    var transView = UIView()
var forViewUrl = String()
    
    @IBOutlet weak var forWebView: UIView!
    override func viewDidLoad() {
        self.transView.frame = CGRect(x: 0, y: 65, width: self.view.frame.size.width, height: self.view.frame.size.height )
        
        self.transView.isHidden = true
            let myWebView:UIWebView = UIWebView(frame: CGRect(x:0, y:90, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height - 95))
        
            self.view.addSubview(myWebView)
        self.view.addSubview(self.transView)
            
        myWebView.delegate = self
            
            //1. Load web site into my web view
            let myURL = URL(string:forViewUrl)
        //"http://lanciusit.com/demo_erp/arrayelectrical/Cinvoice/invoice_webview/316.5")
                //forViewUrl) //"http://ayersfood.com/erp_beta/Cinvoice/quotations_webview/7127995769")
            let myURLRequest:URLRequest = URLRequest(url: myURL!)
            myWebView.loadRequest(myURLRequest)
            
    }
        
        func webViewDidStartLoad(_ webView: UIWebView)
        {
             self.showActivityIndicatory(view: self.view, isStart: true, transView: self.transView)
        }
        func webViewDidFinishLoad(_ webView: UIWebView)
        {
            self.showActivityIndicatory(view: self.view, isStart: false, transView: self.transView)
        }
//        super.viewDidLoad()
//        let url = NSURL(string:"www.google.com")
//            //"http://ayersfood.com/erp_beta/Cinvoice/quotations_webview/7127995769")
//            //forViewUrl)
//        let request = NSURLRequest(url: url! as URL)        // init and load request in webview.
//        webView = WKWebView(frame: self.forWebView.frame)
//        webView.navigationDelegate = self
//        webView.load(request as URLRequest)
//        self.view.addSubview(webView)
//        self.view.sendSubviewToBack(webView)
//        // Do any additional setup after loading the view.
//    }

    @IBAction func sendBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    /*class TrainingVideosViewController: UIViewController ,WKNavigationDelegate{
    var webView : WKWebView!
        override func viewDidLoad() {
            super.viewDidLoad()        let myBlog = "https://nowytor.com/privacyPolicy"
            let url = NSURL(string: myBlog)
            let request = NSURLRequest(url: url! as URL)        // init and load request in webview.
            webView = WKWebView(frame: self.view.frame)
            webView.navigationDelegate = self
            webView.load(request as URLRequest)
            self.view.addSubview(webView)
            self.view.sendSubviewToBack(webView)
        }}*/

}
