//
//  UIKit+TableStructure.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 23.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

// MARK: - Table Structure

protocol TableSection {
    var rows: [TableRow] { get set }
    var title: String? { get }
    var headerHeight: CGFloat? { get }
    var footerHeight: CGFloat? { get }
}

protocol TableRow {
    var selectionStyle: UITableViewCell.SelectionStyle { get }
    var height: CGFloat? { get }
    var estimatedHeight: CGFloat? { get }
}

// MARK: - Structure Manipulation


extension Array where Iterator.Element == TableSection {

    mutating func insert(into tableView: UITableView, row: TableRow, at indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        self[indexPath.section].insert(into: tableView, row: row, at: indexPath, with: animation)
    }

    mutating func delete(from tableView: UITableView, rowAt indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        self[indexPath.section].delete(from: tableView, rowAt: indexPath, with: animation)
    }

}

extension TableSection {

    mutating func insert(into tableView: UITableView, row: TableRow, at indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        self.rows.insert(row, at: indexPath.row)
        tableView.insertRows(at: [indexPath], with: animation)
    }

    mutating func delete(from tableView: UITableView, rowAt indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        self.rows.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: animation)
    }

}

// MARK: Specific Types

protocol TableRowWithSpecificCell: TableRow {
    associatedtype Cell: UITableViewCell

    var cellType: Cell.Type { get }
}

extension TableRowWithSpecificCell {
    var cellType: Cell.Type {
        return Cell.self
    }
}

// MARK: Display Data

protocol TableRowWithDisplayData: TableRow {
    associatedtype DisplayData

    var displayData: DisplayData { get }
}

// MARK: - Default Implementations

extension TableSection {
    var title: String? {
        return nil
    }

    var headerHeight: CGFloat? {
        return nil
    }

    var footerHeight: CGFloat? {
        return nil
    }
}

extension TableRow {
    var selectionStyle: UITableViewCell.SelectionStyle {
        return .default
    }

    var height: CGFloat? {
        return nil
    }

    var estimatedHeight: CGFloat? {
        return height
    }
}

// MARK: - Collection

extension Collection where Iterator.Element == TableSection, Index == Int {

    var totalHeight: CGFloat {
        return self.reduce(0.0) { $0 + $1.totalHeight }
    }

    func row(at indexPath: IndexPath) -> TableRow {
        return self[indexPath.section].rows[indexPath.row]
    }

}

// MARK: - Utils

extension TableSection {

    var totalHeight: CGFloat {
        let headerHeight = self.headerHeight ?? 0.0
        let footerHeight = self.footerHeight ?? 0.0

        return rows.reduce(headerHeight + footerHeight) { $0 + ($1.height ?? 0.0) }
    }
}

