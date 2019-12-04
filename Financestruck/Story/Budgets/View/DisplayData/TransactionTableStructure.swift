//
//  TransactionTableStructure.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 23.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

// MARK: Element Descriptions

struct TransactionDateTableRow : TableRowWithDisplayData {

    var displayData: Date

    func equals(to row: TableRow) -> Bool {
        guard let row = row as? TransactionDateTableRow else {
            return false
        }
        return row.displayData == self.displayData
    }

}

struct TransactionCategoryTableRow : TableRowWithDisplayData {
    var displayData: CategoryKind

    func equals(to row: TableRow) -> Bool {
        guard let row = row as? TransactionCategoryTableRow else {
            return false
        }
        return row.displayData == self.displayData
    }

}

struct TransactionDatePickerTableRow : TableRowWithSpecificCell, TableRowWithDisplayData {
    typealias Cell = DatePickerTableViewCell

    var displayData: Date

    var height: CGFloat? {
        return 132.0
    }

    func equals(to row: TableRow) -> Bool {
        guard let row = row as? TransactionDatePickerTableRow else {
            return false
        }
        return row.displayData == self.displayData
    }

}

struct TransactionAmountTableRow : TableRowWithDisplayData {

    var displayData: Amount

    var height: CGFloat? {
        return 64.0
    }

    func equals(to row: TableRow) -> Bool {
        guard let row = row as? TransactionAmountTableRow else {
            return false
        }
        return row.displayData == self.displayData
    }

}
