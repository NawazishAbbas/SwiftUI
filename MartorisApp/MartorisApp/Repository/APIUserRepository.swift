//
//  APIUserRepository.swift
//  MartorisApp
//
//  Created by Nawazish Abbas on 06/09/2025.
//
import Foundation
import Alamofire

class APIUserRepository: UserRepository {
    var hasError = false
    var error: UserError?
    private(set) var isRefreshing = false

    func fetchUsers2(completion: @escaping ([User]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let users = [
                User(id: 100, name: "Test 1", email: "test1@gmail.com", company: Company(name: "test 1")),
                User(id: 101, name: "Test 2", email: "test2@gmail.com", company: Company(name: "test 2")),
                User(id: 102, name: "Test 3", email: "test3@gmail.com", company: Company(name: "test 3"))
            ]
            completion(users)
        }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        hasError = false
        isRefreshing = true
        APIClient.shared.request(endpoint: .usersList, completion: completion)
//        AF.request(usersUrlString).responseDecodable(of: [User].self) { [weak self] response in
//            switch response.result {
//            case .success(let tempUsers):
//                completion(tempUsers)
//            case .failure(let error):
//                self?.hasError = true
//                self?.error = UserError.custom(error: error)
//            }
//        }
    }
    
    func fetchUsersJSONDecoder(completion: @escaping([User]) -> Void) {
        hasError = false
        isRefreshing = true
        let usersUrlString = "https://jsonplaceholder.typicode.com/users"
        
        if let url = URL(string: usersUrlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.hasError = true
                        self?.error = UserError.custom(error: error)
                    } else {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        if let data = data, let users = try? decoder.decode([User].self, from: data) {
                            completion(users)
                        } else {
                            self?.hasError = true
                            self?.error = UserError.failedToDecode
                        }
                    }
                    
                    self?.isRefreshing = false
                }
            }.resume()
        }
    }
}

extension APIUserRepository {
    enum UserError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .custom(let error):
                return error.localizedDescription
            case .failedToDecode:
                return "Failed to decode response"
                
            }
        }
    }
}
