//
//  ViewController.swift
//  WebViewSample
//
//  Created by Chen Xiaohan on 2021/9/6.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate {
    //定义可选类型不是应该？吗
    //是自动解析的意思，自动展开
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
//        self.webView.uiDelegate = self
    }
    //同步
    @IBAction func testLoadHTMLString(_ sender: Any) -> () {
//        //bundle作用？
        let htmlPath = Bundle.main.path(forResource: "index", ofType: "html")
        let bundleUrl = NSURL.fileURL(withPath: Bundle.main.bundlePath)
//
        do {
//            let html = try String(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
            let html = try String.init(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8)
            self.webView.loadHTMLString(html as String, baseURL: bundleUrl)
        } catch let err {
            err.localizedDescription
        }
        
    }
    //同步
    @IBAction func testLoadData(_ sender: Any) {
        let htmlPath = Bundle.main.path(forResource: "index1", ofType: "html")
        let bundleUrl = URL.init(fileURLWithPath: Bundle.main.bundlePath)
        let htmlData = NSData(contentsOfFile: htmlPath!)
//        let htmlData = Data(contentsOfFile: htmlPath!)
        
        self.webView.load(htmlData! as Data, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: bundleUrl)
    }
    
    //异步
    @IBAction func testLoadRequest(_ sender: Any) {
        let url = URL(string: "https://www.baidu.com/")
        let request = URLRequest(url: url!)
        self.webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("加载失败", error)
    }
}
