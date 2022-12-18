//
//  UpDownManager.swift
//  UpDownGame
//
//  Created by Jade Yoo on 2022/12/19.
//

import Foundation

struct UpDownMananger {
    // 컴퓨터가 랜덤으로 숫자 선택 (1...10)
    private var compNumber = Int.random(in: 1...10)
    
    // 내가 선택한 숫자를 담는 변수
    private var myNumber: Int = 1
    
    mutating func resetNum() {
        compNumber = Int.random(in: 1...10)
        myNumber = 1
    }
    
    mutating func setUsersNum(num: Int) {
        myNumber = num
    }
    
    func getUpDownResult() -> String {
        // 1) 컴퓨터의 숫자와 내가 선택한 숫자를 비교 Up / Down / Bingo 리턴
        if compNumber > myNumber {
            return "Up"
        } else if compNumber < myNumber {
            return "Down"
        } else {
            return "Bingo😎"
        }
    }
}
