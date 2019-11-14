//
//  AuthViewModel.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 12.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation

class AuthViewModel {

    // MARK: Lifecycle

    init() {

    }
    
}

// MARK: - Nested view models

extension AuthViewModel {

    func createSignInWithEmailViewModel() -> SignInWithEmailViewModel {
        return SignInWithEmailViewModel()
    }

    func createSignInViewModel() -> AuthSignInViewModel {
        return AuthSignInViewModel()
    }

    func createSignUpViewModel() -> AuthSignUpViewModel {
        return AuthSignUpViewModel()
    }
    
}
