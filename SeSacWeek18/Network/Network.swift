//
//  Network.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/03.
//

import Foundation
import Alamofire


final class Network {
    
    static let share = Network()
    
    private init() {}
    
    
    func requestSeSAC<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod = .get, parameters: [String: String]? = nil, headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(url, method: method, parameters: parameters, headers: headers).responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))   // 탈출 클로저, Result Type, Enum, 연관값 ...
            case .failure(_):
                guard let statusCode = response.response?.statusCode else { return }
                guard let error = SeSacError(rawValue: statusCode) else { return }
                
                completion(.failure(error))
            }
        }
        
    }
    
}
