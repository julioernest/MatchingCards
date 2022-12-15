//
//  PlayService.swift
//  MatchingCards
//
//  Created by Julio-Ernest Costache on 14.12.2022.
//

import Foundation

class PlayService {
    func getConcentrationGameThemes(completion: @escaping (Result<[Theme], Error>) -> Void) {
        let url  = "https://firebasestorage.googleapis.com/v0/b/concentrationgame-20753.appspot.com/o/themes.json?alt=media&token=6898245a-0586-4fed-b30e-5078faeba078"
        
        guard let url = URL(string: url) else { fatalError()}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            guard let data = data else { return }
            do {
                let decodedDate = try JSONDecoder().decode([Theme].self, from: data)
                completion(.success(decodedDate))
            } catch {
                print(error)
            }
        }.resume()
    }
}
