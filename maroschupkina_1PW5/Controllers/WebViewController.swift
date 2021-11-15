//
//  WebViewController.swift
//  maroschupkina_1PW5
//
//  Created by Marina Roshchupkina on 15.11.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var url: URL?
    private var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView()
        view.addSubview(webView)
        webView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        webView.pinRight(to: view)
        webView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        webView.pinLeft(to: view)
        
        self.webView = webView
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
    
    
}
