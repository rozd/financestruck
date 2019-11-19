//
//  BudgetDetailsViewModel.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 19.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift

class MonthlyBudgetViewModel {

    // MARK: Model

    fileprivate let budgets: Budgets

    fileprivate let household: Household

    // MARK: Outputs

    let budget: Property<MonthlyBudget>

    let errors: Signal<NSError, Never>

    // MARK: Lifecycle

    init(budgets: Budgets, household: Household, budget: MonthlyBudget) {
        self.budgets = budgets
        self.household = household

        let budgetSignal = budgets.budget(for: household, withId: budget.uid)

        self.budget = Property(initial: budget, then: budgetSignal.suppressErrors())

        let (errorsSignal, errorsObserver) = Signal<NSError, Never>.pipe()

        budgetSignal.observeFailed { error in
            errorsObserver.send(value: error)
        }

        self.errors = Signal.merge(errorsSignal)
    }
}
