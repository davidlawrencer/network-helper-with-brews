//
//  BrewModel.swift
//  brewery-app-with-wrappers
//
//  Created by David Rifkin on 9/5/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
import UIKit

struct Brewery: Codable {
    let name: String
    let city: String
    let state: String
    
    static func getBrewskis(completionHandler: @escaping (Result<[Brewery],AppError>) -> () ) {
        let url = "https://api.openbrewerydb.org/breweries?by_state=new_york"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let brewskis = try JSONDecoder().decode([Brewery].self, from: data)
                    completionHandler(.success(brewskis))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}
