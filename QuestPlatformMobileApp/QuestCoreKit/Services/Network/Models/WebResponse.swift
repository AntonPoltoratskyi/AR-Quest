//
//  WebResponse.swift
//  Components
//
//  Created by Anton Poltoratskyi on 29.01.18.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public struct WebResponse<ResponseData: Decodable>: Decodable, ResponseRepresentable {
    public var status: Bool
    public var error: String?
    public var data: ResponseData?
}
