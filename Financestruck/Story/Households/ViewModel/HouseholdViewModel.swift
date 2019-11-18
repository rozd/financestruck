//
//  HouseholdViewModel.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift

class HouseholdViewModel {

    // MARK: Model

    fileprivate let households: Households

    // MARK: Outputs

    let household: Property<Household?>

    let monthlyBudgets: Property<[MonthlyBudget]>

    let errors: Signal<NSError, Never>

    // MARK: Lifecycle

    init(households: Households, household: Household) {
        self.households = households

        let householdSignal = households.household(withId: household.uid)

        self.household = Property(initial: household, then: householdSignal.suppressErrors())
        self.monthlyBudgets = Property(initial: [], then: households.monthlyBudgets(for: household).suppressErrors())

        let (errorsSignal, errorsObserver) = Signal<NSError, Never>.pipe()

        errors = Signal.merge(errorsSignal)

        householdSignal.observeFailed { error in
            errorsObserver.send(value: error)
        }
    }
}

// MARK: Table Support

extension HouseholdViewModel {

    func numberOfItemsInSection(section: Int) -> Int {
        return monthlyBudgets.value.count
    }

    func displayName(at indexPath: IndexPath) -> String? {
        return monthlyBudgets.value[indexPath.row].name
    }
}

// MARK: Nested view models

extension HouseholdViewModel {
    func createBudgetViewModel(withBudgetAt indexPath: IndexPath) {

    }
}
