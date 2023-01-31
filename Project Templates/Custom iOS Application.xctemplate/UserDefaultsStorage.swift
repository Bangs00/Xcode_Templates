//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

struct UserDefaultsStorage {
    private enum UserDefaultsKey: String {
        case exampleEntity
    }
    
//    @UserDefaultWrapper(key: UserDefaultsKey.(KEY_NAME).rawValue, defaulitValue: nil)
//    static var SOMETHING: SOMETHING_UDS?
    @UserDefaultsWrapper(key: UserDefaultsKey.exampleEntity.rawValue, defaultValue: nil)
    static var exampleEntity: ExampleEntityUDS?
    
    static func clear() {
        self.exampleEntity = nil
    }
}

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T?
    
    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let loadedObject = try? decoder.decode(T.self, from: savedData) {
                    return loadedObject
                }
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
}
