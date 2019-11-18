//
//  FirestoreService.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift
import FirebaseAuth
import FirebaseFirestore

class FirebaseFirestoreService {

    let db: Firestore

    init() {
        db = Firestore.firestore()
        let settings = db.settings
        db.settings = settings
    }

    var me: DocumentReference? {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            return nil
        }
        return db.collection("users").document(currentUserId)
    }

}
