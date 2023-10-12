//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

struct ExampleViewModelActions {

}

protocol ExampleViewModelInput {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

protocol ExampleViewModelOutput {
    
}

protocol ExampleViewModel: ExampleViewModelInput, ExampleViewModelOutput { }

class DefaultExampleViewModel: ExampleViewModel {
    private let exampleUseCase: ExampleUseCase
    private let actions: ExampleViewModelActions?
    // MARK: - OUTPUT

    // MARK: - Init
    init(exampleUseCase: ExampleUseCase,
         actions: ExampleViewModelActions) {
        self.exampleUseCase = exampleUseCase
        self.actions = actions
    }
}

// MARK: - INPUT. View event methods
extension DefaultExampleViewModel {
    func viewDidLoad() {
        customLog("ExampleViewModelInput:: viewDidLoad")
    }

    func viewWillAppear() {
        customLog("ExampleViewModelInput:: viewWillAppear")
    }

    func viewDidAppear() {
        customLog("ExampleViewModelInput:: viewDidAppear")
    }

    func viewWillDisappear() {
        customLog("ExampleViewModelInput:: viewWillDisappear")
    }

    func viewDidDisappear() {
        customLog("ExampleViewModelInput:: viewDidDisappear")
    }
}

