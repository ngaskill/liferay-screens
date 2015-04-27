/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/
import UIKit
import LiferayScreens


class SignInViewController: CardViewController, LoginScreenletDelegate, ForgotPasswordScreenletDelegate {

	@IBOutlet weak var scroll: UIScrollView!
	@IBOutlet weak var forgotTitle: UIButton!
	@IBOutlet weak var backArrow: UIImageView!

	@IBOutlet weak var loginScreenlet: LoginScreenlet!
	@IBOutlet weak var forgotPasswordScreenlet: ForgotPasswordScreenlet!


	override init(card: CardView, nibName: String) {
		let save = card.minimizedHeight
		card.minimizedHeight = 0
		super.init(card: card, nibName: nibName)
		card.minimizedHeight = save
	}

	convenience init(card: CardView) {
		self.init(card: card, nibName:"SignInViewController")
	}

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func viewDidLoad() {
		scroll.contentSize = CGSizeMake(scroll.frame.size.width * 2, scroll.frame.size.height)

		self.loginScreenlet.delegate = self
		self.forgotPasswordScreenlet.delegate = self

		self.forgotPasswordScreenlet.anonymousApiUserName =
				LiferayServerContext.valueForKey("anonymousUsername") as? String
		self.forgotPasswordScreenlet.anonymousApiPassword =
				LiferayServerContext.valueForKey("anonymousPassword") as? String
	}

	override func viewWillAppear(animated: Bool) {
		if cardView!.button!.superview !== scroll {
			cardView!.button!.removeFromSuperview()
			scroll.addSubview(cardView!.button!)
		}
	}

	@IBAction func backAction(sender: AnyObject) {
		UIView.animateWithDuration(0.3,
				animations: {
					self.forgotTitle.alpha = 0.0
					self.backArrow.alpha = 0.0
				},
				completion: nil)

		let newRect = CGRectMake(0, 0, scroll.frame.size)
		scroll.scrollRectToVisible(newRect, animated: true)
	}

	@IBAction func forgotPasswordAction(sender: AnyObject) {
		self.forgotTitle.alpha = 0.0
		self.backArrow.alpha = 0.0

		UIView.animateWithDuration(1.0,
				animations: {
					self.forgotTitle.alpha = 1.0
					self.backArrow.alpha = 1.0
				},
				completion: nil)

		let newRect = CGRectMake(scroll.frame.size.width, 0, scroll.frame.size)
		scroll.scrollRectToVisible(newRect, animated: true)
	}

	func onLoginResponse(attributes: [String:AnyObject]) {
		onDone?()
	}

	func onLoginError(error: NSError) {
	}

	func onForgotPasswordResponse(newPasswordSent:Bool) {
		backAction(self)
	}

	func onForgotPasswordError(error: NSError) {
	}

	override func cardWillAppear() {
		NSNotificationCenter.defaultCenter().addObserver(self,
				selector: "showKeyboard:",
				name: UIKeyboardWillChangeFrameNotification,
				object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self,
				selector: "hideKeyboard:",
				name: UIKeyboardWillHideNotification,
				object: nil)
	}

	override func cardWillDisappear() {
		NSNotificationCenter.defaultCenter().removeObserver(self,
				name: UIKeyboardWillHideNotification,
				object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self,
				name: UIKeyboardWillChangeFrameNotification,
				object: nil)
	}

	func showKeyboard(notif: NSNotification) {
		if cardView?.currentState == .Normal {
			cardView?.nextState = .Maximized
			cardView?.changeToNextState()
		}
	}

	func hideKeyboard(notif: NSNotification) {
		if cardView?.currentState == .Maximized {
			cardView?.nextState = .Normal
			cardView?.changeToNextState()
		}
	}

}
