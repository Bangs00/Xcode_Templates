//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

final class AppDIContainer {
    lazy var appConfiguration = AppConfiguration()
    
    // MARK: - Network
    lazy var apiNetworkService: NetworkService = {
        let config = ApiDataNetworkConfig(baseURL: URL(string: self.appConfiguration.apiBaseURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!,
                                          headers: [:],
                                          queryParameters: [:])
        return DefaultNetworkService(config: config)
    }()
    
    // MARK: - DIContainers of scenes
    func makeExampleSceneDIContainer() -> ExampleSceneDIContainer {
        let dependencies = ExampleSceneDIContainer.Dependencies(apiNetworkService: apiNetworkService)
        return ExampleSceneDIContainer(dependencies: dependencies)
    }
}
