//
//  MainInteractor.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 18.12.2022.
//

import Foundation

protocol MainBusinessLogic {
    func loadData(request: MainLoadTheme.Request)
    func setLevel(request: MainLevel.Request)
    func setTheme(request: MainSelectedTheme.Request)
}

protocol MainDataStore {
    var theme: [Theme]? { get set }
    var level: Int { get set }
    var selectedThemeIndex: Int { get set }
}

class MainInteractor: MainBusinessLogic, MainDataStore {
 
    var presenter: MainPresentationLogic?
    var theme: [Theme]?
    var level: Int = 2
    var selectedThemeIndex: Int = 0
    
    func loadData(request: MainLoadTheme.Request) {
        let worker = MainWorker()
        presenter?.presentLoadData(response: .init(loadState: .inProgress))
        worker.loadData { [weak self] response in
            switch response {
            case let .success(theme):
                self?.theme = theme
                self?.presenter?.presentLoadData(response: .init(loadState: .success))
            case let .failure(error):
                self?.presenter?.presentLoadData(response: .init(loadState: .failure(error)))
                print(error)
            }
        }
    }
    
    func setLevel(request: MainLevel.Request ) {
        switch request.index {
        case 0:
            level = 2
        case 1:
            level = 4
        default:
            level = 2
        }
    }
    
    func setTheme(request: MainSelectedTheme.Request) {
        switch request.index {
        case 0:
            selectedThemeIndex = 0
        case 1:
            selectedThemeIndex = 1
        default:
            level = 0
        }
    }
    
   
}
