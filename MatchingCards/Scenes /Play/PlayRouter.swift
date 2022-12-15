//
//  PlayRouter.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 15.12.2022.
//

import Foundation

protocol PlayRoutingLogic {
    
}
protocol PlayDataPassing {
    var dataStore: PlayDataStore? { get }
}
class PlayRouter: PlayRoutingLogic, PlayDataPassing {
    weak var viewController: PlayViewController?
    var dataStore: PlayDataStore?
}
