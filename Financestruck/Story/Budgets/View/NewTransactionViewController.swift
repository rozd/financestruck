//
//  NewTransactionViewController.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 20.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class NewTransactionViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet fileprivate weak var tableView: UITableView!

    // MARK: Properties

    var sections: [TableSection] = []

    var datePickerIndexPath: IndexPath?

    // MARK: View model

    var viewModel: NewTransactionViewModel!

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // tableView

        tableView.register(nibForCellWithType: TextFieldTableViewCell.self)
        tableView.register(nibForCellWithType: DatePickerTableViewCell.self)
        tableView.registerDefaultCell()

        tableView.dataSource = self
        tableView.delegate = self

        sections = [
            TransactionSection(rows: [
                TransactionCategoryTableRow(displayData: .expense)
            ]),
            TransactionSection(rows: [
                TransactionDateTableRow(displayData: Date())
            ])
        ]

        // reactive
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Manage Date Picker

extension NewTransactionViewController {

    func dismissDatePickerIfPresented() {
        guard let indexPath = datePickerIndexPath else {
            return
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        datePickerIndexPath = nil
        tableView.endUpdates()
    }

    func datePickerIsRightAboveMe(indexPath: IndexPath) -> Bool {
        guard let datePickerIndexPath = datePickerIndexPath else {
            return false
        }
        guard datePickerIndexPath.section == indexPath.section else {
            return false
        }
        return indexPath.row == datePickerIndexPath.row + 1
    }

    func datePickerIsRightBelowMe(indexPath: IndexPath) -> Bool {
        guard let datePickerIndexPath = datePickerIndexPath else {
            return false
        }
        guard datePickerIndexPath.section == indexPath.section else {
            return false
        }
        return indexPath.row == datePickerIndexPath.row - 1
    }

    func shouldDatePickerAppearForRow(at indexPath: IndexPath) -> Bool {
        return sections.row(at: indexPath) is TransactionDateTableRow
    }

}

// MARK: - UITableViewDataSource

extension NewTransactionViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections.row(at: indexPath) {
        case let row as TransactionDateTableRow:
            let cell = tableView.dequeueDefaultReusableCell()
            cell.textLabel?.text = "\(row.displayData)"
            return cell
        case _ as TransactionDatePickerTableRow:
            let cell = tableView.dequeueReusableCell(withType: DatePickerTableViewCell.self, for: indexPath)
            cell.delegate = self
            return cell
        case let row as TransactionCategoryTableRow:
            let cell = tableView.dequeueDefaultReusableCell()
            cell.textLabel?.text = "\(row.displayData)"
            return cell
        default:
            return tableView.dequeueDefaultReusableCell()
        }
    }


}

// MARK: - UITableViewDelegate

extension NewTransactionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections.row(at: indexPath).height ?? tableView.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if shouldDatePickerAppearForRow(at: indexPath) {
            tableView.endEditing(true)
            tableView.beginUpdates()
            if let datePickerIndexPath = datePickerIndexPath {
                sections.delete(from: tableView, rowAt: datePickerIndexPath, with: .fade)
                if datePickerIsRightBelowMe(indexPath: indexPath) {
                    self.datePickerIndexPath = nil
                } else {
                    self.datePickerIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
                    sections.insert(into: tableView, row: TransactionDatePickerTableRow(), at: self.datePickerIndexPath!, with: .left)
                }
            } else {
                self.datePickerIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
                sections.insert(into: tableView, row: TransactionDatePickerTableRow(), at: self.datePickerIndexPath!, with: .fade)
            }
            tableView.endUpdates()
        } else {
            dismissDatePickerIfPresented()
        }
    }

}

// MARK: - DatePickerTableViewCellDelegate

extension NewTransactionViewController: DatePickerTableViewCellDelegate {

    func datePickerCell(_ cell: DatePickerTableViewCell, didChangeDate date: Date) {

    }

}
