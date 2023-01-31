//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

final class ExampleSceneDIContainer {
    struct Dependencies {
        let apiNetworkService: NetworkService
    }
    
    private let dependencies: Dependencies
    
    // MARK: - Persistent Storage
    lazy var exampleStorage: ExampleStorage = UserDefaultsExampleStorage()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Case
    func makeExampleUseCase() -> ExampleUseCase {
        return DefaultExampleUseCase(exampleRepository: makeExampleRepository())
    }
    
    // MARK: - Repositories
    func makeExampleRepository() -> ExampleRepository {
        return DefaultExampleRepository(networkService: dependencies.apiNetworkService,
                                      storage: exampleStorage)
    }
    
    // MARK: - Example
    func makeExampleViewController(actions: ExampleViewModelActions) -> ExampleViewController {
        return ExampleViewController.create(with: makeExampleViewModel(actions: actions))
    }
    
    func makeExampleViewModel(actions: ExampleViewModelActions) -> ExampleViewModel {
        return DefaultExampleViewModel(exampleUseCase: makeExampleUseCase(),
                                       actions: actions)
    }
    
    // MARK: - Flow Coordinators
    func makeExampleFlowCoordinator(navigationController: UINavigationController) -> ExampleFlowCoordinator {
        return ExampleFlowCoordinator(navigationController: navigationController,
                                      dependencies: self)
    }
}

extension ExampleSceneDIContainer: ExampleFlowCoordinatorDependencies { }
