//
//  SessionStorage.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 7/7/17.
//  Copyright © 2017 Anton Poltoratskyi. All rights reserved.
//

import Foundation

typealias SessionIdentifier = String
typealias User = String

private enum SessionState {
    case empty
    case loggedIn(SessionIdentifier)
    
    var token: SessionIdentifier? {
        switch self {
        case .empty:
            return nil
        case let .loggedIn(userId):
            return userId
        }
    }
}

final class SessionStorage {
    
    private static let sessionKey = "session"
    
    private let keychainStorage: KeychainStorage
    private var state: SessionState = .empty
    
    init() {
        self.keychainStorage = KeychainStorage()
    }
    
    
    
    // MARK: - Session Management
    
    private(set) var sessionId: SessionIdentifier? {
        get { return keychainStorage.getString(forKey: type(of: self).sessionKey) }
        set {
            if let session = newValue {
                self.keychainStorage.set(session, forKey: type(of: self).sessionKey)
            } else {
                self.keychainStorage.deleteValue(forKey: type(of: self).sessionKey)
            }
        }
    }
    
    func setSession(_ sessionIdentifier: SessionIdentifier, forUser user: User) {
        do {
            self.sessionId = sessionIdentifier
            // try self.databaseStorage.updateUser(user)
            self.state = .loggedIn(sessionIdentifier)
        } catch {
            debugPrint("Failed to write user session info to database", inCase: .database)
        }
    }
    
    func invalidateSession() {
        do {
            // try removeCurrentUser()
            self.state = .empty
        } catch {
            debugPrint("Error while invalidating session info", inCase: .all)
        }
    }
}
