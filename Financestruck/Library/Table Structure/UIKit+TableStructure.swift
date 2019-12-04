//
//  UIKit+TableStructure.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 23.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

// MARK: - Table Section

public struct TableSection : Equatable {
    public typealias TableRows = [RowWrapper]

    private var rows: TableRows

    let title: String?
    let headerHeight: CGFloat?
    let footerHeight: CGFloat?

    init(rows: TableRows, title: String? = nil, headerHeight: CGFloat? = nil, footerHeight: CGFloat? = nil) {
        self.rows = rows
        self.title = title
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
    }
}

extension TableSection : ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = TableRows.Element

    public init(arrayLiteral elements: Self.ArrayLiteralElement...) {
        self.init(rows: elements)
    }
}

extension TableSection: Collection {
    public typealias Index = Int
    public typealias Element = RowWrapper

    public var startIndex: Index { return rows.startIndex }
    public var endIndex: Index { return rows.endIndex }

    public subscript(index: Index) -> RowWrapper {
        get { return rows[index] }
    }

    public func index(after i: Index) -> Index {
        return rows.index(after: i)
    }
}

// MARK: - Row Wrapper

public struct RowWrapper {
    let row: TableRow
}

extension RowWrapper : Equatable {
    public static func ==(lhs: RowWrapper, rhs: RowWrapper) -> Bool {
        return lhs.row.equals(to: rhs.row)
    }
}

extension RowWrapper {
    static func wrap(_ row: TableRow) -> RowWrapper {
        return RowWrapper(row: row)
    }
}

// MARK: - Table Row

public protocol TableRow {
    var selectionStyle: UITableViewCell.SelectionStyle { get }
    var height: CGFloat? { get }
    var estimatedHeight: CGFloat? { get }
    func equals(to row: TableRow) -> Bool
}

// MARK: Default Implementations

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
        self.rows.insert(RowWrapper(row: row), at: indexPath.row)
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

// MARK: - Collection

extension Collection where Iterator.Element == TableSection, Index == Int {

    var totalHeight: CGFloat {
        return self.reduce(0.0) { $0 + $1.totalHeight }
    }

    func row(at indexPath: IndexPath) -> TableRow {
        return self[indexPath.section][indexPath.row].row
    }

}

// MARK: - Utils

extension TableSection {

    var totalHeight: CGFloat {
        let headerHeight = self.headerHeight ?? 0.0
        let footerHeight = self.footerHeight ?? 0.0

        return rows.reduce(headerHeight + footerHeight) { $0 + ($1.row.height ?? 0.0) }
    }
}

