//
//  APIUserRepository.swift
//  MartorisApp
//
//  Created by Nawazish Abbas on 06/09/2025.
//
import Foundation

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

class APIUserRepository: UserRepository
{
    var error: UserError?

    func fetchUsers() async throws -> [User] {
        let users: [User] = try await APIClient.shared.load()
        return users
    }
}
