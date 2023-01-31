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
        print("ExampleViewModelInput:: viewDidLoad")
    }

    func viewWillAppear() {
        print("ExampleViewModelInput:: viewWillAppear")
    }

    func viewDidAppear() {
        print("ExampleViewModelInput:: viewDidAppear")
    }

    func viewWillDisappear() {
        print("ExampleViewModelInput:: viewWillDisappear")
    }

    func viewDidDisappear() {
        print("ExampleViewModelInput:: viewDidDisappear")
    }
}

