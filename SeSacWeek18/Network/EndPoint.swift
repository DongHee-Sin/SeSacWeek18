//
//  EndPoint.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/02.
//

import Foundation
import Alamofire


enum SeSacAPI {
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
    
    private var rawValue: String {
        switch self {
        case .signup: return "signup"
        case .login: return "login"
        case .profile: return "me"
        }
    }
}


extension SeSacAPI {
    
    var baseURL: String { "http://api.memolease.com/api/v1/users/" }
    
    var url: URL { URL(string: "\(baseURL)\(self.rawValue)")! }
    
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .profile:
            return [
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
    }
    
    
    var parameters: [String: String] {
        switch self {
        case .signup(let username, let email, let password):
            return [
                "userName": username,
                "email": email,
                "password": password
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default: return [:]
        }
    }
}
