//
//  String+localized.swift
//  HerbSnap
//
//  Created by Jonathan Diebel on 31.12.22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
