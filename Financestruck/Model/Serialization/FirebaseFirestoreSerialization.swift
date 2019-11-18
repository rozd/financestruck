//
//  FirebaseFirestoreSerialization.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 18.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import FirebaseFirestore

// MARK: - Household

extension Household {

    init?(from snapshot: DocumentSnapshot?) {
        guard let snapshot = snapshot else {
            return nil
        }
        self.init(from: snapshot)
    }

    init?(from snapshot: DocumentSnapshot) {
        self.uid = snapshot.documentID

        let dict = snapshot.data()
        self.name = dict?.string(for: Key.name.rawValue)
    }

    fileprivate enum Key: String {
        case name
    }
}

// MARK: - Budget

extension MonthlyBudget {

    init?(from snapshot: DocumentSnapshot?) {
        guard let snapshot = snapshot else {
            return nil
        }
        self.init(from: snapshot)
    }

    init(from snapshot: DocumentSnapshot) {
        self.uid = snapshot.documentID

        let dict = snapshot.data()
        self.name = dict?.string(for: Key.name.rawValue)
    }

    fileprivate enum Key: String {
        case name
    }
}
