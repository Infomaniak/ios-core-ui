//
//  File.swift
//  InfomaniakCoreUI
//
//  Created by Ambroise Decouttere on 27/01/2025.
//

import Alamofire
import Foundation
import InfomaniakCore

extension Endpoint {
    static func myKSuite(id: Int) -> Endpoint {
        return Endpoint(host: "api.staging-myksuite.dev.infomaniak.ch", path: "/1/my_ksuite/\(id)", queryItems: [
            URLQueryItem(name: "with", value: "*")
        ])
    }
}

extension ApiFetcher {
    private var myKSuiteDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }

    func myKSuite(id: Int) async throws -> MyKSuite {
        let endpoint = Endpoint.myKSuite(id: id)

        let header = HTTPHeader(name: "Authorization", value: "Bearer \(currentToken?.accessToken ?? "")")
        return try await perform(request: AF.request(
            endpoint.url,
            headers: HTTPHeaders([header])
        ))
    }
}
