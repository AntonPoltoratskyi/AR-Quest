//
//  SCNVector3+Operators.swift
//  ARQuest
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit

public func == (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}

public func * (vector: SCNVector3, scalar: Float) -> SCNVector3 {
    return SCNVector3(vector.x * scalar, vector.y * scalar, vector.z * scalar)
}

public func *= (vector: inout  SCNVector3, scalar: Float) {
    vector = vector * scalar
}

public func / (vector: SCNVector3, scalar: Float) -> SCNVector3 {
    return SCNVector3(vector.x / scalar, vector.y / scalar, vector.z / scalar)
}

public func /= (vector: inout  SCNVector3, scalar: Float) {
    vector = vector / scalar
}

public func + (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
    return SCNVector3(l.x + r.x, l.y + r.y, l.z + r.z)
}

public func += (l: inout SCNVector3, r: SCNVector3) {
    l = l + r
}

public func - (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
    return SCNVector3(l.x - r.x, l.y - r.y, l.z - r.z)
}

public func -= (l: inout  SCNVector3, r: SCNVector3) {
    l = l - r
}

public func * (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
    return SCNVector3(l.x * r.x, l.y * r.y, l.z * r.z)
}

public func *= (l: inout  SCNVector3, r: SCNVector3) {
    l = l * r
}

public func / (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
    return SCNVector3(l.x / r.x, l.y / r.y, l.z / r.z)
}

public func /= (l: inout  SCNVector3, r: SCNVector3) {
    l = l / r
}

public func min(_ l: SCNVector3, _ r: SCNVector3) -> SCNVector3 {
    let ld3 = double3(l)
    let rd3 = double3(r)
    
    return SCNVector3(min(ld3, rd3))
}

public func max(_ l: SCNVector3, _ r: SCNVector3) -> SCNVector3 {
    let ld3 = double3(l)
    let rd3 = double3(r)
    
    return SCNVector3(max(ld3, rd3))
}
