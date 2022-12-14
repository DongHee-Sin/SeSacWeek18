//
//  CommonViewModel.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/03.
//

import Foundation


protocol CommonViewModel {
    associatedtype Input
    associatedtype Output
    
    func transfrom(input: Input) -> Output
}
