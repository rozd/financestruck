//
//  NewTransactionViewModel.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 20.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Changeset

class NewTransactionViewModel {

    typealias TableChangeset = Changeset<[TableSection]>

    // MARK: Model

    fileprivate let budgets: Budgets

    fileprivate let household: Household

    fileprivate let budget: MonthlyBudget

    // MARK: Input

    let kind: MutableProperty<CategoryKind>

    let amountValue: MutableProperty<Float?>
    let amountCurrency: MutableProperty<Currency?>

    let date: MutableProperty<Date>

    // MARK: Output

    let availableCategories: Property<[CategoryKind]>
    let availableCurrencies: Property<[Currency]>

    let categories: Signal<[Category], NSError>

    let sections: Property<[TableSection]>

    let sectionsChangeset: Signal<[TableChangeset.Edit], Never>

    // MARK: Lifecycle

    init(budgets: Budgets, household: Household, budget: MonthlyBudget) {
        self.budgets = budgets
        self.household = household
        self.budget = budget

        kind = MutableProperty(.expense)

        amountValue = MutableProperty(nil)
        amountCurrency = MutableProperty(nil)

        date = MutableProperty(Date())

        availableCategories = Property(value: [.expense, .income])
        availableCurrencies = Property(value: [.usd, .uah])

        categories = kind.signal.flatMap(.latest) { kind -> Signal<[Category], NSError> in
            switch kind {
            case .income: return budgets.incomes(for: budget, of: household).map { $0.compactMap { $0 as Category } }
            case .expense: return budgets.expenses(for: budget, of: household).map { $0.compactMap { $0 as Category } }
            }
        }

        sections = Property(initial: [], then: Property.combineLatest(kind, date).map { kind, date in
            return [
                [
                    .wrap(TransactionCategoryTableRow(displayData: kind)),
                ],
                [
                    .wrap(TransactionDateTableRow(displayData: date)),
                ]
            ]
        })

        sectionsChangeset = sections.signal.combinePrevious([]).map { (oldItems, newItems) in TableChangeset.edits(from: oldItems, to: newItems) }
    }

}

// MARK: Table Support

extension NewTransactionViewModel {

    func numberOfSections() -> Int {
        return sections.value.count
    }

    func numberOfRows(in section: Int) -> Int {
        return sections.value[section].count
    }

    func row(at indexPath: IndexPath) -> TableRow {
        return sections.value[indexPath.section][indexPath.row].row
    }

}
