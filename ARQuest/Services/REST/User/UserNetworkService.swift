//
//  UserNetworkService.swift
//  ARQuest
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
        client.request(to: target) { [session] (result: ResponseResult<WebResponse<User>>) in
            let result = result.process()
            if case let .success(user) = result {
                session.updateUser(user)
            }
            completion(result)
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
        if let user = session.user {
            completion(.success(user))
        } else {
            completion(.failure(APIError.userNotFound))
        }
    }
    
    func editUser(_ user: User, completion: @escaping (ResponseResult<User>) -> Void) {
        session.updateUser(user)
        completion(.success(user))
    }
}
