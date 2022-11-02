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
}
