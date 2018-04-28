//
//  NavigationServiceDelegate.swift
//  QuestPlatformMobileApp
//
//  Created by Anton Poltoratskyi on 28.04.2018.
//  Copyright © 2018 Anton Poltoratskyi. All rights reserved.
//

import CoreLocation

protocol NavigationServiceDelegate: class {
    func navigationService(_ service: NavigationService, didReceiveNoAuthorization state: CLAuthorizationStatus)
    func navigationService(_ service: NavigationService, didUpdateLocations locations: [CLLocation])
    func navigationService(_ service: NavigationService, didUpdateHeading newHeading: CLHeading)
    func navigationService(_ service: NavigationService, didFailWithError error: Error)
}

extension NavigationServiceDelegate {
    func navigationService(_ service: NavigationService, didReceiveNoAuthorization state: CLAuthorizationStatus) { }
    func navigationService(_ service: NavigationService, didUpdateLocations locations: [CLLocation]) { }
    func navigationService(_ service: NavigationService, didUpdateHeading newHeading: CLHeading) { }
    func navigationService(_ service: NavigationService, didFailWithError error: Error) { }
}

