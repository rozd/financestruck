//
//  AuthViewController.swift
//  Todo
//
//  Created by Max Rozdobudko on 9/20/18.
//  Copyright © 2018 Max Rozdobudko. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, SegueHandler {

    // MARK: Segues

    enum SegueIdentifier: String {
        case showSignIn
        case showSignUp
    }

    // MARK: View model

    var viewModel: AuthViewModel!

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifierForSegue(segue: segue) {
        case .showSignIn:
            if let destination = segue.destination as? AuthSignInViewController {
                destination.viewModel = viewModel.createSignInViewModel()
            }
        case .showSignUp:
            if let destination = segue.destination as? AuthSignUpViewController {
                destination.viewModel = viewModel.createSignUpViewModel()
            }
        }
    }

}
