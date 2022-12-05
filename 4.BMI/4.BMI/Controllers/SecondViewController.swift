//
//  SecondViewController.swift
//  4.BMI
//
//  Created by Jade Yoo on 2022/12/05.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
//    // 전화면에서 전달받은 데이터들
//    var bmiNumber: Double?
//    var adviceString: String?
//    var bmiColor: UIColor?
    
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()        // guard let보다 먼저 실행. 아래서 nil이 나오더라도 ui는 만들어지도록
        
        //전화면에서 전달받은 데이터들을 통해 셋팅
        guard let bmi = bmi else { return }
        bmiNumberLabel.text = "\(bmi.value)"
        bmiNumberLabel.backgroundColor = bmi.matchColor
        adviceLabel.text = bmi.advice
    }
    
    func makeUI() {
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        backButton.setTitle("다시 계산하기", for: .normal)
        
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
        
//        guard let bmi = bmiNumber else { return }
//        bmiNumberLabel.text = String(bmi)
//
//        adviceLabel.text = adviceString     // 어차피 옵셔널이라 벗길필요 없음
//        bmiNumberLabel.backgroundColor = bmiColor
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        // 전 화면으로 돌아가는 메서드
        self.dismiss(animated: true)
    }
    
}
