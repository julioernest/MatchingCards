//
//  PlayInteractor.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 15.12.2022.
//

import Foundation


protocol PlayBusinessLogic {
    func loadTheme(request: Play.LoadGame.Request)
    func didTouchCard(request: Play.TouchCard.Request)
}

protocol PlayDataStore {
    var theme: Theme? { get set }
}
class PlayInteractor: PlayBusinessLogic, PlayDataStore {
    var presenter: PlayPresentationLogic?
    var theme: Theme?
    var cardsShown: [Play.Card] = []
    var score: Int = 0 {
        didSet {
            
        }
    }
    
    func loadTheme(request: Play.LoadGame.Request) {
        guard let theme = theme else { return }
        presenter?.presentLoadGame(response: .init(theme: theme))
    }
    
    func didTouchCard(request: Play.TouchCard.Request) {
        presenter?.presentShowCard(response: .init(card: request.card))
        
        if isTheCardCountOdd() {
            let unmatchedCard = lastUnmatchedCardInDeck()
            if request.card == unmatchedCard {
                cardsShown.append(request.card)
                presenter?.presentUpdateScore(response: .init(score: cardsShown.count / 2))
            } else {
                let secondCard = cardsShown.removeLast()
                
                presenter?.presentHideCard(response: .init(cards: [request.card, secondCard]))
            }
        } else {
            cardsShown.append(request.card)
        }
        
    }
    // isTheCardCountOdd == true means that in the stack is 1 card that dosent have a coresponded.
    private func isTheCardCountOdd() -> Bool {
        return cardsShown.count % 2 != 0
    }
    private func lastUnmatchedCardInDeck() -> Play.Card {
        // TODO: - Remove force unwrapp. Danger to crash
        return cardsShown.last!
    }
}
