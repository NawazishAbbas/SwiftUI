//
//  UsersViewModel.swift
//  MartorisApp
//
//  Created by Nawazish Abbas on 01/09/2025.
//

import Foundation
final class UsersViewModel: ObservableObject {
    var users: [User] = []
    @Published var hasError = false
    @Published var error: UserError?
    @Published private(set) var isRefreshing = false
    
    func fetchUsers() {
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
                            self?.users = users
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

extension UsersViewModel {
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
