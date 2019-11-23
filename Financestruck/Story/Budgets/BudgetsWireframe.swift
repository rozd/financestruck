//
//  BudgetsWireframe.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 19.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

// MARK: - Domain

let budgets = Budgets()

// MARK: - Dependency Injection

protocol BudgetsAssembler {
    func resolve() -> BudgetsService
}

extension BudgetsAssembler {

    func resolve() -> BudgetsService {
        return FirestoreBudgetsService()
    }

}

extension DefaultAssembler: BudgetsAssembler {

}

// MARK: Injections

extension Budgets {
    convenience init() {
        self.init(service: Context.assembler.resolve())
    }
}

extension MonthlyBudgetViewModel {
    convenience init(household: Household, budget: MonthlyBudget) {
        self.init(budgets: budgets, household: household, budget: budget)
    }
}

extension NewTransactionViewModel {
    convenience init(household: Household, budget: MonthlyBudget) {
        self.init(budgets: budgets, household: household, budget: budget)
    }
}

// MARK: - Storyboard Integration

extension UIStoryboard {

    class var budgets: UIStoryboard {
        return UIStoryboard(name: "Budgets", bundle: nil)
    }

    func instanitiateInitialViewController(with viewModel: MonthlyBudgetViewModel) -> UIViewController? {
        let initial = self.instantiateInitialViewController()
        if let vc = initial as? MonthlyBudgetViewController {
            vc.viewModel = viewModel
        }
        return initial
    }
}
