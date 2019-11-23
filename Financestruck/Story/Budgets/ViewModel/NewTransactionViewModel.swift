//
//  NewTransactionViewModel.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 20.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift

class NewTransactionViewModel {

    // MARK: Model

    fileprivate let budgets: Budgets

    fileprivate let household: Household

    fileprivate let budget: MonthlyBudget

    // MARK: Input

    let kind: MutableProperty<CategoryKind>

    let amountValue: MutableProperty<Float?>
    let amountCurrency: MutableProperty<Currency?>

    // MARK: Output

    let availableCategories: Property<[CategoryKind]>
    let availableCurrencies: Property<[Currency]>

    let categories: Signal<[Category], NSError>

    // MARK: Lifecycle

    init(budgets: Budgets, household: Household, budget: MonthlyBudget) {
        self.budgets = budgets
        self.household = household
        self.budget = budget

        kind = MutableProperty(.expense)

        amountValue = MutableProperty(nil)
        amountCurrency = MutableProperty(nil)


        availableCategories = Property(value: [.expense, .income])
        availableCurrencies = Property(value: [.usd, .uah])

        categories = kind.signal.flatMap(.latest) { kind -> Signal<[Category], NSError> in
            switch kind {
            case .income: return budgets.incomes(for: budget, of: household).map { $0.compactMap { $0 as Category } }
            case .expense: return budgets.expenses(for: budget, of: household).map { $0.compactMap { $0 as Category } }
            }
        }

    }

}
