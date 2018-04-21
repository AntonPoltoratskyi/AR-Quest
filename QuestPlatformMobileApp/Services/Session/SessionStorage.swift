//
//  SessionStorage.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 7/7/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

typealias SessionIdentifier = String

enum SessionState {
    case empty
    case loggedIn(SessionIdentifier, user: User)
    
    var token: SessionIdentifier? {
        switch self {
        case .empty:
            return nil
        case let .loggedIn(token, _):
            return token
        }
    }
    
    var user: User? {
        switch self {
        case .empty:
            return nil
        case let .loggedIn(_, user):
            return user
        }
    }
}

final class SessionStorage {
    
    private let keychainStorage: KeychainStorage
    private let userDefaults: UserDefaults

    private(set) var state: SessionState = .empty {
        didSet {
            switch self.state {
            case .empty:
                sessionId = nil
                removeUser()
            case let .loggedIn(token, user):
                do {
                    try save(user: user)
                    sessionId = token
                } catch {
                    debugPrint(error, inCase: .session)
                }
            }
        }
    }
    
    var token: String? {
        return state.token
    }
    
    var user: User? {
        return state.user
    }
    
    
    // MARK: - Init
    
    static let shared = SessionStorage()
    
    init() {
        self.keychainStorage = KeychainStorage()
        self.userDefaults = UserDefaults.standard
        
        do {
            if let token = self.sessionId, let user = try restoreUser() {
                self.state = .loggedIn(token, user: user)
            } else {
                self.state = .empty
            }
        } catch {
            self.state = .empty
        }
    }
    
    
    // MARK: - Session Management
    
    func setSession(_ sessionIdentifier: SessionIdentifier, forUser user: User) {
        state = .loggedIn(sessionIdentifier, user: user)
    }
    
    func invalidateSession() {
        state = .empty
    }
    
    private let sessionKey  = "session"
    private let userKey     = "user"
    
    private var sessionId: SessionIdentifier? {
        get { return keychainStorage.getString(forKey: sessionKey) }
        set {
            if let session = newValue {
                keychainStorage.set(session, forKey: sessionKey)
            } else {
                keychainStorage.deleteValue(forKey: sessionKey)
            }
        }
    }
    
    
    // MARK: User Info

    private func save(user: User) throws {
        let userData = try JSONEncoder().encode(user)
        userDefaults.set(userData, forKey: userKey)
    }
    
    private func removeUser() {
        userDefaults.removeObject(forKey: userKey)
    }
    
    private func restoreUser() throws -> User? {
        guard let userData = userDefaults.data(forKey: userKey) else {
            return nil
        }
        return try JSONDecoder().decode(User.self, from: userData)
    }
}
