//
//  HomeViewModel.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 14.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift

class HomeViewModel {

    // MARK: Outputs

    let uid: Property<String?>

    let errors: Signal<NSError, Never>

    // MARK: Inputs

    let signOut: Action<(), (), NSError>

    // MARK: Lifecycle

    init() {
        signOut = Action {
            return Current.user.signOut()
        }

        errors = Signal.merge(signOut.errors)

        uid = Property(initial: Current.user.uid, then: Current.user.reactive.uid)
    }

}

// MARK: Nested view models

extension HomeViewModel {

    func createHouseholdsViewModel() -> HouseholdsViewModel {
        return HouseholdsViewModel()
    }

}
