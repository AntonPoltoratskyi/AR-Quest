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
    func loadOwnQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void)
    func loadTasks(for quest: Quest, completion: @escaping (ResponseResult<[Task]>) -> Void)
    func joinToQuest(with code: String, completion: @escaping (ResponseResult<Quest>) -> Void)
    func join(to quest: Quest, completion: @escaping (ResponseResult<Quest>) -> Void)
}

// MARK: - Service

final class QuestNetworkServiceImpl: QuestNetworkService {
    
    let client: NetworkClient
    let session: SessionStorage
    
    init(client: NetworkClient, session: SessionStorage) {
        self.client = client
        self.session = session
    }
    
    func loadQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void) {
        // TODO: set token
        let target = QuestNetworkRouter.list(token: nil)
        client.request(to: target) { (result: ResponseResult<WebResponse<[Quest]>>) in
            completion(result.process())
        }
    }
    
    func loadOwnQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void) {
        // TODO: set token
        let target = QuestNetworkRouter.ownList(token: nil)
        client.request(to: target) { (result: ResponseResult<WebResponse<[Quest]>>) in
            completion(result.process())
        }
    }
    
    func loadTasks(for quest: Quest, completion: @escaping (ResponseResult<[Task]>) -> Void) {
        // TODO: set token
        let target = QuestNetworkRouter.tasks(quest: quest, token: nil)
        client.request(to: target) { (result: ResponseResult<WebResponse<[Task]>>) in
            completion(result.process())
        }
    }
    
    func joinToQuest(with code: String, completion: @escaping (ResponseResult<Quest>) -> Void) {
        // TODO: set token
        let target = QuestNetworkRouter.joinBy(code: code, token: nil)
        client.request(to: target) { (result: ResponseResult<WebResponse<Quest>>) in
            completion(result.process())
        }
    }
    
    func join(to quest: Quest, completion: @escaping (ResponseResult<Quest>) -> Void) {
        // TODO: set token
        let target = QuestNetworkRouter.joinTo(quest: quest, token: nil)
        client.request(to: target) { (result: ResponseResult<WebResponse<Quest>>) in
            completion(result.process())
        }
    }
}

// MARK: - Stub

final class QuestNetworkServiceStub: QuestNetworkService {
    
    let client: NetworkClient
    let session: SessionStorage
    
    init(client: NetworkClient, session: SessionStorage) {
        self.client = client
        self.session = session
    }
    
    func loadQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void) {
        let quests: [Quest] = (1...20).map { i in Quest(name: "Quest #\(i)") }
        completion(.success(quests))
    }
    
    func loadOwnQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void) {
        let quests: [Quest] = (1...10).map { i in Quest(name: "Quest #\(i)") }
        completion(.success(quests))
    }
    
    func loadTasks(for quest: Quest, completion: @escaping (ResponseResult<[Task]>) -> Void) {
        let tasks: [Task] = (1...20).map { i in Task(name: "Task #\(i)") }
        completion(.success(tasks))
    }
    
    func joinToQuest(with code: String, completion: @escaping (ResponseResult<Quest>) -> Void) {
        let quest = Quest(name: "Quest #1")
        completion(.success(quest))
    }
    
    func join(to quest: Quest, completion: @escaping (ResponseResult<Quest>) -> Void) {
        completion(.success(quest))
    }
}
