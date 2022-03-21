//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Josué on 21/03/22.
//

import Foundation

final class NetworkService: NetworkServiceProvider {
    // MARK: - Dependencies
    private let networkEngine: NetworkEngineProvider
    private let decoder: JSONDecoder

    // MARK: - Initializers
    init(
        networkEngine: NetworkEngineProvider = AlamofireEngine(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.networkEngine = networkEngine
        self.decoder = decoder
    }

    // MARK: - NetworkServiceProvider
    @discardableResult
    func requestCodable<ResponseType: Codable>(
        _ request: NetworkRequestProvider,
        ofType type: ResponseType.Type,
        then handle: @escaping (Result<ResponseType, NetworkServiceError>) -> Void
    ) -> NetworkRequestTokenProvider? {
        let networkRequest = networkEngine.request(request) { [weak self] result in

            guard let self = self else { return }

            do {
                guard let data = try result.get() else {
                    handle(.failure(.emptyResponse))
                    return
                }
                let object = try self.decoder.decode(type.self, from: data)
                handle(.success(object))
            } catch {
                if error is DecodingError {
                    handle(.failure(.serializationError(error)))
                } else {
                    handle(.failure(.raw(error)))
                }
            }
        }

        return networkRequest
    }
}
