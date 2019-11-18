//
//  Current+User.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 12.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift

// MARK: - Current User

extension Current {
    static let user = Current.User()

    class User {
        fileprivate let service: AuthService

        init(service: AuthService) {
            self.service = service
        }

    }

}

// MARK: - Authorizable User

protocol AuthorizableUser {
    var isAuthenticated: Bool { get }
    var uid: String? { get }
    func signUp(with credentials: SignUpForm) -> SignalProducer<(), NSError>
    func signIn(with credentials: SignInForm) -> SignalProducer<(), NSError>
    func signOut() -> SignalProducer<(), NSError>
}

extension Current.User: AuthorizableUser {

    var isAuthenticated: Bool {
        return service.isAuthenticated
    }

    var uid: String? {
        return service.uid
    }

    func signUp(with credentials: SignUpForm) -> SignalProducer<(), NSError> {
        return service.signUp(with: credentials).on(value: { _ in
            NotificationCenter.default.post(Notification(name: .userSignIn, object: self))
        })
    }

    func signIn(with credentials: SignInForm) -> SignalProducer<(), NSError> {
        return service.signIn(with: credentials).on(value: { _ in
            NotificationCenter.default.post(Notification(name: .userSignIn, object: self))
        })
    }

    func signOut() -> SignalProducer<(), NSError> {
        return service.signOut().on(value: { _ in
            NotificationCenter.default.post(Notification(name: .userSignOut, object: self))
        })
    }

}

// MARK: - Notification Center Extension

extension Notification.Name {
    static let userSignIn  = Notification.Name(rawValue: "userSignIn")
    static let userSignOut = Notification.Name(rawValue: "userSignOut")
}
