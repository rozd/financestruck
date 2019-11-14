//
//  HomeWireframe.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 14.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

// MARK: - Dependency Injection



// MARK: - Storyboard Integraion

extension UIStoryboard {

    class var home: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: nil)
    }

    func instantiateInitialViewController(with viewModel: HomeViewModel) -> UIViewController? {
        let initial = instantiateInitialViewController()
        if let home = initial as? HomeViewController {
            home.viewModel = viewModel
        }
        return initial
    }

}

// MARK: Coordinator Integration

extension MainCoordinator {

    func showHome(completion: @escaping () -> ()) {
        let coordinator = HomeCoordinator(window: window, model: viewModel.createHomeViewModel())
        coordinate(to: coordinator, with: completion)
    }

}

// MARK: View Model Integration

extension MainViewModel {

    func createHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }

}
