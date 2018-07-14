//
//  ResponseResult+Models.swift
//  Components
//
//  Created by Anton Poltoratskyi on 30.01.18.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

// MARK: - Single Entity

public extension ResponseResult where T: ResponseRepresentable {
    
    public typealias ResultType = T.ResponseData
    
    public func process() -> ResponseResult<ResultType> {
        switch self {
        case let .success(response):
            if response.status, let data = response.data {
                return .success(data)
            }
            return processing(errorMessage: response.error)
        case let .failure(error):
            return processing(error: error)
        }
    }
}

// MARK: - Error Handling

extension ResponseResult {
    
    fileprivate func processing<ResultType>(errorMessage: String?) -> ResponseResult<ResultType> {
        switch errorMessage {
        case "invalid_token":
            return .failure(APIError.invalidToken)
        case "invalid_credentials":
            return .failure(APIError.invalidCredentials)
        case "invalid_input":
            return .failure(APIError.invalidInput)
        case "user_not_found":
            return .failure(APIError.userNotFound)
        case "quest_not_found":
            return .failure(APIError.questNotFound)
        default:
            return .failure(APIError.unknownError)
        }
    }
    
    fileprivate func processing<ResultType>(error: Error) -> ResponseResult<ResultType> {
        return .failure(APIError.unknownError)
    }
}
