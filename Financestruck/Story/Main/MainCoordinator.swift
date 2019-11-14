//
//  MainCoordinator.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 12.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

class MainCoordinator: BaseCoordinator<()> {

    // MARK: Variables

    let window: UIWindow

    let viewModel: MainViewModel

    // MARK: Lifecycle

    init(window: UIWindow?, viewModel: MainViewModel) {
        guard let window = window else {
            fatalError("UIWindow is unavailable")
        }
        self.window = window
        self.viewModel  = viewModel
    }

    // MARK: Start point

    override func start(with completion: @escaping (()) -> ()) {
        guard Current.user.isAuthenticated else {
            showAuth { [weak self] in
                self?.start {}
            }
            return
        }

        showHome { [weak self] in
            self?.start {}
        }
    }

}

// MARK: - Navigation

extension MainCoordinator {

    func showAuth(completion: @escaping () -> ()) {
        let coordinator = AuthCoordinator(window: window, model: viewModel.createAuthViewModel())
        coordinate(to: coordinator, with: completion)
    }

}
