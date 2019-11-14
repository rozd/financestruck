//
//  SignUpForm.swift
//  Todo
//
//  Created by Max Rozdobudko on 2/3/19.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation

struct SignUpForm {

    enum Field: String {
        case password
        case email
        case phone
        case displayName
    }

    init?(email: String?, password: String?, phone: String?, displayName: String?) {
        guard let email = email, let password = password else { return nil }
        self.init(email: email, password: password, phone: phone, displayName: displayName)
    }

    init(email: String, password: String, phone: String?, displayName: String?) {
        self.email = email
        self.password = password
        self.phone = phone
        self.displayName = displayName
    }

    var email: String
    var password: String
    var phone: String?
    var displayName: String?

    var isValid: Bool {
        return !password.isEmpty && !email.isEmpty
    }
}
