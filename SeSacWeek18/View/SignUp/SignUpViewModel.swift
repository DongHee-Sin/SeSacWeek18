//
//  SignUpViewModel.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/03.
//

import Foundation

import RxSwift
import RxCocoa


final class SignUpViewModel {
    
    let userName = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
}




extension SignUpViewModel: CommonViewModel {
    
    struct Input {}
    
    struct Output {}
    
    
    func transfrom(input: Input) -> Output {
        return Output()
    }
}
