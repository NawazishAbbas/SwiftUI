//
//  NetworkClientProtocol.swift
//  MartorisApp
//
//  Created by Nawazish Abbas on 20/09/2025.
//

import Foundation
import Alamofire

protocol NetworkClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint, completion: ((T) -> ())?)
}
