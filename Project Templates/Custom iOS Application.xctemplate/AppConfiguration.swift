//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import UIKit

final class AppConfiguration {
    //        lazy var apiKey: String = {
    //            guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
    //                fatalError("ApiKey must not be empty in plist")
    //            }
    //            return apiKey
    //        }()
    
    // API URL 설정시 아래 절차를 따라주세요.
    // 1. 'Info.plist'파일에 ["ApiBaseURL": "$(API_BASE_URL)"] 프로퍼티를 추가해주세요.
    //      (추가시 프로젝트 파일 > 메인 타겟 > 'Info'탭 > 'Custom iOS Target Properties' 항목에 출력됩니다.)
    // 2. 프로젝트 메인 타겟에서 빌드 세팅에 'User-Defined'항목에 'API_BASE_URL'설정을 추가해주세요.
    //      (추가적으로 프로젝트 스키마에 따른 API URL을 설정하실 수 있습니다.)
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
    
    //        lazy var imagesBaseURL: String = {
    //            guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as? String else {
    //                fatalError("ApiBaseURL must not be empty in plist")
    //            }
    //            return imageBaseURL
    //        }()
}
