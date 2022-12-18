//
//  PlayViewControllerDisplayLogic.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 16.12.2022.
//

import Foundation

extension PlayViewController: PlayDisplayLogic {
    
    func displayLoadGame(viewModel: Play.LoadGame.ViewModel) {
        let theme = viewModel.theme
        navigationItem.title = theme.title
        self.defaultLevel = viewModel.level
        self.theme = theme
     
    }
    func displayShowCard(viewModel: Play.TouchCard.ViewModel) {
        
        guard let cell = collectionView.cellForItem(at: viewModel.card.id) as? PlayCollectionViewCell else {
            preconditionFailure("Couldn't get the cell at index = \(viewModel.card.id)")
        }
        cell.showCard(true, animated: true)
    }
    
    func displayHideCard(viewModel: Play.HideCards.ViewModel) {
        for card in viewModel.cards {
            guard let cell = collectionView.cellForItem(at: card.id) as? PlayCollectionViewCell else {
                preconditionFailure("Couldn't get the cell at index = \(card.id)")
            }
            cell.showCard(false, animated: true)
        }
    }
    func displayScore(viewModel: Play.Score.ViewModel) {
        let realScore = viewModel.score * 100 / counter
        scoreLabel.text = "Score is \(realScore)"
    }
}
