//
//  ReactiveSwift+Extensions.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 18.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift

extension Signal {

    func suppressErrors() -> Signal<Value, Never> {
        return self.flatMapError { _ in SignalProducer<Value, Never>.empty }
    }

}
