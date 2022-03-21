//
//  AlamofireEngine.swift
//  WeatherApp
//
//  Created by Josué on 21/03/22.
//

import Alamofire
import Foundation

struct AlamofireRequest: URLRequestConvertible {
    let request: NetworkRequestProvider
    let jsonEncoder = JSONEncoder()

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.method = Alamofire.HTTPMethod(rawValue: request.method.rawValue)

        if let headers = request.headers {
            urlRequest.headers = HTTPHeaders(headers)
        }

        if let body = request.body {
            urlRequest.httpBody = try jsonEncoder.encode(body)
        }

        urlRequest.timeoutInterval = 5
        urlRequest.cachePolicy = .useProtocolCachePolicy

        return urlRequest
    }
}

extension URLSessionTask: NetworkRequestTokenProvider {}

final class AlamofireEngine: NetworkEngineProvider {

    // MARK: - Properties
    private lazy var session: Session = {
        let session = Session()
        return session
    }()

    // MARK: - NetworkEngineProvider
    func request(
        _ request: NetworkRequestProvider,
        then handle: @escaping NetworkEngineResult
    ) -> NetworkRequestTokenProvider? {
        let alamofireRequest = AlamofireRequest(request: request)
        let httpRequest = session.request(alamofireRequest)
        httpRequest.response { response in
            if let error = response.error {
                handle(.failure(.raw(error)))
                return
            }
            handle(.success(response.data))
        }

        return httpRequest.task
    }
}
