//
//  ViewController.swift
//  WebView
//
//  Created by User on 2021/08/02.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var WebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "" //write your URL
        if let url = URL(string: urlString){
            WebView.load(URLRequest(url: url))
        }
    }
}

