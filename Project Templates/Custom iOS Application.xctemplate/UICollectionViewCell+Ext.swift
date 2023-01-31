//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    static func fromNib() -> Self {
        let nib = UINib(nibName: String(describing: self), bundle: nil)
        print("\(String(describing: self))")
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            return self.fromNib()
        }
        return view
    }
}
