//

//

import UIKit
import WebKit


class WebPageViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var web_link = ""
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: web_link)!
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: url))
            self.webView.allowsBackForwardNavigationGestures = true
        }
    }
}
