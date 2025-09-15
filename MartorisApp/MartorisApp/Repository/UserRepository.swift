//
//  UserRepository.swift
//  MartorisApp
//
//  Created by Nawazish Abbas on 06/09/2025.
//

protocol UserRepository {
    func fetchUsers(completion: @escaping([User]) -> Void)
}
