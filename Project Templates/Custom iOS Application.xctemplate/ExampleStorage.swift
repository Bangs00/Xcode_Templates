//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

protocol ExampleStorage {
    func clear()
    
    func storeExampleEntity(exampleEntity: ExampleEntityUDS?)
    
    func loadExampleEntity() -> ExampleEntity?
}
