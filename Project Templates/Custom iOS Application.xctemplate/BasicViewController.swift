//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit
import MessageUI

class BasicViewController: UIViewController {
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .darkContent
	}
	
	private var scrollViewForKeyboard: UIScrollView?
	
	func addObserverForScrollViewToAddKeybarodInset(for scrollView: UIScrollView) {
		self.scrollViewForKeyboard = scrollView
		
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillShow),
											   name: UIResponder.keyboardWillShowNotification,
											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillHide),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
	}
	
	@objc private func keyboardWillShow(notification: NSNotification) {
		guard let userInfo = notification.userInfo else { return }
		var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		keyboardFrame = self.view.convert(keyboardFrame, from: nil)
		
		var contentInset: UIEdgeInsets = self.scrollViewForKeyboard?.contentInset ?? .zero
		contentInset.bottom = keyboardFrame.size.height
		self.scrollViewForKeyboard?.contentInset = contentInset
	}
	
	@objc private func keyboardWillHide(notification: NSNotification) {
		let contentInset: UIEdgeInsets = UIEdgeInsets.zero
		
		self.scrollViewForKeyboard?.contentInset = contentInset
	}
	
	func showMailComposeViewController(to address: String, subject: String, body: String, errorCompletion: (() -> Void)? = nil) {
		guard MFMailComposeViewController.canSendMail() else {
			self.showAlertPopover(content: "메일을 보낼 수 없습니다.\n메일 설정을 확인해주세요.", confirmAction: nil)
			return
		}
		
		let composeVC = MFMailComposeViewController()
		composeVC.mailComposeDelegate = self
		
		composeVC.setToRecipients([address])
		composeVC.setSubject(subject)
		composeVC.setMessageBody(body, isHTML: true)
		
		self.present(composeVC, animated: true)
	}
}

extension BasicViewController: MFMailComposeViewControllerDelegate {
	public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
}