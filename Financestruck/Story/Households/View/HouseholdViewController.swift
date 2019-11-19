//
//  HouseholdViewController.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

class HouseholdViewController: UIViewController, SegueHandler {

    enum SegueIdentifier: String {
        case showMonthlyBudget
    }

    // MARK: Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View model

    var viewModel: HouseholdViewModel!

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // tableView

        tableView.dataSource = self
        tableView.delegate = self

        // reactive

        viewModel.monthlyBudgets.signal.observeValues { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue: segue) {
        case .showMonthlyBudget:
            if let vc = segue.destination as? MonthlyBudgetViewController, let indexPath = sender as? IndexPath {
                vc.viewModel = viewModel.createMonthlyBudgetViewModel(withBudgetAt: indexPath)
            }
        }
    }
}

// MARK: <UITableViewDataSource>

extension HouseholdViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: MonthlyBudgetTableViewCell.self, for: indexPath)

        cell.textLabel?.text = viewModel.displayName(at: indexPath)

        return cell
    }

}

// MARK: <UITableViewDelegate>

extension HouseholdViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: .showMonthlyBudget, sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
