//
//  String.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 16.12.2022.
//

import Foundation

extension String {
    func localized( _ args: CVarArg...) -> String {
        return String(format: NSLocalizedString(self ,comment: ""), arguments: args)
    }
}
