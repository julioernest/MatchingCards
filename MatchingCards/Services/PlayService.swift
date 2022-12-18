//
//  PlayService.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 14.12.2022.
//

import Foundation

enum PlayServiceErrors: Error {
    case unableToDecodeTheJSON(Error)
    case invalidStatusCode
    case dataIsMissing
    case invalidURL
    
}

class PlayService {
    func getConcentrationGameThemes(url: String, completion: @escaping (Result<[Theme], Error>) -> Void) {
        let url  = "https://firebasestorage.googleapis.com/v0/b/concentrationgame-20753.appspot.com/o/themes.json?alt=media&token=6898245a-0586-4fed-b30e-5078faeba078"
        
        guard let url = URL(string: url) else {
            completion(.failure(PlayServiceErrors.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(PlayServiceErrors.invalidStatusCode))
                return
            }
            guard let data = data else {
                completion(.failure(PlayServiceErrors.dataIsMissing))
                return }
            do {
                let decodedDate = try JSONDecoder().decode([Theme].self, from: data)
                completion(.success(decodedDate))
            } catch {
                completion(.failure(PlayServiceErrors.unableToDecodeTheJSON(error)))
            }
        }.resume()
    }
}
