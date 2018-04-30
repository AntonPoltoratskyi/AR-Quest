//
//  BannerNode.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import Foundation
import SceneKit

extension UIColor {
    static let defaultPinColor: UIColor = .purple
}

class BannerNode: SCNNode {
    static var defaultFontSize: CGFloat {
        let defaultWidth = CGFloat(DeveloperSettings.maxSceneRadius)
        return (defaultWidth * 0.3 + defaultWidth / 12) / 7
    }
    
    override init() {
        super.init()

        geometry = BannerShape(width: CGFloat(DeveloperSettings.maxSceneRadius))
        applyScale(1)
        updateContentLayer(text: "")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func applyScale(_ scale: Float) {
        let scaleValue = (1 / Float(DeveloperSettings.maxSceneRadius)) * scale
        self.scale = SCNVector3(scaleValue, scaleValue, scaleValue)
    }

    func updateInfo(_ text: String, backgroundColor: UIColor = .defaultPinColor) {
        updateContentLayer(text: text, backgroundColor: backgroundColor)
    }

    func updateInfo(_ text: NSAttributedString, backgroundColor: UIColor = .defaultPinColor) {
        updateContentLayer(text: text, backgroundColor: backgroundColor)
    }

    func startAnimatedMoving() {
        if action(forKey: Constants.movingActionKey) != nil { return }

        let originHeight = simdTransform.columns.3.y
        let repeatingAction: SCNAction = .repeatForever(.sequence([.move(to: SCNVector3(0, originHeight - 4, 0), duration: 0.6),
                                                                   .move(to: SCNVector3(0, originHeight + 4, 0), duration: 0.6)]))
        runAction(repeatingAction, forKey: Constants.movingActionKey)
    }

    func stopAnimatedMoving() {
        removeAllActions()
    }

    fileprivate func updateContentLayer(text: Any, backgroundColor: UIColor = .defaultPinColor) {
        let layer = CALayer()
        let pointerHeight = DeveloperSettings.maxSceneRadius / 12
        let rectHeight = DeveloperSettings.maxSceneRadius * 0.3

        layer.frame = CGRect(x: 0, y: 0, width: DeveloperSettings.maxSceneRadius, height: rectHeight + pointerHeight)
        layer.backgroundColor = backgroundColor.cgColor

        let textLayer = CATextLayer()
        textLayer.frame = layer.bounds
        textLayer.fontSize = BannerNode.defaultFontSize
        textLayer.string = text
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.truncationMode = kCATruncationEnd
        textLayer.isWrapped = true
        layer.addSublayer(textLayer)

        geometry?.firstMaterial?.locksAmbientWithDiffuse = true
        geometry?.firstMaterial?.diffuse.contents = layer
    }

}

extension BannerNode {
    struct Constants {
        static var movingActionKey = "moving_action"
    }
}

class BannerShape: SCNShape {
    var boundingSphere: (center: SCNVector3, radius: Float) {
        return (SCNVector3(0, 0, 0), 1)
    }

    init(width: CGFloat) {
        super.init()
        path = bannerPath(with: width)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bannerPath(with width: CGFloat) -> UIBezierPath {
        let height = width * 0.3

        let contentRect = CGRect(x: -width / 2, y: -height / 2, width: width, height: height)
        let rectPath = UIBezierPath(roundedRect: contentRect, cornerRadius: contentRect.width / 20)

        let pointerPath = UIBezierPath()

        let poinerWidth = contentRect.width / 4
        let pointerHeight = poinerWidth / 3

        let bottomCenterPoint = contentRect.origin.translated(byX: contentRect.width / 2, y: 0)
        pointerPath.move(to: bottomCenterPoint.translated(byX: -poinerWidth / 2, y: 0))

        pointerPath.addQuadCurve(to: bottomCenterPoint.translated(byX: 0, y: -pointerHeight),
                                 controlPoint: bottomCenterPoint.translated(byX: -poinerWidth / 8, y: -pointerHeight / 4))

        pointerPath.addQuadCurve(to: bottomCenterPoint.translated(byX: poinerWidth / 2, y: 0),
                                 controlPoint: bottomCenterPoint.translated(byX: poinerWidth / 8, y: -pointerHeight / 4))
        pointerPath.close()

        rectPath.append(pointerPath)

        return rectPath
    }
}

