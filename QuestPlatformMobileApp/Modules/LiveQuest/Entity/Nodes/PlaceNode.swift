//
//  PlaceNode.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import SceneKit
import ARKit
import MapKit

final class PlaceNode: BaseNode<Container<CLLocationCoordinate2D>> {
    
    var bannerNode: BannerNode!
    
    override var geometryHeightOffSet: Float {
        return 1
    }
    
    override init(element: Container<CLLocationCoordinate2D>) {
        super.init(element: element)
        sourceId = element.id
        bannerNode = BannerNode()
        addChildNode(bannerNode)
        
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .Y
        constraints = [billboardConstraint]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateWith(currentCameraTransform: matrix_float4x4, currentCoordinates: CLLocationCoordinate2D, thresholdDistance: Double) {
        var identity = matrix_identity_float4x4
        identity.columns.3.x = currentCameraTransform.columns.3.x
        identity.columns.3.y = simdTransform.columns.3.y
        identity.columns.3.z = currentCameraTransform.columns.3.z
        
        transform = identity.toSCNMatrix4().transformedWithCoordinates(current: currentCoordinates,
                                                                       destination: element.element,
                                                                       thresholdDistance: thresholdDistance)
    }
    
    override func applyScale(_ scaleFactor: Float) {
        bannerNode.applyScale(scaleFactor)
    }
    
    func updateContent(_ text: NSAttributedString, _ background: UIColor = .defaultPinColor) {
        bannerNode.updateInfo(text, backgroundColor: background)
    }
    
    func updateContent(_ text: String, _ background: UIColor = .defaultPinColor) {
        bannerNode.updateInfo(text, backgroundColor: background)
    }
    
    func startAnimatedMoving() {
        bannerNode?.startAnimatedMoving()
    }
    
    func stopAnimatedMoving() {
        bannerNode?.stopAnimatedMoving()
    }
}

