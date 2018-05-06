//
//  AuthNetworkService.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol AuthNetworkService: NetworkService {
    func login(with credentials: LoginCredentials, completion: @escaping (ResponseResult<User>) -> Void)
    func register(with credentials: SignUpCredentials, completion: @escaping (ResponseResult<User>) -> Void)
    func logout(completion: @escaping (ResponseResult<Bool>) -> Void)
}

// MARK: - Service

final class AuthNetworkServiceImpl: AuthNetworkService {
    
    let client: NetworkClient
    let session: SessionStorage
    
    init(client: NetworkClient, session: SessionStorage) {
        self.client = client
        self.session = session
    }
    
    func login(with credentials: LoginCredentials, completion: @escaping (ResponseResult<User>) -> Void) {
        let target = AuthNetworkRouter.login(credentials: credentials)
        client.request(to: target) { (result: ResponseResult<WebResponse<AuthResponse>>) in
            completion(result.process().map { response in
                self.session.setSession(response.token, forUser: response.user)
                return response.user
            })
        }
    }
    
    func register(with credentials: SignUpCredentials, completion: @escaping (ResponseResult<User>) -> Void) {
        let target = AuthNetworkRouter.register(credentials: credentials)
        client.request(to: target) { (result: ResponseResult<WebResponse<AuthResponse>>) in
            completion(result.process().map { response in
                self.session.setSession(response.token, forUser: response.user)
                return response.user
            })
        }
    }
    
    func logout(completion: @escaping (ResponseResult<Bool>) -> Void) {
        let target = AuthNetworkRouter.logout(token: session.token)
        client.request(to: target) { (result: ResponseResult<WebResponse<Bool>>) in
            self.session.invalidateSession()
            completion(result.process())
        }
    }
}

// MARK: - Stub

final class AuthNetworkServiceStub: AuthNetworkService {
    
    let client: NetworkClient
    let session: SessionStorage
    
    init(client: NetworkClient, session: SessionStorage) {
        self.client = client
        self.session = session
    }
    
    func login(with credentials: LoginCredentials, completion: @escaping (ResponseResult<User>) -> Void) {
        let user = User(id: 1, name: nil, email: credentials.email)
        completion(.success(user))
    }
    
    func register(with credentials: SignUpCredentials, completion: @escaping (ResponseResult<User>) -> Void) {
        let user = User(id: 1, name: credentials.name, email: credentials.email)
        completion(.success(user))
    }
    
    func logout(completion: @escaping (ResponseResult<Bool>) -> Void) {
        completion(.success(true))
    }
}
