//
//  HomeViewController.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 14.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class HomeViewController: UIViewController, SegueHandler {

    enum SegueIdentifier: String {
        case showHouseholds
    }

    // MARK: Outlets

    @IBOutlet weak var uidLabel: UILabel!

    @IBOutlet fileprivate weak var signOutButton: UIButton!

    // MARK: View model

    var viewModel: HomeViewModel!

    // MARK: View lifeycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // reactive

        uidLabel.reactive.text <~ viewModel.uid

        signOutButton.reactive.pressed = CocoaAction(viewModel.signOut)

        viewModel.errors
            .observe(on: UIScheduler())
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] error in
                self?.showAlert(withError: error)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue: segue) {
        case .showHouseholds:
            if let vc = segue.destination as? HouseholdsViewController {
                vc.viewModel = viewModel.createHouseholdsViewModel()
            }
        }
    }

    // MARK: Actions

    @IBAction func handleShowHouseholdsTap(_ sender: Any) {
        performSegue(withIdentifier: .showHouseholds, sender: nil)
    }

}
