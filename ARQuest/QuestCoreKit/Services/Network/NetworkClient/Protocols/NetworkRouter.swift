//
//  NetworkRouter.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 06.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol NetworkRouter: URLRequestConvertible {
    static var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: HTTPParameters { get }
    var headers: HTTPHeaders { get }
}

extension NetworkRouter {
    
    static var baseURL: URL {
        return Bundle.main.serverURL
    }

    var params: HTTPParameters {
        return [:]
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = type(of: self).baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: params)
        request.httpMethod = method.rawValue
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
