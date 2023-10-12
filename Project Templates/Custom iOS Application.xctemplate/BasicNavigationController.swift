//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

class BasicNavigationController: UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}