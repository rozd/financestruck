//
//  HouseholdsService.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift
import FirebaseFirestore

protocol HouseholdsService {
    var my: Signal<[Household], NSError> { get }

    func household(withId id: String) -> Signal<Household?, NSError>

    func monthlyBudgets(for household: Household) -> Signal<[MonthlyBudget], NSError>
}

class FirestoreHouseholdsService: FirebaseFirestoreService, HouseholdsService {

    var my: Signal<[Household], NSError> {
        guard let me = me else {
            return .empty
        }

        return me.collection("households").reactive.snaps.map { $0.compactMap { Household(from: $0) } }
    }

    func household(withId id: String) -> Signal<Household?, NSError> {
        return db.document("households/\(id)").reactive.snaps.map { Household(from: $0) }
    }

    func monthlyBudgets(for household: Household) -> Signal<[MonthlyBudget], NSError> {
        return db.collection("households/\(household.uid)/budgets").reactive.snaps.map { $0.compactMap { MonthlyBudget(from: $0) } }
    }

}
