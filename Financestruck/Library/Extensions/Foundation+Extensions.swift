//
//  Foundation+Extensions.swift
//  Financestruck
//
//  Created by Max Rozdobudko on 17.11.2019.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import Foundation

// MARK: - Date

extension Date {
    var isInPast: Bool {
        let now = Date()
        return self.compare(now) == ComparisonResult.orderedAscending
    }
}

// MARK: - Dictionary extensions

extension Dictionary where Key == String {

    func string(for key: String, default: String) -> String {
        return (self[key] as? String) ?? `default`
    }

    func string(for key: String) -> String? {
        return self[key] as? String
    }

    func int(for key: String) -> Int? {
        return self[key] as? Int
    }

    func bool(for key: String) -> Bool? {
        return self[key] as? Bool
    }

    func bool(for key: String, default: Bool) -> Bool {
        if let value = bool(for: key) {
            return value
        } else {
            return `default`
        }
    }

    func dict(for key: String) -> [String: Any]? {
        return self[key] as? [String: Any]
    }

    func url(for key: String) -> URL? {
        return URL(string: self.string(for: key))
    }

    func array(for key: String) -> [Any]? {
        return self[key] as? [Any]
    }

}

// MARK: - Array

extension Array where Iterator.Element: Equatable {

    @discardableResult
    mutating func remove(element: Iterator.Element) -> Iterator.Element? {
        guard let index = self.firstIndex(of: element) else {
            return nil
        }
        return remove(at: index)
    }

}

// MARK: – Bundle extensions

extension Bundle {

}

// MARK: - URL

extension URL {
    init?(string: String?) {
        if let string = string {
            self.init(string: string)
        } else {
            return nil
        }
    }
}

// MARK: - String extensions

extension String {

    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }

    var decimalDigits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

}

// MARK: - RawRepresentable extensions

extension RawRepresentable {

    init?(rawValue: Self.RawValue?) {
        guard let rawValue = rawValue else {
            return nil
        }
        self.init(rawValue: rawValue)
    }

}
