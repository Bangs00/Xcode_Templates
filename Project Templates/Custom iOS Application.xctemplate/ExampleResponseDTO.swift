//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

// MARK: - Data Transfer Object
struct ExampleResponseDTO: Decodable {
    let identifier: Int
}

extension ExampleResponseDTO {
    func toDomain() -> ExampleEntity {
        return .init(identifier: identifier)
    }
}
