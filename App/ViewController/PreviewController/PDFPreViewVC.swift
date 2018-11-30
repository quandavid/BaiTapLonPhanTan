//
//  PreViewViewController.swift
//  TinyBaseCore
//
//  Created by Quan Nguyen Dinh on 11/28/18.
//  Copyright © 2018 Quan Nguyen Dinh. All rights reserved.
//

import UIKit

class PDFPreViewVC: UIViewController {
    
    @IBOutlet fileprivate weak var webView: UIWebView!
    var url: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        let req = NSMutableURLRequest(url: url)
        req.timeoutInterval = 60.0
        req.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        webView.scalesPageToFit = true
        webView.loadRequest(req as URLRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc @IBAction fileprivate func close(_ sender: AnyObject!) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupWithURL(_ url: URL) {
        self.url = url
    }
    
}
