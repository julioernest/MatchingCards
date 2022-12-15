//
//  Theme.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 14.12.2022.
//

import Foundation


struct Theme: Decodable {
    let card_color: CardColors
    let card_symbol: String
    let symbols: [String]
    let title: String
    
    struct CardColors: Decodable {
        let blue: Double
        let green: Double
        let red: Double
    }
}
