//
//  MainPresenter.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 18.12.2022.
//

import Foundation
protocol MainPresentationLogic {
    func presentLoadData(response: MainLoadTheme.Response)
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
    
    func presentLoadData(response: MainLoadTheme.Response) {
        switch response.loadState {
        case .inProgress:
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.displayInProgressLoadData(viewModel: .init())
            }
        case .success:
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.displaySuccesLoadData(viewModel: .init())
            }
        case let .failure(error):
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.displayFailureLoadData(viewModel: .init(error: error))
            }
        }
        
    }
}
