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
			if URLPath == "https://www.dn.se" {
				injectCSSfile(filename: "dn")
			} else if URLPath == "https://www.di.se" {
				injectCSSfile(filename: "di")
			}
		}
		lastLoadEvent = Date()
	}

	func loadAddressURL() {
		let requestURL = NSURL(string:URLPath)
		let request = NSURLRequest(url: requestURL! as URL)
		DNview.loadRequest(request as URLRequest)
	}

	func injectJavascriptFile(filename: String) {
		let js = readJavascriptFile(filename: filename)
		DNview.stringByEvaluatingJavaScript(from: js)
	}

	func injectJavascriptFiles(filenames: [String]) {
		for filename in filenames {
			injectJavascriptFile(filename: filename)
		}
	}

	func injectCSSfile(filename: String) {
		let path = Bundle.main.path(forResource: filename, ofType: "css")
		if (path == nil) {
			return
		}
		let text = readTextFromFilePath(path: path!).replacingOccurrences(of: "\n", with: " ")
		if text != "" {
			let globalStyle = DNview.stringByEvaluatingJavaScript(from: "addGlobalStyle()")
			if globalStyle != "installed" {
				injectJavascriptFile(filename: "addGlobalStyle")
			}

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

