//
//  AuthService.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 12.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import FirebaseAuth
import ReactiveSwift

protocol AuthService {

    var isAuthenticated: Bool { get }

    var uid: String? { get }

    func signUp(with credentials: SignUpForm) -> SignalProducer<(), NSError>

    func signIn(with credentials: SignInForm) -> SignalProducer<(), NSError>

    func signOut() -> SignalProducer<(), NSError>

}

// MARK: Firebase Implementation

class FirebaseAuthService: AuthService {

    var isAuthenticated: Bool {
        return Auth.auth().currentUser != nil
    }

    var uid: String? {
        return Auth.auth().currentUser?.uid
    }

    func signIn(withEmail email: String, callback: @escaping (Error?) -> ()) {
        let settings = ActionCodeSettings()
        settings.url = URL(string: "https://financestruck.web.app/email")
        settings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        settings.handleCodeInApp = true
        settings.setAndroidPackageName(Bundle.main.bundleIdentifier!, installIfNotAvailable: false, minimumVersion: "12")
        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: settings, completion: callback)
    }

    // MARK: SignUp

    func signUp(with credentials: SignUpForm) -> SignalProducer<(), NSError> {
        return SignalProducer { sink, disposable in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { value, error in
                guard let _ = value?.user else {
                    sink.send(error: NSError(domain: "Financestruck.Firebase", code: 0, error: error, defaultLocalizedDescription: "FIRUser unexpectable nil"))
                    return
                }
                sink.send(value: ())
                sink.sendCompleted()
            }
        }
    }

    // MARK SignIn

    func signIn(with credentials: SignInForm) -> SignalProducer<(), NSError> {
        return SignalProducer { sink, disposable in
            Auth.auth().signIn(withEmail: credentials.username, password: credentials.password, completion: { value, error in
                guard let _ = value?.user else {
                    sink.send(error: NSError(domain: "Financestruck.Firebase", code: 0, error: error, defaultLocalizedDescription: "FIRUser unexpectable nil"))
                    return
                }
                sink.send(value: ())
                sink.sendCompleted()
            })
        }
    }

    // MARK: SignOut

    func signOut() -> SignalProducer<(), NSError> {
        return SignalProducer { sink, disposable in
            do {
                try Auth.auth().signOut()
                sink.send(value: ())
                sink.sendCompleted()
            } catch let error as NSError {
                sink.send(error: error)
            }
        }
    }
}
