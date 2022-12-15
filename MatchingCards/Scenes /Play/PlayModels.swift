//
//  PlayModels.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 15.12.2022.
//

import Foundation
import UIKit

struct Play {
    struct LoadGame {
        struct Request {}
        struct Response {
            let theme: Theme
        }
        struct ViewModel {
            let theme: Theme
        }
    }
    enum CardState {
        case back
        case front
        case matched
    }
    struct Card: Equatable {
        static func == (lhs: Play.Card, rhs: Play.Card) -> Bool {
            return lhs.state == rhs.state &&
            lhs.frontSymbol == rhs.frontSymbol
        }
        
        var state: CardState
        var frontSymbol: String
        
    }
}
