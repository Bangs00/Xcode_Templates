//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_Localized")
    }
    
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func isValidPassword() -> Bool {
        // 비밀번호 규칙에 맞게 정규표현식 문자열 수정
        let regex = "^(?!((?:[A-Za-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Za-z\\d~!@#$%^&*()_+=]{8,128}$"
        let validation = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return validation.evaluate(with: self)
    }
}
