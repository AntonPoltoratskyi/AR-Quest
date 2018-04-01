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
    func loadTasks(for quest: Quest, completion: @escaping (ResponseResult<[Task]>) -> Void)
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
            completion(result.process())
        }
    }
    
    func loadTasks(for quest: Quest, completion: @escaping (ResponseResult<[Task]>) -> Void) {
        // TODO: set token
        let target = QuestNetworkRouter.tasks(quest: quest, token: nil)
        networkClient.request(to: target) { (result: ResponseResult<WebResponse<[Task]>>) in
            completion(result.process())
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
    
    func loadTasks(for quest: Quest, completion: @escaping (ResponseResult<[Task]>) -> Void) {
        let tasks: [Task] = (1...20).map { i in Task(name: "Quest #\(i)") }
        completion(.success(tasks))
    }
}