//
//  ServiceFactory.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 14.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

protocol ServiceProvider: class {
    func makeAuthService() -> AuthNetworkService
    func makeUserService() -> UserNetworkService
    func makeQuestService() -> QuestNetworkService
    func makeLocationService() -> LocationService
}

final class ServiceFactory: ServiceProvider {
    
    static let shared: ServiceProvider = ServiceFactory()
    
    private let sessionStorage = SessionStorage()
    
    private let networkClient: NetworkClient = URLSessionNetworkClient()
    
    func makeAuthService() -> AuthNetworkService {
        return AuthNetworkServiceImpl(client: networkClient, session: sessionStorage)
    }
    
    func makeUserService() -> UserNetworkService {
        return UserNetworkServiceImpl(client: networkClient, session: sessionStorage)
    }
    
    func makeQuestService() -> QuestNetworkService {
        return QuestNetworkServiceImpl(client: networkClient, session: sessionStorage)
    }
    
    func makeLocationService() -> LocationService {
        return LocationService.shared
    }
}
