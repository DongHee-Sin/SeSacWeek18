//
//  BaseTextField.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/02.
//

import UIKit


final class BaseTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func initialSetting() {
        self.backgroundColor = .lightGray
        self.textColor = .black
    }
}
