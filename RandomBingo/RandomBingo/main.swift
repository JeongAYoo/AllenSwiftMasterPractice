//
//  main.swift
//  RandomBingo
//
//  Created by Jade Yoo on 2022/10/08.
//

import Foundation

var computerChoice = Int.random(in: 1...100)
var myChoice: Int = 0

while true {
    
    var userInput = readLine()
    
    if let input = userInput {
        if let number = Int(input) {
            myChoice = number
        }
    }
    
    //print(myChoice)
    
    if computerChoice > myChoice {
        print("Up")
    } else if computerChoice < myChoice {
        print("Down")
    } else {
        print("Bingo")
        break   // 반복문을 종료
    }
}
