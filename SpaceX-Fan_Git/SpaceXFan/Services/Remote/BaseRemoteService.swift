//
//  BaseRemoteService.swift
//  SpaceXFan
//
//  Created by kavin Soni on 01/09/21.
//

import Foundation
import Foundation

enum APIServiceError: Error {
    case invalidURL
    case blankResponse
}

class BaseAPIService {
    private let baseURL:String = "https://api.spacexdata.com/v4/"
    
    let coreDataStack:CoreDataStackProtocol
    
    init(coreDataStack:CoreDataStackProtocol = CoreDataStack.shared) {
        self.coreDataStack = coreDataStack
    }
    
    func endpoint(_ endpoint:String) -> String{
        return "\(baseURL)\(endpoint)"
    }
    func get<T:Decodable>(url:String, expectedModel:T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(APIServiceError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(APIServiceError.blankResponse))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context!] = self.coreDataStack.context
                decoder.dateDecodingStrategy = .iso8601
                let decodedResponse = try decoder.decode(expectedModel.self, from: data)
                self.coreDataStack.saveContext()
                completion(.success(decodedResponse))
            } catch let decodingError {
                print("Error : \(decodingError)")
                
                completion(.failure(decodingError))
            }
        }.resume()
    }
}
