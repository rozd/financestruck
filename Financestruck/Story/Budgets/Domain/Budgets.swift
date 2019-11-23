//
//  Budgets.swift
//  
//
//  Created by Max Rozdobudko on 19.11.2019.
//

import Foundation
import ReactiveSwift

class Budgets {

    // MARK: Dependencies

    fileprivate let service: BudgetsService

    // MARK: Lifecycle

    init(service: BudgetsService) {
        self.service = service
    }

    // MARK: Budget

    func budget(for household: Household, withId budgetId: String) -> Signal<MonthlyBudget, NSError> {
        return service.budget(for: household, withId: budgetId)
    }

    func incomes(for budget: MonthlyBudget, of household: Household) -> Signal<[Income], NSError> {
        return service.incomes(for: budget, of: household)
    }

    func expenses(for budget: MonthlyBudget, of household: Household) -> Signal<[Expense], NSError> {
        return service.expenses(for: budget, of: household)
    }

}
