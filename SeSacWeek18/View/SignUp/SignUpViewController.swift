//
//  SignUpViewController.swift
//  SeSacWeek18
//
//  Created by 신동희 on 2022/11/02.
//

import UIKit

import RxSwift
import RxCocoa


final class SignUpViewController: BaseViewController {

    // MARK: - Propertys
    private let viewModel = SignUpViewModel()
    
    
    
    
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
        view.backgroundColor = .white
        
        setNavigationBar()
        bind()
    }
    
    
    private func setNavigationBar() {
        navigationItem.title = "회원가입"
    }
    
    
    private func bind() {
        
        signupView.userNameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.userName)
            .disposed(by: disposeBag)
        
        signupView.emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        signupView.passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        
        viewModel.userName
            .map { $0.count >= 2 }
            .bind(to: signupView.emailTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.email
            .map { self.isValidEmail(value: $0) }
            .bind(to: signupView.passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.password
            .map { $0.count >= 8 }
            .bind(to: signupView.signupButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
        
    }
    
    
    private func isValidEmail(value: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: value)
    }
}
