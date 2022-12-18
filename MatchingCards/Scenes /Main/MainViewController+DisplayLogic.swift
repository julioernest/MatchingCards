//
//  MainViewController+DisplayLogic.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 18.12.2022.
//

import Foundation
import UIKit

protocol MainDisplayLogic: AnyObject {
    func displaySuccesLoadData(viewModel: MainLoadTheme.ViewModel.Success)
    func displayFailureLoadData(viewModel: MainLoadTheme.ViewModel.Failure)
    func displayInProgressLoadData(viewModel: MainLoadTheme.ViewModel.InProgress)
}

extension MainViewController: MainDisplayLogic {
    func displaySuccesLoadData(viewModel: MainLoadTheme.ViewModel.Success) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        playButton.isHidden = false
        themeSegmentedControll.isHidden = false
        levelSegmentedControll.isHidden = false
        
        // TODO: - Hard coding this elements is very unreliable. I used it just for making fast a UI experience improvment.
        themeSegmentedControll.setTitle(router?.dataStore?.theme?[0].symbols[0], forSegmentAt: 0)
        themeSegmentedControll.setTitle(router?.dataStore?.theme?[1].card_symbol, forSegmentAt: 1)
        
        
        
    }
    
    func displayFailureLoadData(viewModel: MainLoadTheme.ViewModel.Failure) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        let alert = UIAlertController(title: "main.error.label".localized(), message: viewModel.error.localizedDescription, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "main.retry.label".localized(), style: .default) { [weak self] _ in
            self?.loadData()
        }
        alert.addAction(retryAction)
        present(alert, animated: true)
    }
    
    func displayInProgressLoadData(viewModel: MainLoadTheme.ViewModel.InProgress) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        levelSegmentedControll.isHidden = true
        themeSegmentedControll.isHidden = true
        playButton.isHidden = true
    }

}
