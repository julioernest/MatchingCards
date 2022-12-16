//
//  PlayPresenter.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 15.12.2022.
//

import Foundation

protocol PlayPresentationLogic {
    func presentLoadGame(response: Play.LoadGame.Response)
    func presentShowCard(response: Play.TouchCard.Response)
    func presentHideCard(response: Play.HideCards.Response)
    func presentUpdateScore(response: Play.Score.Response)
}

class PlayPresenter: PlayPresentationLogic {
    weak var viewController: PlayDisplayLogic?
    
    func presentLoadGame(response: Play.LoadGame.Response) {
        viewController?.displayLoadGame(viewModel: .init(theme: response.theme))
    }
    
    func presentShowCard(response: Play.TouchCard.Response) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayShowCard(viewModel: .init(card: response.card))
        }
    }
    func presentHideCard(response: Play.HideCards.Response) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.viewController?.displayHideCard(viewModel: .init(cards: response.cards))
        }
    }
    func presentUpdateScore(response: Play.Score.Response) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayScore(viewModel: .init(score: response.score))
        }
    }
}
