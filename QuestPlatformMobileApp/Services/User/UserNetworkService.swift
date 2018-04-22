//
//  UserNetworkService.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 22.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol UserNetworkService: NetworkService {
    func getCurrentUser(completion: @escaping (ResponseResult<User>) -> Void)
    func editUser(_ user: User, completion: @escaping (ResponseResult<User>) -> Void)
}

// MARK: - Service

final class UserNetworkServiceImpl: UserNetworkService {
    
    let client: NetworkClient
    let session: SessionStorage
    
    init(client: NetworkClient, session: SessionStorage) {
        self.client = client
        self.session = session
    }
    
    func getCurrentUser(completion: @escaping (ResponseResult<User>) -> Void) {
        let target = UserNetworkRouter.getCurrentUser(token: session.token)
        client.request(to: target) { (result: ResponseResult<WebResponse<User>>) in
            completion(result.process())
        }
    }
    
    func editUser(_ user: User, completion: @escaping (ResponseResult<User>) -> Void) {
        let target = UserNetworkRouter.edit(user: user, token: session.token)
        client.request(to: target) { (result: ResponseResult<WebResponse<User>>) in
            completion(result.process())
        }
    }
}

// MARK: - Stub

final class UserNetworkServiceStub: UserNetworkService {
    
    let client: NetworkClient
    let session: SessionStorage
    
    init(client: NetworkClient, session: SessionStorage) {
        self.client = client
        self.session = session
    }
    
    func getCurrentUser(completion: @escaping (ResponseResult<User>) -> Void) {
        let user = User(name: "Antony", email: "test@gmail.com")
        completion(.success(user))
    }
    
    func editUser(_ user: User, completion: @escaping (ResponseResult<User>) -> Void) {
        completion(.success(user))
    }
}
