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
    func create(quest: Quest, completion: @escaping (ResponseResult<QuestCreationResponse>) -> Void)
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
        let target = QuestNetworkRouter.list(token: session.token)
        client.request(to: target) { (result: ResponseResult<WebResponse<[Quest]>>) in
            completion(result.process())
        }
    }
    
    func loadOwnQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void) {
        let target = QuestNetworkRouter.ownList(token: session.token)
        client.request(to: target) { (result: ResponseResult<WebResponse<[Quest]>>) in
            completion(result.process())
        }
    }
    
    func loadTasks(for quest: Quest, completion: @escaping (ResponseResult<[Task]>) -> Void) {
        let target = QuestNetworkRouter.tasks(quest: quest, token: session.token)
        client.request(to: target) { (result: ResponseResult<WebResponse<[Task]>>) in
            completion(result.process())
        }
    }
    
    func joinToQuest(with code: String, completion: @escaping (ResponseResult<Quest>) -> Void) {
        let target = QuestNetworkRouter.joinBy(code: code, token: session.token)
        client.request(to: target) { (result: ResponseResult<WebResponse<Quest>>) in
            completion(result.process())
        }
    }
    
    func join(to quest: Quest, completion: @escaping (ResponseResult<Quest>) -> Void) {
        let target = QuestNetworkRouter.joinTo(quest: quest, token: session.token)
        client.request(to: target) { (result: ResponseResult<WebResponse<Quest>>) in
            completion(result.process())
        }
    }
    
    func create(quest: Quest, completion: @escaping (ResponseResult<QuestCreationResponse>) -> Void) {
        let target = QuestNetworkRouter.create(quest: quest, token: session.token)
        client.request(to: target) { (result: ResponseResult<WebResponse<QuestCreationResponse>>) in
            completion(result.process())
        }
    }
}

// MARK: - Stub

final class QuestNetworkServiceStub: QuestNetworkService {
    
    private static let debugStorage: DebugStorage = {
        return DebugStorage.restore()
    }()
    
    let client: NetworkClient
    let session: SessionStorage
    
    init(client: NetworkClient, session: SessionStorage) {
        self.client = client
        self.session = session
    }
    
    func loadQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void) {
        let quests = type(of: self).debugStorage.quests
//        let quests: [Quest] = (1...20).map { questStub(for: $0) }
        completion(.success(quests))
    }
    
    func loadOwnQuests(completion: @escaping (ResponseResult<[Quest]>) -> Void) {
//        let quests: [Quest] = (1...10).map { questStub(for: $0) }
        let quests = type(of: self).debugStorage.quests
        completion(.success(quests))
    }
    
    func loadTasks(for quest: Quest, completion: @escaping (ResponseResult<[Task]>) -> Void) {
//        let tasks: [Task] = (1...20).map { taskStub(for: $0) }
        completion(.success(quest.tasks))
    }
    
    func joinToQuest(with code: String, completion: @escaping (ResponseResult<Quest>) -> Void) {
        let quests = type(of: self).debugStorage.quests
        if let quest = quests.first {
            completion(.success(quest))
        } else {
            completion(.failure(APIError.unknownError))
        }
    }
    
    func join(to quest: Quest, completion: @escaping (ResponseResult<Quest>) -> Void) {
        completion(.success(quest))
    }
    
    func create(quest: Quest, completion: @escaping (ResponseResult<QuestCreationResponse>) -> Void) {
        let storage = type(of: self).debugStorage
        let maxId = storage.quests.compactMap { $0.id }.max() ?? 0
        quest.id = maxId + 1
        
        storage.quests.append(quest)
        storage.save()
        
        let response = QuestCreationResponse(quest: quest, code: "111111")
        completion(.success(response))
    }
    
//    private func questStub(for number: Int) -> Quest {
//        let owner = User(id: number, name: "User \(number)", email: "a@a.com")
//        let tasks = (0..<5).map { taskStub(for: $0) }
//        return Quest(id: number, name: "Quest #\(number)", status: .active, accessLevel: .public, tasks: tasks, owner: owner)
//    }
//    
//    private func taskStub(for number: Int) -> Task {
//        let task = Task(id: number, name: "Task #\(number)", goal: .location(.debugCoordinate))
//        return task
//    }
}
