//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

extension UIViewController {
    static func vc<T: UIViewController>(class: T.Type? = nil) -> T? {
		guard let appDelegate = UIApplication.shared.delegate,
			  let window = appDelegate.window else { return nil }
		
		if let vc = window?.rootViewController as? T {
			return vc
		} else if let vc = window?.rootViewController?.presentedViewController as? T {
			return vc
		} else if let vc = window?.rootViewController?.children {
			return vc.lazy.compactMap({ $0 as? T }).first
		}
		
		return nil
	}
	
	func scrollToTop() {
		self.scrollToTop(in: self.view)
	}
	
	private func scrollToTop(in view: UIView) {
		for subview in view.subviews {
			if let tableView = subview as? UITableView {
				tableView.setContentOffset(.init(x: tableView.contentOffset.x,
												 y: 0 - tableView.contentInset.top),
										   animated: true)
				for subview in tableView.subviews {
					scrollToTop(in: subview)
				}
			} else if let collectionView = subview as? UICollectionView {
				collectionView.setContentOffset(.init(x: collectionView.contentOffset.x,
													  y: 0 - collectionView.contentInset.top),
												animated: true)
				for subview in collectionView.subviews {
					scrollToTop(in: subview)
				}
			} else if let scrollView = subview as? UIScrollView {
				scrollView.setContentOffset(.init(x: scrollView.contentOffset.x,
												  y: 0 - scrollView.contentInset.top),
											animated: true)
			} else {
				scrollToTop(in: subview)
			}
		}
	}
}