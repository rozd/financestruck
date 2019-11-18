//
//  HouseholdsViewModel.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift
import FirebaseFirestore

class HouseholdsViewModel {

    // MARK: Model

    fileprivate let households: Households

    // MARK: Outputs

    let my: Property<[Household]>

    let errors: Signal<NSError, Never>

    // MARK: Lifecycle

    init(households: Households) {
        self.households = households

        let signal = households.my;

        my = Property(initial: [], then: signal.flatMapError { _ in SignalProducer<[Household], Never>(value: []) })

        let (errorsSignal, errorsObserver) = Signal<NSError, Never>.pipe()

        signal.observeFailed { error in
            errorsObserver.send(value: error)
        }

        errors = Signal.merge(errorsSignal)
    }
}

// MARK: Table Support

extension HouseholdsViewModel {

    func numberOfItemsInSection(section: Int) -> Int {
        return my.value.count
    }

    func displayName(at indexPath: IndexPath) -> String? {
        return my.value[indexPath.row].name
    }
}

// MARK: Nested view models

extension HouseholdsViewModel {
    func createHouseholdViewModel(withHouseholdAt indexPath: IndexPath) -> HouseholdViewModel {
        return HouseholdViewModel(households: households, household: my.value[indexPath.row])
    }
}
