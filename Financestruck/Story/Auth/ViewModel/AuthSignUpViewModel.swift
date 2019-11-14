//
//  AuthSignUpViewModel.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 9/20/18.
//  Copyright © 2018 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift
import Firebase

class AuthSignUpViewModel {

    // MARK: Model

    // MARK: Input

    let email: ValidatingProperty<String, NSError>

    let password: ValidatingProperty<String, NSError>

    let phone: ValidatingProperty<String, NSError>

    let displayName: MutableProperty<String?>

    let signUp: Action<(), (), NSError>

    // MARK: Lifecycle

    init() {

        email = ValidatingProperty("") { value in
            return value.isEmpty ? .invalid(NSError(domain: "Financestruck.Auth", code: 0, userInfo: [NSLocalizedDescriptionKey: "Required field"])) : .valid
        }

        password = ValidatingProperty("") { value in
            return value.isEmpty ? .invalid(NSError(domain: "Financestruck.Auth", code: 0, userInfo: [NSLocalizedDescriptionKey: "Required field"])) : .valid
        }

        phone = ValidatingProperty("") { value in
            return value.isEmpty ? .invalid(NSError(domain: "Financestruck.Auth", code: 0, userInfo: [NSLocalizedDescriptionKey: "Required field"])) : .valid
        }

        displayName = MutableProperty(nil)

        let form: Property<SignUpForm?> = Property.combineLatest(email.result, password.result, phone.result, displayName).map { email, password, phone, displayName in
            return SignUpForm(email: email.value, password: password.value, phone: phone.value, displayName: displayName)
        }

        signUp = Action(unwrapping: form) { credentials in
            return Current.user.signUp(with: credentials)
        }
    }
}
