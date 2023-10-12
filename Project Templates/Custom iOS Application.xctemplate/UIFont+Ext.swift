//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

extension UIFont {
    enum FontWeight: Int {
        case regular = 400
        case light = 300
        case medium = 500
        case semibold = 600
        case bold = 700
    }
    
    static func appleSDGothic(_ weight: FontWeight = .regular, size: CGFloat = 18.0) -> UIFont {
        let fontName = {
            switch weight {
            case .regular:
                return "AppleSDGothicNeo-Regular"
            case .light:
                return "AppleSDGothicNeo-Light"
            case .medium:
                return "AppleSDGothicNeo-Medium"
            case .semibold:
                return "AppleSDGothicNeo-SemiBold"
            case .bold:
                return "AppleSDGothicNeo-Bold"
            }
        }()
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}