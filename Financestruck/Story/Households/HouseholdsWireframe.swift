//
//  HouseholdsWireframe.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit

// MARK: - Dependency Infjection

protocol HouseholdsAssembler {
    func resolve() -> HouseholdsService
}

extension HouseholdsAssembler {

    func resolve() -> HouseholdsService {
        return FirestoreHouseholdsService()
    }

}

extension DefaultAssembler: HouseholdsAssembler {

}

// MARK: Injections

let households = Households()

extension Households {
    convenience init() {
        self.init(service: Context.assembler.resolve())
    }
}

extension HouseholdsViewModel {
    convenience init() {
        self.init(households: households)
    }
}

// MARK: - Storyboard Integration

extension UIStoryboard {

    class var households: UIStoryboard {
        return UIStoryboard(name: "Households", bundle: nil)
    }

    func instantiateInitialViewController(with viewModel: HouseholdsViewModel) -> UIViewController? {
        let initial = instantiateInitialViewController()
        if let households = initial as? HouseholdsViewController {
            households.viewModel = viewModel
        }
        return initial
    }

}
