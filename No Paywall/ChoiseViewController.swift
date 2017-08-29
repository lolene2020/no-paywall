//
//  ChoiseViewController.swift
//  No Paywall
//
//  Created by Gustav Öst on 2017-08-29.
//  Copyright © 2017 Gustav Öst. All rights reserved.
//

import UIKit

class ChoiseViewController: UIViewController {


	@IBOutlet weak var diTouch: UITapGestureRecognizer!

	@IBOutlet var dnTouch: UITapGestureRecognizer!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func handleDiTap(recognizer: UITapGestureRecognizer) {
		openWebViewWithURL(url: "https://www.di.se")
	}
	@IBAction func handleDnTap(recognizer: UITapGestureRecognizer) {
		openWebViewWithURL(url: "https://www.dn.se")
	}
	func openWebViewWithURL(url: String) {
		let myVC = storyboard?.instantiateViewController(withIdentifier: "webView") as! ViewController!
		myVC?.URLPath = url
		navigationController?.pushViewController(myVC!, animated: true)
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
