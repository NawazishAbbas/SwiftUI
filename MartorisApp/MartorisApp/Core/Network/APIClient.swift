//
//  APIClient.swift
//  MartorisApp
//
//  Created by Nawazish Abbas on 20/09/2025.
//

import Foundation
import Alamofire

enum Endpoint: String {
    case usersList = "https://jsonplaceholder.typicode.com/users"
}

class APIClient: NetworkClientProtocol
{
    static let shared = APIClient()
    
    func request<T: Decodable>(endpoint: Endpoint, completion: ((T) -> ())?) {
        AF.request(endpoint.rawValue).responseDecodable(of: T.self) { response in
            if response.response?.statusCode == 200, let value = response.value {
                completion?(value)
            }
        }
    }
}
