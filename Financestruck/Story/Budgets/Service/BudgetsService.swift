//
//  BudgetsService.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 19.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift
import FirebaseFirestore

protocol BudgetsService {
    func budget(for household: Household, withId budgetId: String) -> Signal<MonthlyBudget, NSError>

    func expenses(for budget: MonthlyBudget, of household: Household) -> Signal<[Expense], NSError>

    func incomes(for budget: MonthlyBudget, of household: Household) -> Signal<[Income], NSError>
}

class FirestoreBudgetsService: FirebaseFirestoreService, BudgetsService {

    func budget(for household: Household, withId budgetId: String) -> Signal<MonthlyBudget, NSError> {
        return self.db.document("households/\(household.uid)/budgets/\(budgetId)").reactive.snaps.map { MonthlyBudget(from: $0) }
    }

    func incomes(for budget: MonthlyBudget, of household: Household) -> Signal<[Income], NSError> {
        return db.collection("household/\(household.uid)/budgets/\(budget.uid)/incomes").reactive.snaps.map { $0.map { Income(from: $0) } }
    }

    func expenses(for budget: MonthlyBudget, of household: Household) -> Signal<[Expense], NSError> {
        return db.collection("household/\(household.uid)/budgets/\(budget.uid)/expenses").reactive.snaps.map { $0.map { Expense(from: $0) } }
    }
}
