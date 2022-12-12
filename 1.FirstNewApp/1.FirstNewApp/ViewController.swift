//
//  ViewController.swift
//  1.FirstNewApp
//
//  Created by Jade Yoo on 2022/12/13.
//

import UIKit
import AVFoundation

final class ViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    // MARK: - Properties
    weak var timer: Timer?
    private var number = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Configure UI
    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.value = 0.5              // 슬라이더의 가운데 설정
    }
    
    // MARK: - IBAction
    @IBAction func sliderChanged(_ sender: UISlider) {
        // 슬라이더의 밸류값을 가지고 메인레이블의 텍스트를 세팅
        
        number = Int(sender.value * 60)    // 0.0 ~ 1.0
        mainLabel.text = "\(number)초"
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 1초씩 지나갈때마다 무언가를 실행
        timer?.invalidate()     // 타이머 비활성화
        
//        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(doSomethingAfter1Second), userInfo: nil, repeats: true)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            // 반복을 하고 싶은 코드
            if number > 0 {
                number -= 1
                // 슬라이더도 줄여야됨
                // 레이블 표시도 다시 해줘야 함
                slider.value = Float(number) / Float(60)
                mainLabel.text = "\(number) 초"
            } else {
                number = 0
                mainLabel.text = "초를 선택하세요"
                timer?.invalidate()     // 타이머 비활성화
                // 소리를 나게 해야함
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
        }
    }
    
//    @objc func doSomethingAfter1Second() {
//        if number > 0 {
//            number -= 1
//            // 슬라이더도 줄여야됨
//            // 레이블 표시도 다시 해줘야 함
//            slider.value = Float(number) / Float(60)
//            mainLabel.text = "\(number) 초"
//        } else {
//            number = 0
//            mainLabel.text = "초를 선택하세요"
//            timer?.invalidate()     // 타이머 비활성화
//            // 소리를 나게 해야함
//            AudioServicesPlayAlertSound(SystemSoundID(1322))
//        }
//    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 초기화 셋팅
        mainLabel.text = "초를 선택하세요"
        slider.setValue(0.5, animated: true)
        number = 0
        timer?.invalidate()
    }
}

