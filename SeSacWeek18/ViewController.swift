//
//  ViewController.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/02.
//

import UIKit


class ViewController: UIViewController {

    let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.profile()
    }


}
