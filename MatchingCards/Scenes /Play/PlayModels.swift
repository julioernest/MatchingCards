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
    struct TouchCard {
        struct Request {
            let card: Play.Card
        }
        struct Response {
            let card: Play.Card
        }
        struct ViewModel {
            let card: Play.Card
        }
    }
    
    
    struct HideCards {
        struct Request {}
        struct Response {
            let cards: [Play.Card]
        }
        struct ViewModel {
            let cards: [Play.Card]
        }
    }
    struct Score {
        struct Response {
            let score: Int
        }
        struct ViewModel {
            let score: Int
        }
    }
    
    
    enum CardState {
        case back
        case front
        case matched
    }
    struct Card: Equatable {
        static func == (lhs: Play.Card, rhs: Play.Card) -> Bool {
            lhs.frontSymbol == rhs.frontSymbol
        }
        var id: IndexPath
        var frontSymbol: String
        
    }
}
