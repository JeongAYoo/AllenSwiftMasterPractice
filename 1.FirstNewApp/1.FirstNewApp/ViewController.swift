//
//  ViewController.swift
//  1.FirstNewApp
//
//  Created by Jade Yoo on 2022/12/13.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
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
        
        let seconds = Int(slider.value * 60)    // 0.0 ~ 1.0
        mainLabel.text = "\(seconds)초"
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 1초씩 지나갈때마다 무엇가를 실행
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 초기화 셋팅
        mainLabel.text = "초를 선택하세요"
        slider.setValue(0.5, animated: true)
    }
    
}

