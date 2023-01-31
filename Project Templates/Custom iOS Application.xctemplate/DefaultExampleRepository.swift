//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

final class DefaultExampleRepository {
    private let networkService: NetworkService
    private let storage: ExampleStorage
    
    init(networkService: NetworkService,
         storage: ExampleStorage) {
        self.networkService = networkService
        self.storage = storage
    }
}

extension DefaultExampleRepository: ExampleRepository {
    
}
