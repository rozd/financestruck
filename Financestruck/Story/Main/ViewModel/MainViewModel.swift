//
//  ViewModel.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 12.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation

class MainViewModel {

}

// MARK: Nested view models

extension MainViewModel {

    func createAuthViewModel() -> AuthViewModel {
        return AuthViewModel()
    }

}
