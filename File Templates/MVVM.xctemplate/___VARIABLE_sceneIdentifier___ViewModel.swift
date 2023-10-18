//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

struct ___VARIABLE_sceneIdentifier___ViewModelActions {

}

protocol ___VARIABLE_sceneIdentifier___ViewModelInput {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

protocol ___VARIABLE_sceneIdentifier___ViewModelOutput {
    
}

protocol ___VARIABLE_sceneIdentifier___ViewModel: ___VARIABLE_sceneIdentifier___ViewModelInput, ___VARIABLE_sceneIdentifier___ViewModelOutput { }

class Default___VARIABLE_sceneIdentifier___ViewModel: ___VARIABLE_sceneIdentifier___ViewModel {
    private let actions: ___VARIABLE_sceneIdentifier___ViewModelActions?
    // MARK: - OUTPUT

    // MARK: - Init
    init(actions: ___VARIABLE_sceneIdentifier___ViewModelActions) {
        self.actions = actions
    }
}

// MARK: - INPUT. View event methods
extension Default___VARIABLE_sceneIdentifier___ViewModel {
    func viewDidLoad() {
        customLog("___VARIABLE_sceneIdentifier___ViewModelInput:: viewDidLoad")
    }

    func viewWillAppear() {
        customLog("___VARIABLE_sceneIdentifier___ViewModelInput:: viewWillAppear")
    }

    func viewDidAppear() {
        customLog("___VARIABLE_sceneIdentifier___ViewModelInput:: viewDidAppear")
    }

    func viewWillDisappear() {
        customLog("___VARIABLE_sceneIdentifier___ViewModelInput:: viewWillDisappear")
    }

    func viewDidDisappear() {
        customLog("___VARIABLE_sceneIdentifier___ViewModelInput:: viewDidDisappear")
    }
}
