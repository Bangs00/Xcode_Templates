//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

protocol ExampleFlowCoordinatorDependencies {
    func makeExampleViewController(actions: ExampleViewModelActions) -> ExampleViewController
}

final class ExampleFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: ExampleFlowCoordinatorDependencies
    
    private weak var exampleVC: ExampleViewController?
    
    init(navigationController: UINavigationController,
         dependencies: ExampleFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = ExampleViewModelActions()
        let vc = dependencies.makeExampleViewController(actions: actions)
        
        navigationController?.setViewControllers([vc], animated: false)
        exampleVC = vc
    }
    
    // VieModelActions에 주입해서 화면 전환
    private func startExample() {
        let actions = ExampleViewModelActions()
        let vc = dependencies.makeExampleViewController(actions: actions)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
