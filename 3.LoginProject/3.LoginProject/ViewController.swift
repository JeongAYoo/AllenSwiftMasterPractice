//
//  ViewController.swift
//  3.LoginProject
//
//  Created by Jade Yoo on 2022/12/11.
//

import UIKit

final class ViewController: UIViewController {
    
    private let loginView = LoginView()
    
    // MARK: - View Life Cycle
    
    // viewDidLoad()보다 먼저 호출됨
    override func loadView() {
        // super.loadView() 필요없음
        view = loginView    // 기본 뷰를 교체
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
    }
    
    // MARK: - Helpers
    func setupAddTarget() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    /// 로그인 버튼 누르면 동작하는 함수
    @objc func loginButtonTapped() {
        print("로그인버튼이 눌렸습니다.")
        // 서버랑 통신해서, 다음 화면으로 넘어가는 내용 구현
    }
    
    /// 리셋버튼 누르면 동작하는 함수
    @objc func resetButtonTapped() {
        //print("리셋버튼이 눌렸습니다.")
        /// Alert창 띄우기
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인버튼이 눌렸습니다.")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { cancel in
            print("취소버튼이 눌렸습니다.")
        }
        alert.addAction(success)
        alert.addAction(cancel)
        
        // 다음화면으로 넘어가기(Alert 띄우기)
        present(alert, animated: true, completion: nil)
    }
    

}

