//
//  HomeCoordinator.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 14.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

class HomeCoordinator: BaseCoordinator<()> {

    private let window: UIWindow
    private let model: HomeViewModel

    init(window: UIWindow, model: HomeViewModel) {
        self.window = window
        self.model  = model
    }

    override func start(with completion: @escaping (()) -> ()) {
        var token: NSObjectProtocol!
        token = NotificationCenter.default.addObserver(forName: .userSignOut, object: nil, queue: OperationQueue.main) { notification in
            NotificationCenter.default.removeObserver(token!)
            completion(())
        }
        let rootViewController = UIStoryboard.home.instantiateInitialViewController(with: model)
        window.rootViewController = rootViewController
    }

}
