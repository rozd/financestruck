//
//  Budget.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation

protocol Budget {
    var uid: String { get }
    var name: String? { get }
//    var period: DateInterval { get }
}
