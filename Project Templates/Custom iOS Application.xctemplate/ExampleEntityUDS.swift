//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

// MARK: - Example
struct ExampleEntityUDS: Codable {
    let identifier: Int
}

extension ExampleEntityUDS {
    init(example: ExampleEntity) {
        identifier = example.identifier
    }
    
    func toDomain() -> ExampleEntity {
        return .init(identifier: identifier)
    }
}
