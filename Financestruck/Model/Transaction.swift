//
//  Transaction.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 16.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation

//protocol Transaction {
//    var category: Category { get }
//    var amount: Amount { get }
//    var time: Date { get }
//    var description: String? { get }
//}
//
//struct ExpenseTransaction: Transaction {
//    let category: Expense
//    let amount: Amount
//    let time: Date
//    let description: String?
//}

struct Transaction<C> where C: Category {
    let category: C
    let amount: Amount
    let time: Date
    let description: String?
}

typealias ExpenseTransaction = Transaction<Expense>
typealias IncomeTransaction = Transaction<Income>
