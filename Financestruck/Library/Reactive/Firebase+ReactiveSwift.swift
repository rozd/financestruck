//
//  Firebase+ReactiveSwift.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation
import ReactiveSwift
import FirebaseFirestore

// MARK: DocumentReference

extension Reactive where Base == DocumentReference {

    public var snapshots: Signal<DocumentSnapshot?, Never> {
        return Signal { observer, lifetime in
            let handle = base.addSnapshotListener { (snapshot, error) in
                observer.send(value: snapshot)
            }
            let disposable = lifetime.ended.observeCompleted(observer.sendCompleted)
            lifetime.observeEnded {
                handle.remove()
                disposable?.dispose()
            }
        }
    }

    public var snaps: Signal<DocumentSnapshot, NSError> {
        return Signal { observer, lifetime in
            let handle = base.addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else {
                    observer.send(error: error as NSError? ?? NSError(domain: "FirebaseErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error: \(String(describing: error))"]))
                    return
                }
                observer.send(value: snapshot)
            }
            let disposable = lifetime.ended.observeCompleted(observer.sendCompleted)
            lifetime.observeEnded {
                handle.remove()
                disposable?.dispose()
            }
        }
    }

}

// MARK: CollectionReference

extension Reactive where Base == CollectionReference {

    public var snapshots: Signal<[DocumentSnapshot], Never> {
        return Signal { observer, lifetime in
            let handle = base.addSnapshotListener { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    observer.send(value: [])
                    return
                }
                observer.send(value: documents)
            }
            let disposable = lifetime.ended.observeCompleted(observer.sendCompleted)
            lifetime.observeEnded {
                handle.remove()
                disposable?.dispose()
            }
        }
    }

    public var snaps: Signal<[DocumentSnapshot], NSError> {
        return Signal { observer, lifetime in
            let handle = base.addSnapshotListener { (snapshot, error) in
                guard let documents = snapshot?.documents else {
                    observer.send(error: error as NSError? ?? NSError(domain: "FirebaseErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error: \(String(describing: error))"]))
                    return
                }
                observer.send(value: documents)
            }
            let disposable = lifetime.ended.observeCompleted(observer.sendCompleted)
            lifetime.observeEnded {
                handle.remove()
                disposable?.dispose()
            }
        }
    }
    
}
