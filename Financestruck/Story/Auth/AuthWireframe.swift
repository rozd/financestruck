//
//  AuthWireframe.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 12.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

// MARK: Dependency Injection

protocol AuthAssembler {
    func resolve() -> AuthService
}

extension AuthAssembler {

    func resolve() -> AuthService {
        return FirebaseAuthService()
    }

}

extension DefaultAssembler: AuthAssembler {
    
}

// MARK: Storyboard Integration

extension UIStoryboard {
    class var auth: UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: nil)
    }
    
    func instantiateInitialViewController(with viewModel: AuthViewModel) -> UIViewController? {
        let initial = instantiateInitialViewController()
        if let authNavigationController = initial as? UINavigationController,
            let authViewController = authNavigationController.topViewController as? AuthViewController {
            authViewController.viewModel = viewModel
        }
        return initial
    }

}
