//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

extension TimeInterval {
    var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1))*1000)
    }
    
    var seconds: Int {
        return Int(self)%60
    }
    
    var minutes: Int {
        return (Int(self)/60)%60
    }
    
    var hours: Int {
        return Int(self)/3600
    }
    
    var days: Int {
        return Int(self)/86400
    }
}
