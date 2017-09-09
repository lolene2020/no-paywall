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

	var URLPath = ""

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		loadAddressURL()
	}

	var lastLoadEvent = Date().addingTimeInterval(-1.1)

	func webViewDidFinishLoad(_ webView : UIWebView) {
		if (lastLoadEvent < Date().addingTimeInterval(-1)) {
			print("inject")
			if URLPath == "https://www.dn.se" {
				injectDNPaywallRemover()
			} else {
				injectDIPaywallRemover()
			}
		}
		lastLoadEvent = Date()
	}

	func loadAddressURL() {
		let requestURL = NSURL(string:URLPath)
		let request = NSURLRequest(url: requestURL! as URL)
		DNview.loadRequest(request as URLRequest)
	}

	func injectDIPaywallRemover() {
		injectStyleRules(styleFilename: "di-paywall-remover")
	}

	func injectDNPaywallRemover() {
		//injectStyleRules(styleFilename: "dn-paywall-remover")
		injectJavascriptFiles(filenames: ["addGlobalStyle"])
		injectCSSfile(filename: "dn")
	}

	func injectStyleRules(styleFilenames: [String]) {
		injectJavascriptFiles(filenames: ["addGlobalStyle"] + styleFilenames)
	}

	func injectStyleRules(styleFilename: String) {
		injectJavascriptFiles(filenames: ["addGlobalStyle"] + [styleFilename])
	}

	func injectJavascriptFiles(filenames: [String]) {
		for filename in filenames {
			let js = readJavascriptFile(filename: filename)
			DNview.stringByEvaluatingJavaScript(from: js)
		}
	}

	func injectCSSfile(filename: String) {
		let path = Bundle.main.path(forResource: filename, ofType: "css")
		if (path == nil) {
			return
		}
		let text = readTextFromFilePath(path: path!).replacingOccurrences(of: "\n", with: " ")
		if text != "" {
			DNview.stringByEvaluatingJavaScript(from: "addGlobalStyle('" + text + "');")
		}

	}

	func readJavascriptFile(filename: String) -> String {

		let path = Bundle.main.path(forResource: filename, ofType: "js")

		return readTextFromFilePath(path: path!)
	}

	func readTextFromFilePath( path: String ) -> String {
		var text = ""
		do {
			text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
		}
		catch {
			print(error)
		}
		return text
	}
}

