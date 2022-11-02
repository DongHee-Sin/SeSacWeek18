//
//  SignUpViewController.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/02.
//

import UIKit

final class SignUpViewController: BaseViewController {

    // MARK: - Propertys
    
    
    
    
    // MARK: - Life Cycle
    let signupView = SignUpView()
    override func loadView() {
        view = signupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    // MARK: - Methods
    override func configure() {
        setNavigationBar()
    }
    
    
    private func setNavigationBar() {
        navigationItem.title = "회원가입"
    }
}
