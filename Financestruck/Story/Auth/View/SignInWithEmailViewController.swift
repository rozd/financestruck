//
//  SignInWithEmailViewController.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 12.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

class SignInWithEmailViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet fileprivate weak var emailTextField: UITextField! {
        didSet {
            emailTextField.text = "max.rozdobudko.dev@gmail.com"
        }
    }

    // MARK: View model

    var viewModel: SignInWithEmailViewModel!

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func handleSignInButtonTap(_ sender: Any) {
//        guard let email = emailTextField.text else {
//            return
//        }
//        viewModel.signIn(withEmail: email) { [weak self] error in
//            if let error = error {
//                print(error)
//            }
//        }
    }
}
