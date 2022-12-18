//
//  MainRouter.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 18.12.2022.
//

import Foundation
import UIKit

protocol MainRoutingLogic {
    func showPlayScene()
}
protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

class MainRouter: MainRoutingLogic, MainDataPassing {
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
    
    func showPlayScene() {
        guard
            let themeArray = dataStore?.theme,
            let level = dataStore?.level,
            let selectedTheme = dataStore?.selectedThemeIndex,
            let nextViewController = UIStoryboard(name: "Play", bundle: nil).instantiateInitialViewController() as? PlayViewController else { return }
        
        var dataStore = nextViewController.router?.dataStore
        // TODO: - Very unsafe accessing array. Should not be pushed to prod like this
        dataStore?.theme = themeArray[selectedTheme]
        dataStore?.level = level
        
        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
