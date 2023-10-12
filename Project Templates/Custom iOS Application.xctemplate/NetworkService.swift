//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation
// Depend on Alamofire, RxSwift, RxAlamofire
import Alamofire
import RxSwift
import RxAlamofire

public enum NetworkError: Error {
    case requestEmpty
    case responseEmpty
    case dataEmpty
    case pasingData
    case urlGeneration
    case unacceptedBodyStatusCode(code: Int, description: String)
    case uploadFailure
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .requestEmpty:
            return ""
        case .responseEmpty:
            return ""
        case .dataEmpty:
            return ""
        case .pasingData:
            return ""
        case .urlGeneration:
            return ""
        case .unacceptedBodyStatusCode(code: let code, description: let description):
            switch code {
//            case UNACCEPTED_STATUS_CODE:
//                return description
            default:
                return "\(code)"
            }
        case .uploadFailure:
            return ""
        }
    }
}

public protocol NetworkService {
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E) -> Observable<T> where E.Response == T
}

public protocol NetworkErrorResolver {
    func resolve(error: AFError) -> Error
    func resolve(error: NetworkError) -> Error
}

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol NetworkErrorLogger {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}

public final class DefaultNetworkService {
    private let config: NetworkConfigurable
    private let interceptor: RequestInterceptor
    private let errorResolver: NetworkErrorResolver
    private let errorLogger: NetworkErrorLogger
    
    public init(config: NetworkConfigurable,
                interceptor: RequestInterceptor = DefaultRequestInterceptor(),
                errorResolver: NetworkErrorResolver = DefaultNetworkErrorResolver(),
                errorLogger: NetworkErrorLogger = DefaultNetworkErrorLogger()) {
        self.config = config
        self.interceptor = interceptor
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }
}

// MARK: - Implementation
extension DefaultNetworkService: NetworkService {
    public func request<T, E>(with endpoint: E) -> Observable<T> where T: Decodable, T == E.Response, E: ResponseRequestable {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return AF.rx.request(urlRequest: urlRequest, interceptor: interceptor)
                .debug("\(T.self)", trimOutput: false)
//                .validateBodyStatusCode()
                .responseJSON()
                .observe(on: MainScheduler.instance)
                .map({ request in
                    if let error = request.error {
                        let resolvedError = self.errorResolver.resolve(error: error)
                        self.errorLogger.log(error: resolvedError)
                        throw resolvedError
                    }
                    
                    guard let originRequest = request.request else {
                        let resolvedError = self.errorResolver.resolve(error: NetworkError.requestEmpty)
                        self.errorLogger.log(error: resolvedError)
                        throw resolvedError
                    }
                    guard let response = request.response else {
                        let resolvedError = self.errorResolver.resolve(error: NetworkError.responseEmpty)
                        self.errorLogger.log(error: resolvedError)
                        throw resolvedError
                    }
                    guard let data = request.data else {
                        let resolvedError = self.errorResolver.resolve(error: NetworkError.dataEmpty)
                        self.errorLogger.log(error: resolvedError)
                        throw resolvedError
                    }
                    
                    self.errorLogger.log(request: originRequest)
                    self.errorLogger.log(responseData: data, response: response)
                    
                    do {
                        let result: T = try endpoint.responseDecoder.decode(data)
                        return result
                    } catch {
                        let resolvedError = self.errorResolver.resolve(error: NetworkError.pasingData)
                        self.errorLogger.log(error: resolvedError)
                        throw resolvedError
                    }
                })
        } catch {
            return Observable.create({ observer in
                let resolvedError = self.errorResolver.resolve(error: NetworkError.urlGeneration)
                observer.onError(resolvedError)
                self.errorLogger.log(error: resolvedError)
                return Disposables.create()
            })
        }
    }
}

// MARK: - Error Resolver
public final class DefaultNetworkErrorResolver: NetworkErrorResolver {
    public init() { }
    
    public func resolve(error: AFError) -> Error {
        return error
    }
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}

// MARK: - Error Logger
public final class DefaultNetworkErrorLogger: NetworkErrorLogger {
    public init() { }
    
    public func log(request: URLRequest) {
        #if DEBUG
        print("📘 REQUEST 📘")
        print("request: \(request.url!)")
        print("headers: \(request.allHTTPHeaderFields!)")
        print("method: \(request.httpMethod!)")
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            print("body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            print("body: \(String(describing: resultString))")
        }
        print("📘 REQUEST END 📘")
        #endif
    }
    
    public func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data else { return }
        #if DEBUG
		if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
			print("📗 RESPONSE 📗")
			print("responseData:",
				  NSString(cString: "\(dataDict)".cString(using: .utf8) ?? [],
						   encoding: NSNonLossyASCIIStringEncoding) ?? "")
			print("📗 RESPONSE END 📗")
		}
        #endif
    }
    
    public func log(error: Error) {
        #if DEBUG
		print("📕 ERROR LOGGER 📕")
		print("\(error.localizedDescription)")
		print("📕 ERROR LOGGER END 📕")
		#endif
    }
}

// MARK: - Response Decoders
public class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    public init() { }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

public class RawDataResponseDecoder: ResponseDecoder {
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
