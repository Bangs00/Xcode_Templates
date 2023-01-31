//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ All rights reserved.
//

import Foundation

struct APIEndpoints {
//    static func EXAMPLE_ENDPOINT(with EXAMPLE_REQUEST_DTO: EXAMPLE_REQUEST_DTO) -> Endpoint<EXAMPLE_RESOPONSE_DTO> {
//        return Endpoint(path: "example/endpoint",
//                        method: .EXAMPLE_HTTP_METHOD,
//                        headerParameters: [:],
//                        bodyParametersEncodable: EXAMPLE_REQUEST_DTO,
//                        bodyEncoding: BodyEncoding.jsonSerializationData)
//    }
    static func exampleEndpoint(with exampleRequestDTO: ExampleRequestDTO) -> Endpoint<ExampleResponseDTO> {
        return Endpoint(path: "EXAMPLE/PATH",
                        method: .post,
                        headerParameters: [:],
                        bodyParametersEncodable: exampleRequestDTO,
                        bodyEncoding: .jsonSerializationData)
    }
}
