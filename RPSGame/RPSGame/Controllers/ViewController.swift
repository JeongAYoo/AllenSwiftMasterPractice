//
//  ViewController.swift
//  RPSGame
//
//  Created by Jade Yoo on 2022/10/07.
//

import UIKit

class ViewController: UIViewController {
    
    // 변수 / 속성
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var comImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var comChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    /// 가위바위보 게임(비즈니스 로직)관리 위한 인스턴스
    var rpsMananger = RPSMananger()
    
    // 데이터 저장을 위한 변수 (컴퓨터 선택/나의 선택)
//    var myChoice: Rps = Rps.rock
//    var comChoice: Rps = Rps(rawValue: Int.random(in: 0...2))!
    
    // 함수 / 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1) 첫번째/두번째 이미지뷰의 준비(묵) 이미지를 띄워야 함
        comImageView.image = rpsMananger.getReady().rpsInfo.image
        myImageView.image = rpsMananger.getReady().rpsInfo.image
        
        // 2) 첫번째/두번째 레이블에 "준비"라고 문자열을 띄워야 함
        comChoiceLabel.text = rpsMananger.getReady().rpsInfo.name
        myChoiceLabel.text = rpsMananger.getReady().rpsInfo.name
    }

    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        
        // 가위/바위/보(enum)를 선택해서 그 정보를 저장해야됨
        
        // 버튼의 문자를 가져옴
        //let title = sender.currentTitle!
        guard let title = sender.currentTitle else { return }
        print(title)
        
        // 가져온 문자를 분기처리해서 myChoice변수에 열거형 형태로 저장
        rpsMananger.userGetSelected(name: title)
    }

    @IBAction func selectButtonTapped(_ sender: UIButton) {
        
        // 1) 컴퓨터가 랜덤 선택한 것을 이미지뷰에 표시
        // 2) 컴퓨터가 랜덤 선택한 것을 레이블에 표시
        comImageView.image = rpsMananger.getComputerRPS().rpsInfo.image
        comChoiceLabel.text = rpsMananger.getComputerRPS().rpsInfo.name
        
        // 3) 내가 선택한 것을 이미지뷰에 표시
        // 4) 내가 선택한 것을 레이블에 표시
        myImageView.image = rpsMananger.getUserRPS().rpsInfo.image
        myChoiceLabel.text = rpsMananger.getUserRPS().rpsInfo.name
        
        // 5) 컴퓨터가 선택한 것과 내가 선택한 것을 비교해서 이겼는지/졌는지 판단/표시
        mainLabel.text = rpsMananger.getRpsResult()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 1) 컴퓨터가 다시 준비 이미지뷰에 표시
        // 2) 컴퓨터가 다시 준비 레이블에 표시
        comImageView.image = rpsMananger.getReady().rpsInfo.image
        comChoiceLabel.text = rpsMananger.getReady().rpsInfo.name
        
        // 3) 내 선택 이미지뷰에도 준비 이미지 를 표시
        // 4) 내 선택 레이블에도 준비 문자열 표시
        myImageView.image = rpsMananger.getReady().rpsInfo.image
        comChoiceLabel.text = rpsMananger.getReady().rpsInfo.name
        
        // 5) 메인 레이블에 "선택하세요" 표시
        mainLabel.text = "선택하세요"
        
        // 6) 컴퓨터가 다시 랜덤 가위/바위/보를 선택하고 저장
        rpsMananger.allReset()
        
    }
    
    
}

