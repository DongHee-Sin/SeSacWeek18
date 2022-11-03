//
//  APIService.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/02.
//

import Foundation
import Alamofire


struct Login: Codable {
    let token: String
}


struct Profile: Codable {
    let user: User
}


struct User: Codable {
    let photo: String
    let email: String
    let username: String
}


enum SeSacError: Int, Error {
    case invalidAuthorization = 401
    case tokenEmail = 406
    case emptyParameters = 501
}

extension SeSacError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidAuthorization:
            return "토큰이 만료되었습니다. 다시 로그인 해주세요."
        case .tokenEmail:
            return "이미 가입된 회원입니다. 로그인 해주세요"
        case .emptyParameters:
            return "뭔가가 없습니다."
        }
    }
}




final class APIService {
    
    func signup(userName: String, email: String, password: String) {
        let api = SeSacAPI.signup(userName: userName, email: email, password: password)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print("error : \(error.localizedDescription)")
            }
        }
    }
    func login(email: String, password: String) {
        let api = SeSacAPI.login(email: email, password: password)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in
                
            switch response.result {
            case .success(let data):
                print(data.token)
                UserDefaults.standard.set(data.token, forKey: "token")
            case .failure(_):
                print("error : \(response.response?.statusCode)")
            }
        }
    }
    func profile() {
        let api = SeSacAPI.profile
        
        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: Profile.self) { response in
            switch response.result {
            case .success(let data):
                print(data.user)
            case .failure(_):
                print(response.response?.statusCode)
            }
        }
    }
    
    
    
    
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
