//
//  AppCoordinator.swift
//  SwiftStreaming
//
//  Created by Renu Punjabi on 12/27/17.
//  Copyright © 2017 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: NSObject {
    var navigationVC: UINavigationController!
    var streamingDataCoordinator: StreamingDataCoordinator?
    
    init(navigationVC: UINavigationController) {
        self.navigationVC = navigationVC
    }
    
    func start() {
        streamingDataCoordinator = StreamingDataCoordinator(navigationVC: navigationVC)
        streamingDataCoordinator?.start()
    }
}
