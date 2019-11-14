//
//  AuthSignInViewController.swift
//  Todo
//
//  Created by Max Rozdobudko on 9/20/18.
//  Copyright © 2018 Max Rozdobudko. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class AuthSignInViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: View model

    var viewModel: AuthSignInViewModel!

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.username <~ usernameTextField.reactive.continuousTextValues
        viewModel.password <~ passwordTextField.reactive.continuousTextValues

        activityIndicator.reactive.isHidden <~ viewModel.signIn.isExecuting.map { !$0 }
        activityIndicator.reactive.isAnimating <~ viewModel.signIn.isExecuting

        signInButton.reactive.pressed = CocoaAction(viewModel.signIn)

        viewModel.signIn.errors
            .observe(on: UIScheduler())
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] error in
                self?.showAlert(withError: error)
            }
    }
    
}
