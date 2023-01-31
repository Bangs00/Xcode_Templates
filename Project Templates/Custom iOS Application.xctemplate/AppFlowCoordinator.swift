//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let exampleSceneDIContainer = appDIContainer.makeExampleSceneDIContainer()
        let flow = exampleSceneDIContainer.makeExampleFlowCoordinator(navigationController: navigationController)
        navigationController.navigationBar.isHidden = true
        flow.start()
    }
}
