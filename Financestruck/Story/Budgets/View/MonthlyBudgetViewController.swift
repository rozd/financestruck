//
//  MonthlyBudgetViewController.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 19.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class MonthlyBudgetViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var titleLabel: UILabel!

    // MARK: View model

    var viewModel: MonthlyBudgetViewModel!

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // reactive

        self.reactive.title <~ viewModel.budget.map { $0.name }

        titleLabel.reactive.text <~ viewModel.budget.map { $0.name }
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
