//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

protocol ExampleUseCase {
    
}

final class DefaultExampleUseCase: ExampleUseCase {
    private let exampleRepository: ExampleRepository
    
    init(exampleRepository: ExampleRepository) {
        self.exampleRepository = exampleRepository
    }
    
}
