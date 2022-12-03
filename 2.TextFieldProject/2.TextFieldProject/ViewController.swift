//
//  ViewController.swift
//  2.TextFieldProject
//
//  Created by Jade Yoo on 2022/12/01.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self   // 텍스트필드의 대리자가 뷰컨트롤러가됨
        
        setup()
    }
    
    func setup() {
        view.backgroundColor = UIColor.gray
        
        textField.keyboardType = UIKeyboardType.emailAddress    // 텍스트필드의 키보드 스타일
        textField.placeholder = "이메일 입력"
        textField.borderStyle = .roundedRect    // 텍스트필드의 선 스타일(디폴트: 라운디드)
        textField.clearButtonMode = .always     // 입력 텍스트 삭제가능한 x버튼
        textField.returnKeyType = .next         // 엔터의 형태
        
        // 텍스트필드가 첫번째로 반응하는 응답객체가 됨 -> 키보드 올라옴
        textField.becomeFirstResponder()        // UIResponder
    }
    
    // 화면에 탭을 감지(UIResponder)하는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 텍스트필드의 입력을 시작할 때 호출 (시작할지 말지의 여부를 허락하는 것)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 시점 - 유저의 입력이 시작되고나서
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트필드의 입력을 시작했다.")
    }
    
    // 입력내용 전체 삭제를 허락할 것인지
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print(#function)
        return true
        //return false    // x버튼을 눌러도 입력한 글자가 사라지지 않음
    }
    
    // 텍스트필드의 글자 내용이 (한글자 한글자) 입력되거나 지워질 때 호출이 되고 (허락)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(#function)
//        print(string)
        
        // 입력되고 있는 글자가 "숫자"인 경우 입력을 허용하지 않는 논리
        if Int(string) != nil {     // 숫자로 변환이 된다면 nil이 아닐테니
            return false
        } else {
            // 10글자 이상 입력되는 것을 막는 코드
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
        
//        // 10글자이상 입력되는 것을 막는 코드 (또다른 구현법)
//        if (textField.text?.count)! + string.count > 10 {
//            return false
//        } else {
//            return true
//        }
    }
    
    // 텍스트필드의 엔터키가 눌러지면 다음 동작을 허락할 것인지 말것인지
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        // 실제 텍스트필드에 아무것도 입력이 되어 있지 않으면, 입력을 끝내지 못하게
        if textField.text == "" {
            textField.placeholder = "Type Something!"
            return false
        } else {
            return true
        }
    }
    
    // 텍스트필드의 입력이 끝날 때 호출 (끝날지 말지를 허락)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트필드의 입력이 실제 끝났을 때 호출 (시점)
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        print("유저가 텍스트필드의 입력을 끝냈다.")
        textField.text = ""
    }
    

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        textField.resignFirstResponder()    // 첫번째 응답객체를 사임 -> 키보드 내려감
    }
    
}

