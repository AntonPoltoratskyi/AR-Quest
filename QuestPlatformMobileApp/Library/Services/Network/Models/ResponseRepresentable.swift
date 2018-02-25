//
//  ResponseRepresentable.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 25.02.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public protocol ResponseRepresentable {
    associatedtype ResponseData: Decodable
    
    var status: Bool { get }
    var error: String? { get }
    var data: ResponseData? { get }
}
