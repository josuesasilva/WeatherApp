//
//  NetworkServiceProvider.swift
//  WeatherApp
//
//  Created by Josué on 21/03/22.
//

import Foundation

enum NetworkServiceError: Error {
    case serializationError(Error)
    case emptyResponse
    case raw(Error)
}

protocol NetworkServiceProvider {
    @discardableResult
    func requestCodable<ResponseType: Codable>(
        _ request: NetworkRequestProvider,
        ofType type: ResponseType.Type,
        then handle: @escaping (Result<ResponseType, NetworkServiceError>) -> Void
    ) -> NetworkRequestTokenProvider?
}
