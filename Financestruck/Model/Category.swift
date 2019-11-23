//
//  Category.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 20.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation


enum CategoryKind {
    case income
    case expense
}

protocol Category {
    var kind: CategoryKind { get }
    var id: String { get }
    var name: String { get }
}


struct Expense: Category {
    let kind = CategoryKind.expense
    let id: String
    let name: String
}

struct Income: Category {
    let kind = CategoryKind.income
    let id: String
    let name: String
}
