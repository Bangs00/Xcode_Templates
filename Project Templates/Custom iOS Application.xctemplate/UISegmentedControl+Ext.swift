//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

extension UISegmentedControl {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State, barMetrics metrics: UIBarMetrics) {
        self.clipsToBounds = true
        
        self.setBackgroundImage(color.toImage(), for: state, barMetrics: metrics)
    }
}