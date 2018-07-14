//
//  NetworkClientStub.swift
//  ARQuestTests
//
//  Created by Anton Poltoratskyi on 30.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation
@testable import ARQuest

final class NetworkClientStub: NetworkClient {
    
    private var stubs: [String: Data] = [:]
    
    func register<T: Encodable>(data: T) throws {
        let key = String(describing: T.self)
        let value = try JSONEncoder().encode(data)
        stubs[key] = value
    }
    
    func request<T: Decodable>(to target: URLRequestConvertible, decoder: JSONDecoder, completion: ((ResponseResult<T>) -> Void)?) -> URLSessionTask {
        
        let key = String(describing: T.self)
        guard let response = stubs[key] else {
            completion?(.failure(APIError.unknownError))
            return URLSessionTask()
        }
        do {
            let decodedData = try decoder.decode(T.self, from: response)
            completion?(.success(decodedData))
        } catch {
            completion?(.failure(APIError.jsonDecodingError(error)))
        }
        
        return URLSessionTask()
    }
}
