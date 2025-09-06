//
//  MockUserRepository.swift
//  MartorisApp
//
//  Created by Nawazish Abbas on 06/09/2025.
//

import Foundation

class MockUserRepository: UserRepository {
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        let user = [
            User(id: 1000, name: "Mock User", email: "mock@gmail.com", company: Company(name: "Mock Company"))
        ]
        
        completion(user)
    }
}
