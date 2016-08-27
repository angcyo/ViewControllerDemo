//
//  TestViewController.swift
//  ViewControllerDemo
//
//  Created by angcyo on 16/08/27.
//  Copyright © 2016年 angcyo. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

	@IBOutlet weak var tipOutlet: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */

	override func viewWillAppear(animated: Bool) {
		check(onPush: { nav in
			self.title = "On Push"
			self.tipOutlet.text = "On Push"
			}, onPresent: {
			self.tipOutlet.text = "On Present"
			}
		)
	}

	@IBAction func onDismissTapped() {
		check(onPush: { nav in
			nav.popViewControllerAnimated(true)
			}, onPresent: {
			self.dismissViewControllerAnimated(true, completion: {
				print("dismiss completion")
			})
		})
	}

	func check(onPush onPush: (UINavigationController) -> (), onPresent: () -> ()) {
		if let nav = navigationController {
			onPush(nav)
		} else {
			onPresent()
		}
	}

}
