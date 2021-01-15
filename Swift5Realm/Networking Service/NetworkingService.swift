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
    
<<<<<<< HEAD
//    func getUsers() -> AnyPublisher<[APIUser], Error> {
=======
//    func getUsers() -> AnyPublisher<APIUsersResponse, Error> {
>>>>>>> f42c770d6212e1533ea2b66f3448d1d0c26b4cec
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
<<<<<<< HEAD
//            .decode(type: [APIUser].self, decoder: JSONDecoder())
=======
//            .decode(type: APIUsersResponse.self, decoder: JSONDecoder())
>>>>>>> f42c770d6212e1533ea2b66f3448d1d0c26b4cec
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
<<<<<<< HEAD

    func getUsers(completionHandler: @escaping (Result<[APIUser], NetworkingError>) -> ()) {

=======
    
    func getUsers(completionHandler: @escaping (Result<[APIUser], NetworkingError>) -> ()) {
        
>>>>>>> f42c770d6212e1533ea2b66f3448d1d0c26b4cec
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/") else {
            completionHandler(.failure(.BadURL))
            return
        }
<<<<<<< HEAD

=======
        
>>>>>>> f42c770d6212e1533ea2b66f3448d1d0c26b4cec
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
