//
//  Current+User+Reactive.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift

// MARK: Reactive Extensions

extension Reactive where Base == Current.User {

    var uid: Property<String?> {
        return Property(initial: base.uid, then:
            NotificationCenter.default
                .reactive
                .notifications(forName: .userSignIn)
                .take(during: base.reactive.lifetime)
                .map { ($0.object as! Current.User).uid }
        )
    }

}

extension Current.User: ReactiveExtensionsProvider {

}
