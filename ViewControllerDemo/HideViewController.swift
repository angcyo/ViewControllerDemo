//
//  HideViewController.swift
//  ViewControllerDemo
//
//  Created by angcyo on 16/08/28.
//  Copyright © 2016年 angcyo. All rights reserved.
//

import UIKit

class HideViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		navigationItem.leftBarButtonItem = editButtonItem()
		let label = UILabel()
		label.backgroundColor = UIColor.blueColor()
		label.textColor = UIColor.whiteColor()
		label.text = "Hello"
		label.sizeToFit()
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: label)
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

	@IBAction func onHideNavitagionBar() {
		UIView.anim {
			self.navigationController?.navigationBar.hidden = true
		}
	}

	@IBAction func onHideTabBar() {
		UIView.anim {
			self.tabBarController?.tabBar.hidden = true
		}
	}

	@IBAction func onShowNavigationBar(sender: AnyObject) {
		UIView.anim {
			self.navigationController?.navigationBar.hidden = false
		}
	}

	@IBAction func onShowTabBar(sender: AnyObject) {
		UIView.anim {
			self.tabBarController?.tabBar.hidden = false
		}
	}
}

extension UIView {
	class func anim(block: () -> ()) {
		UIView.animateWithDuration(0.3) {
			block()
		}
	}
}
