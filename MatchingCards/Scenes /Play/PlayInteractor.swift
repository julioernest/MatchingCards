//
//  PlayInteractor.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 15.12.2022.
//

import Foundation


protocol PlayBusinessLogic {
    func loadTheme(request: Play.LoadGame.Request)
}

protocol PlayDataStore {
    var theme: Theme? { get set }
}
class PlayInteractor: PlayBusinessLogic, PlayDataStore {
    var presenter: PlayPresentationLogic?
    var theme: Theme?
    
    func loadTheme(request: Play.LoadGame.Request) {
        guard let theme = theme else { return }
        presenter?.presentLoadGame(response: .init(theme: theme))
    }
}
