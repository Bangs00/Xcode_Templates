//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

final class UserDefaultsExampleStorage {
    init() { }
}

extension UserDefaultsExampleStorage: ExampleStorage {
    func clear() {
        UserDefaultsStorage.exampleEntity = nil
    }
    
    func storeExampleEntity(exampleEntity: ExampleEntityUDS?) {
        UserDefaultsStorage.exampleEntity = exampleEntity
    }
    
    func loadExampleEntity() -> ExampleEntity? {
        return UserDefaultsStorage.exampleEntity?.toDomain()
    }
}
