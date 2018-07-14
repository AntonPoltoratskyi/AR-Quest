//
//  QuestNetworkServiceTests.swift
//  ARQuestTests
//
//  Created by Anton Poltoratskyi on 30.05.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import XCTest
@testable import ARQuest

final class QuestNetworkServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTasksArePresentAfterJoinQuest() {
        let client = NetworkClientStub()
        
        let questStub = Quest(name: "Test", status: .active, accessLevel: .public)
        let tasksStub = (0..<5).map { Task(id: $0, name: "Task #\(String($0))", goal: .text(String($0))) }
        
        try! client.register(data: questStub)
        try! client.register(data: tasksStub)
        
        var result: Quest?
        
        let service = QuestNetworkServiceImpl(client: client, session: .shared)
        service.joinToQuest(with: "123456") { response in
            switch response {
            case let .success(quest):
                result = quest
            case .failure:
                break
            }
        }
        
        XCTAssertNotNil(result)
        XCTAssertNotNil(result?.tasks)
        XCTAssert(result?.tasks?.count == tasksStub.count, "Tasks count are not equal")
    }
}
