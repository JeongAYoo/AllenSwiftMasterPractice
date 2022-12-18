//
//  ViewController.swift
//  UpDownGame
//
//  Created by Jade Yoo on 2022/10/08.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var upDownMananger = UpDownMananger()

    //앱의 화면에 들어오면 가장 처음에 실행되는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }
    
    func reset() {
        // 1) 메인레이블에 "선택하세요"
        mainLabel.text = "선택하세요"
        
        // 2) 숫자레이블은 "" (빈 문자열)
        numberLabel.text = ""
        
        // 3) 컴퓨터의 랜덤숫자를 다시 선택하게
        upDownMananger.resetNum()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        // 1) 버튼의 숫자를 가져와야함
        guard let numString = sender.currentTitle else { return }
        
        // 2) 숫자 레이블이 숫자에 따라 변하도록
        numberLabel.text = numString
        
        // 3) 선택한 숫자를 변수에다가 저장 (선택) 문자열 ---> 숫자로 변환한 다음 저장
//        guard let num = Int(numString) else { return }
//        myNumber = num
        
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        
        // 또 다른 방법 제시
        // 숫자레이블에 있는 문자열 가져오기 (옵셔널 벗기기)
        // 타입 변환 (문자열 ---> 정수로)

        guard let myNumString = numberLabel.text,
            let myNumber = Int(myNumString) else {
            return
        }
        
        upDownMananger.setUsersNum(num: myNumber)
        mainLabel.text = upDownMananger.getUpDownResult()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        reset()
    }
}

