//
//  MainModels.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 18.12.2022.
//

import Foundation


struct MainLoadTheme {
    struct Request {}
    struct Response {
        let loadState: LoadState
    }
    struct ViewModel {
        struct Success {}
        struct Failure {
            let error:Error
        }
        struct InProgress {}
     
    }
}
struct MainLevel{
    struct Request {
        let index: Int
    }
}
struct MainSelectedTheme {
    struct Request {
        let index: Int
    }
}
enum LoadState {
    case inProgress
    case success
    case failure(Error)
}
