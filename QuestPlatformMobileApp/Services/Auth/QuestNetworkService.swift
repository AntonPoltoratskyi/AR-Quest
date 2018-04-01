//
//  QuestNetworkService.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 01.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol QuestNetworkService: NetworkService {
    func loadQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void)
}

// MARK: - Service

final class QuestNetworkServiceImpl: QuestNetworkService {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void) {
        // TODO: set token
        let target = QuestNetworkRouter.list(token: nil)
        networkClient.request(to: target) { (result: ResponseResult<WebResponse<[Quest]>>) in
            completion(result.processCollection())
        }
    }
}

// MARK: - Stub

final class QuestNetworkServiceStub: QuestNetworkService {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void) {
        let quests: [Quest] = (1...20).map { i in Quest(name: "Quest #\(i)") }
        completion(.success(quests))
    }
}
