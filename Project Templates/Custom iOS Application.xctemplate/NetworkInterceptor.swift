//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation
// Depend on Alamofire, RxSwift
import Alamofire
import RxSwift

public final class DefaultRequestInterceptor: RequestInterceptor {
    public init() { }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("📔 ADAPT 📔")
        var urlRequest = urlRequest
        // Set Header
        urlRequest.setValue("application/json; charset=UTF-8",
                            forHTTPHeaderField: "Content-Type")

        #if DEBUG
        print("\(urlRequest.headers)")
        #endif

        completion(.success(urlRequest))
        print("📔 ADAPT END 📔")
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < 3 else {
            completion(.doNotRetry)
            return
        }
        print("========== RETRY COUNT: \(request.retryCount) ==========")
        // vvv Retry somethings here vvv
        
        refreshAccessToken { result in
            print("========== RETRY COUNT: \(request.retryCount) END ==========")
            if result {
                completion(.retryWithDelay(1))
            } else {
                UserDefaultsStorage.clear()
                completion(.doNotRetryWithError(error))
            }
        }
    }
}

extension DefaultRequestInterceptor {
    // PRIVATE METHODS HERE ex) refresh token etc...
    private struct RefreshAccessTokenResponseDTO: Decodable {
        let rt: Int
        let rtMsg: String
        let accessToken: String
    }
    
    private func refreshAccessToken(completion: @escaping ((Bool) -> Void)) {
        
    }
}
// MARK: - DataRequest Extensions
extension ObservableType where Element == DataRequest {
//    func validateBodyStatusCode() -> Observable<Element> {
//      return map { $0.validateBodyStatusCode() }
//    }
}

extension DataRequest {
//    public func validateBodyStatusCode() -> Self {
//        return validate { _, response, data in
//            do {
//                let responseData: BODY_RESPONSE_DTO = try JSONDecoder().decode(BODY_RESPONSE_DTO.self, from: data!)
//                switch responseData.STATUS_CODE {
//                case EXPIRED_STATUS_CODE: // Token expired
//                    return .failure(NetworkError.unacceptedBodyStatusCode(code: responseData.rt, description: "Token expired"))
//                default:
//                    break
//                }
//                return .success(())
//            } catch let error {
//                print("Json serialization error \(error)")
//                let reason: AFError.ResponseValidationFailureReason = .unacceptableStatusCode(code: response.statusCode)
//                return .failure(AFError.responseValidationFailed(reason: reason))
//            }
//        }
//    }
}

