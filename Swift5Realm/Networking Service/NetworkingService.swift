//
//  NetworkingService.swift
//  Swift5Realm
//
//  Created by Nir Leshem on 09/01/2021.
//

import Foundation
import Combine

class NetworkingService {
    
    private init() {}
    static let shared = NetworkingService()

//    func getUsers() -> AnyPublisher<APIUsersResponse, Error> {
//
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/") else {
//            fatalError("Invalid Url")
//        }
//
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .retry(3)
//            .tryMap { data, response -> Data in
//                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                    fatalError("statusCode Error")
//                }
//                return data
//            }
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
//    }
        
    private func getUrlSession() -> URLSession {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForResource = 30
        let session = URLSession(configuration: config)
        return session
    }

    func getUsers(completionHandler: @escaping (Result<[APIUser], NetworkingError>) -> ()) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/") else {
            completionHandler(.failure(.BadURL))
            return
        }

        let task = getUrlSession().dataTask(with: url) { (data, response, error) in

            guard let data = data, let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {

                do {
                    let users = try JSONDecoder().decode([APIUser].self, from: data)
                    completionHandler(.success(users))

                } catch let error as NSError {
                    print("Error:" + error.localizedDescription)
                    completionHandler(.failure(NetworkingError(error: error)))
                }

            } else {
                print("Error Response, statusCode : \(response.statusCode)")
                completionHandler(.failure(.ErrorStatusCode))
            }
        }

        task.resume()
    }
}
