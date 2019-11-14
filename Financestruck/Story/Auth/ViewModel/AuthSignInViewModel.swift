//
//  AuthSignInViewModel.swift
//  Todo
//
//  Created by Max Rozdobudko on 9/20/18.
//  Copyright © 2018 Max Rozdobudko. All rights reserved.
//

import Foundation
import Firebase
import ReactiveSwift

class AuthSignInViewModel {

    // MARK: Model

    // MARK: Inputs

    let username: ValidatingProperty<String, NSError>

    let password: ValidatingProperty<String, NSError>

    let signIn: Action<(), (), NSError>

    // MARK: Lifecycle

    init() {

        username = ValidatingProperty("") { input in
            return input.count > 0 ? .valid : .invalid(NSError(domain: "Financestruck.Auth", code: 0, userInfo: [NSLocalizedDescriptionKey : "Required field"]))
        }

        password = ValidatingProperty("") { input in
            return input.count > 0 ? .valid : .invalid(NSError(domain: "Financestruck.Auth", code: 0, userInfo: [NSLocalizedDescriptionKey : "Required field"]))
        }

        let form: Property<SignInForm?> = Property.combineLatest(username.result, password.result).map { username, password in
            if !username.isInvalid && !password.isInvalid {
                return SignInForm(username: username.value!, password: password.value!)
            } else {
                return nil
            }
        }

        signIn = Action(unwrapping: form, execute: { credentials in
            return Current.user.signIn(with: credentials)
        })
    }


}
