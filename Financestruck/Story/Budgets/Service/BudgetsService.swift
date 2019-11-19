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
}

class FirestoreBudgetsService: FirebaseFirestoreService, BudgetsService {

    func budget(for household: Household, withId budgetId: String) -> Signal<MonthlyBudget, NSError> {
        return self.db.document("households/\(household.uid)/budgets/\(budgetId)").reactive.snaps.map { MonthlyBudget(from: $0) }
    }

}
