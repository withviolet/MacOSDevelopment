//
//  DetailViewController.swift
//  TreeNavigation
//
//  Created by Chen Xiaohan on 2021/9/24.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate,WKUIDelegate {
    var url:String!
    var webView: WKWebView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(self.webView)
        self.webView.navigationDelegate = self
        
        let url = URL(string: self.url)
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }
    
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        print("in")
//    }
//    
//    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
////        if(challenge.protectionSpace.authenticationMethod)
//    }
    

}
