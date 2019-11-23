//
//  TransactionTableStructure.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 23.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

// MARK: Element Descriptions

struct TransactionSection: TableSection {
    var rows: [TableRow]
}

struct TransactionDateTableRow: TableRowWithDisplayData {
    var displayData: Date
    var height: CGFloat? {
        return 44.0
    }
}

struct TransactionDatePickerTableRow: TableRowWithSpecificCell {
    typealias Cell = DatePickerTableViewCell
    var height: CGFloat? {
        return 132.0
    }
}

struct TransactionAmountTableRow: TableRowWithDisplayData {
    var displayData: Amount
    var height: CGFloat? {
        return 64.0
    }
}

// MARK: Structure

extension Collection where Iterator.Element == TableSection, Index == Int {

    static func sections(for transaction: ExpenseTransaction) -> [TableSection] {
        return [
            TransactionSection(rows: [
                TransactionDateTableRow(displayData: Date())
            ])
        ]
    }

}
