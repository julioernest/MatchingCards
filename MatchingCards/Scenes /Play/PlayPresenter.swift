//
//  PlayPresenter.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 15.12.2022.
//

import Foundation

protocol PlayPresentationLogic {
    func presentLoadGame(response: Play.LoadGame.Response)
}

class PlayPresenter: PlayPresentationLogic {
    weak var viewController: PlayDisplayLogic?
    
    func presentLoadGame(response: Play.LoadGame.Response) {
        viewController?.displayLoadGame(viewModel: .init(theme: response.theme))
    }
}
