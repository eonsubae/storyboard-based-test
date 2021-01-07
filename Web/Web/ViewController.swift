//
//  ViewController.swift
//  Web
//
//  Created by KRITSSEAN on 2021/01/07.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadWebPage("http://google.com")
    }


    @IBAction func btnGotoUrl(_ sender: UIButton) {
    }
    
    @IBAction func btnGoSite1(_ sender: UIButton) {
    }
    
    
    @IBAction func btnGoSite2(_ sender: UIButton) {
    }
    
    
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
    }
    
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
    }
    
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
    }
    
}

