//
//  SignInForm.swift
//  Todo
//
//  Created by Max Rozdobudko on 2/3/19.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation

struct SignInForm {

    enum Field: String {
        case username
        case password
    }

    var username: String
    var password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    var isValid: Bool {
        return !username.isEmpty && !password.isEmpty
    }
}
