//
//  MainWorker.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 18.12.2022.
//

import Foundation

enum MainServiceErrors: Error {
    case unableToDecodeTheJSON(Error)
    case invalidStatusCode
    case dataIsMissing
    case invalidURL
    
}

class MainWorker {
    var webService = WebService.firebaseLink
    
    func loadData(completion: @escaping (Result<[Theme], Error>) -> Void) {
            guard let url = URL(string: webService) else {
                completion(.failure(MainServiceErrors.invalidURL))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    completion(.failure(MainServiceErrors.invalidStatusCode))
                    return
                }
                guard let data = data else {
                    completion(.failure(MainServiceErrors.dataIsMissing))
                    return }
                do {
                    let decodedDate = try JSONDecoder().decode([Theme].self, from: data)
                    completion(.success(decodedDate))
                } catch {
                    completion(.failure(MainServiceErrors.unableToDecodeTheJSON(error)))
                }
            }.resume()
    }
}
