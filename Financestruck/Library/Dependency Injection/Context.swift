//
//  Context.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 12.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation

// MARK: Context

class Context {
    static let assembler = DefaultAssembler()
}

protocol Assembler {

}

class DefaultAssembler: Assembler {

}

// MARK: - Injections

extension Current.User {
    convenience init() {
        self.init(service: Context.assembler.resolve())
    }
}
