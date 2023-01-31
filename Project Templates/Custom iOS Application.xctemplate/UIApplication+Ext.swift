//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

extension UIApplication {
    static let CFBundleShortVersionString = "CFBundleShortVersionString"
    
    static func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: CFBundleShortVersionString) as! String
    }
    
    static func buildVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    static let keyWindow = {
        return UIApplication
            .shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })
    }()
}
