//
//  HouseholdsViewController.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit
import ReactiveSwift

class HouseholdsViewController: UIViewController, SegueHandler {

    enum SegueIdentifier: String {
        case showHousehold
    }

    // MARK: Outlets

    @IBOutlet fileprivate weak var tableView: UITableView!

    // MARK: View model

    var viewModel: HouseholdsViewModel!

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // tableView

        tableView.dataSource = self
        tableView.delegate = self

        // reactive

        viewModel.my.signal
            .observe(on: UIScheduler())
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] _ in
                self?.tableView.reloadData()
            }

        viewModel.errors
            .observe(on: UIScheduler())
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] error in
                self?.showAlert(withError: error)
            }
    }

    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue: segue) {
        case .showHousehold:
            if let vc = segue.destination as? HouseholdViewController, let indexPath = sender as? IndexPath {
                vc.viewModel = viewModel.createHouseholdViewModel(withHouseholdAt: indexPath)
            }
        }
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

// MARK: <UITableViewDataSource>

extension HouseholdsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: HouseholdTableViewCell.self, for: indexPath)

        cell.textLabel?.text = viewModel.displayName(at: indexPath)

        return cell
    }

}

// MARK: <UITableViewDelegate>

extension HouseholdsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: .showHousehold, sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
