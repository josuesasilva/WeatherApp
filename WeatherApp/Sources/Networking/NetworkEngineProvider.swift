//
//  NetworkEngineProvider.swift
//  WeatherApp
//
//  Created by Josué on 21/03/22.
//

import Foundation

enum NetworkEngineError: Error {
    case raw(Error)
}

enum HTTPMethod: String {
    case get = "GET"
}

protocol NetworkRequestTokenProvider {
    func cancel()
}

protocol NetworkRequestProvider {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

typealias NetworkEngineResult = (Result<Data?, NetworkEngineError>) -> Void

protocol NetworkEngineProvider {
    @discardableResult
    func request(
        _ request: NetworkRequestProvider,
        then handle: @escaping NetworkEngineResult
    ) -> NetworkRequestTokenProvider?
}

extension NetworkRequestProvider {
    var headers: [String: String]? { nil }
    var body: [String: String]? { nil }
}
