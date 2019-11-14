//
//  AuthSignUpViewController.swift
//  Todo
//
//  Created by Max Rozdobudko on 9/20/18.
//  Copyright © 2018 Max Rozdobudko. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class AuthSignUpViewController: UIViewController {

    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var signUpButton: UIButton!

    // MARK: View model

    var viewModel: AuthSignUpViewModel!

    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.email <~ emailTextField.reactive.continuousTextValues
        viewModel.password <~ passwordTextField.reactive.continuousTextValues
        viewModel.phone <~ phoneTextField.reactive.continuousTextValues
        viewModel.displayName <~ displayNameTextField.reactive.continuousTextValues

        activityIndicator.reactive.isHidden <~ viewModel.signUp.isExecuting.map { !$0 }
        activityIndicator.reactive.isAnimating <~ viewModel.signUp.isExecuting

        signUpButton.reactive.pressed = CocoaAction(viewModel.signUp)

        viewModel.signUp.errors
            .observe(on: UIScheduler())
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] error in
                self?.showAlert(withError: error)
            }
    }
}
