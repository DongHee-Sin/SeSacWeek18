//
//  SubscriptExample.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/03.
//

import Foundation


extension String {
    
    subscript(index: Int) -> String? {
        guard (0..<self.count).contains(index) else { return nil }
        
        let result = self.index(self.startIndex, offsetBy: index)
        
        return String(self[result])
    }
    
}




extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}




struct Phone {
    
    var numbers = ["1234", "5678", "1589", "9675"]
    
    subscript(index: Int) -> String {
        get {
            return self.numbers[index]
        }
        set {
            self.numbers[index] = newValue
        }
    }
}
