//
//  ViewController.swift
//  No Paywall
//
//  Created by Gustav Öst on 2017-08-29.
//  Copyright © 2017 Gustav Öst. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

	@IBOutlet weak var DNview: UIWebView!

	var URLPath = "https://www.dn.se"

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		loadAddressURL()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func webViewDidFinishLoad(_ webView : UIWebView) {
		injectDNPaywallRemover()
	}

	func loadAddressURL() {
		let requestURL = NSURL(string:URLPath)
		let request = NSURLRequest(url: requestURL! as URL)
		DNview.loadRequest(request as URLRequest)
	}

	func injectDNPaywallRemover() {
		let filenames = ["addGlobalStyle", "dn-paywall-remover"]
		for filename in filenames {
			let js = readJavascriptFile(filename: filename)
			DNview.stringByEvaluatingJavaScript(from: js)
		}
	}

	func readJavascriptFile(filename: String) -> String {
		var text = ""
		let path = Bundle.main.path(forResource: filename, ofType: "js")
		do {
			text = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
		}
		catch {
			print(error)
		}
		return text
	}
}

