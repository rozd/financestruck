//
//  Changeset+UIKit+Extension.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 24.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Changeset

// MARK: - UITableView

extension Reactive where Base: UITableView {

    public func edits<C>(in section: Int, animation: UITableView.RowAnimation = .automatic) -> BindingTarget<Array<Changeset<C>.Edit>> {
        return makeBindingTarget { base, value in
            base.update(with: value, in: section, animation: animation)
        }
    }

    public func edits<C>(animation: UITableView.RowAnimation = .automatic) -> BindingTarget<Array<Changeset<C>.Edit>> {
        return makeBindingTarget { base, value in
            base.update(with: value, animation: animation)
        }
    }

}
