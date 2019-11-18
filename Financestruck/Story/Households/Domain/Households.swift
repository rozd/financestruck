//
//  Households.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift
import FirebaseFirestore

class Households {

    // MARK: Dependencies

    fileprivate let service: HouseholdsService

    // MARK: Lifecycle

    init(service: HouseholdsService) {
        self.service = service
    }

    // MARK: My

    var my: Signal<[Household], NSError> {
        return service.my
    }

    func household(withId id: String) -> Signal<Household?, NSError> {
        return service.household(withId: id)
    }

    func monthlyBudgets(for household: Household) -> Signal<[MonthlyBudget], NSError> {
        return service.monthlyBudgets(for: household)
    }

}
