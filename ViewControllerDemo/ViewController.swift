//
//  ViewController.swift
//  ViewControllerDemo
//
//  Created by angcyo on 16/08/27.
//  Copyright © 2016年 angcyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var testViewController: UIViewController!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		testViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TestViewController")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func onPushTappend() {
		navigationController?.delegate = nil
		navigationController?.pushViewController(testViewController, animated: true)
	}

	@IBAction func onPresentTappend() {
		testViewController.transitioningDelegate = nil
		presentViewController(testViewController, animated: true, completion: {
			print("present completion")
		})
	}

	@IBAction func onPushAnimationTappend(sender: AnyObject) {
		navigationController?.delegate = self
		navigationController?.pushViewController(testViewController, animated: true)

	}

	@IBAction func onPresentAnimationTappend(sender: AnyObject) {
		testViewController.transitioningDelegate = self
		presentViewController(testViewController, animated: true, completion: {
			print("present completion")
		})
	}

}

//MARK: 实现push/pop的动画
extension ViewController: UINavigationControllerDelegate {
	func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		print("\(navigationController) \(operation.rawValue)")

		if operation == .Push {
			return CustomPushAnimation()
		}

		if operation == .Pop {
			return CustomPopAnimation()
		}

		return nil
	}
}

//MARK: Push 动画
class CustomPushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		print("\(#function)")

		transitionContext.containerView()?.backgroundColor = UIColor.whiteColor() // 修改过渡时的背景颜色

		let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
		let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!

		transitionContext.containerView()?.insertSubview(toViewController.view, aboveSubview: fromViewController.view)

		toViewController.view.transform = CGAffineTransformMakeTranslation(width, height)
//		toViewController.view.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(-100, -100), CGAffineTransformMakeScale(2, 2))
		UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
			toViewController.view.transform = CGAffineTransformIdentity
			fromViewController.view.transform = CGAffineTransformMakeTranslation(-width, -height)
		}) { (completion) in
			fromViewController.view.transform = CGAffineTransformIdentity
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
		}
	}
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		print("\(#function)")
		return 0.3
	}
}

//MARK: Pop动画
class CustomPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {

	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		transitionContext.containerView()?.backgroundColor = UIColor.whiteColor() // 修改过渡时的背景颜色

		let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
		let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!

		transitionContext.containerView()?.insertSubview(toViewController.view, belowSubview: fromViewController.view)

		toViewController.view.transform = CGAffineTransformMakeTranslation(-width, -height)
		UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
			toViewController.view.transform = CGAffineTransformIdentity
			fromViewController.view.transform = CGAffineTransformMakeTranslation(width, height)
		}) { (completion) in
			fromViewController.view.transform = CGAffineTransformIdentity
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
		}
	}
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 0.3
	}
}

//MARK: 实现Present动画
extension ViewController: UIViewControllerTransitioningDelegate {

	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		print("\(presented.title) \(presenting.title) \(source.title)")
		return CustomPresentAnimation()
	}

	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		print("\(dismissed.title)")
		return CustomDismissAnimation()
	}

}

//MARK: Present动画
class CustomPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {

	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		transitionContext.containerView()?.backgroundColor = UIColor.whiteColor() // 修改过渡时的背景颜色

		let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
		let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!

		transitionContext.containerView()?.insertSubview(toViewController.view, belowSubview: fromViewController.view)

		// 1:
//		toViewController.view.transform = CGAffineTransformMakeTranslation(0, height)
//		UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
//			toViewController.view.transform = CGAffineTransformIdentity
//			fromViewController.view.transform = CGAffineTransformMakeTranslation(0, -height)
//		}) { (completion) in
//			fromViewController.view.transform = CGAffineTransformIdentity
//			transitionContext.completeTransition(completion)
//		}

		// 2:
//		toViewController.view.frame.offsetInPlace(dx: 0, dy: height)
//		UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
//			toViewController.view.frame.offsetInPlace(dx: 0, dy: -height)
//			fromViewController.view.frame.offsetInPlace(dx: 0, dy: -height)
//		}) { completion in
//			fromViewController.view.frame.offsetInPlace(dx: 0, dy: height)
//			transitionContext.completeTransition(completion)
//		}

		// 3:
		toViewController.view.center.y = 3 * height / 2
		UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
			toViewController.view.center.y = height / 2
			fromViewController.view.center.y = -height / 2
		}) { completion in
			transitionContext.completeTransition(completion)
		}
	}
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 0.3
	}
}

//MARK: Dismiss动画
class CustomDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {

	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		transitionContext.containerView()?.backgroundColor = UIColor.whiteColor() // 修改过渡时的背景颜色

		let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
		let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!

		transitionContext.containerView()?.insertSubview(toViewController.view, belowSubview: fromViewController.view)

		// 1:
//		toViewController.view.transform = CGAffineTransformMakeTranslation(0, -height)
//		UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
//			toViewController.view.transform = CGAffineTransformIdentity
//			fromViewController.view.transform = CGAffineTransformMakeTranslation(0, height)
//		}) { (completion) in
//			fromViewController.view.transform = CGAffineTransformIdentity
//			transitionContext.completeTransition(completion)
//		}

		// 2:
//		toViewController.view.frame.offsetInPlace(dx: 0, dy: -height)
//		UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
//			toViewController.view.frame.offsetInPlace(dx: 0, dy: height)
//			fromViewController.view.frame.offsetInPlace(dx: 0, dy: height)
//		}) { completion in
//			fromViewController.view.frame.offsetInPlace(dx: 0, dy: -height)
//			transitionContext.completeTransition(completion)
//		}

		// 3:
		toViewController.view.center.y = -height / 2
		UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
			toViewController.view.center.y = height / 2
			fromViewController.view.center.y = 3 * height / 2
		}) { completion in
			transitionContext.completeTransition(completion)
		}
	}
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 0.3
	}
}

let width = UIScreen.mainScreen().bounds.width
let height = UIScreen.mainScreen().bounds.height

