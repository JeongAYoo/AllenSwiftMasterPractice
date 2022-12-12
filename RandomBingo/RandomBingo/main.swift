//
//  main.swift
//  RandomBingo
//
//  Created by Jade Yoo on 2022/10/08.
//

import Foundation

/// 컴퓨터의 랜덤 숫자 선택
var computerChoice = Int.random(in: 1...100)
/// 나의 선택 (일단 0으로 시작)
var myChoice: Int = 0

// 반복문 (조건에 따른 반복문 실행)
while true {
    // 디버그 영역에 입력된 문자열 읽어오는 함수
    var userInput = readLine()
    
    // 옵셔널 스트링을 벗기고, 숫자로 변환해서 다시 벗기기
//    if let input = userInput {
//        if let number = Int(input) {
//            myChoice = number
//        }
//    }
    
    // 위와 동일한 코드
    if let input = userInput, let number = Int(input) {
        myChoice = number
    }
    
    //print(myChoice)
    
    // 업인지 / 다운인지 /
    if computerChoice > myChoice {
        print("Up")
    } else if computerChoice < myChoice {
        print("Down")
    } else {
        print("Bingo")
        break   // 반복문을 종료
    }
}
