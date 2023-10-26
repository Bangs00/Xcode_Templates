//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

class BasicTableView: UITableView {
    override var intrinsicContentSize: CGSize {
		let number = numberOfRows(inSection: 0)
		var height: CGFloat = 0

		for i in 0..<number {
			guard let cell = cellForRow(at: IndexPath(row: i, section: 0)) else {
				continue
			}
			height += cell.bounds.height
		}
		return CGSize(width: contentSize.width, height: height)
	}
	
	override func layoutSubviews() {
		self.invalidateIntrinsicContentSize()
		super.layoutSubviews()
	} 
}