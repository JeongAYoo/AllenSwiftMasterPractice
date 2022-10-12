//
//  ViewController.swift
//  DiceGame
//
//  Created by Jade Yoo on 2022/10/06.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    var diceImgArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func rollButtonTapped(_ sender: UIButton) {
        
        //첫번째 이미지뷰의 이미지를 랜덤으로 변경
        firstImageView.image = diceImgArray.randomElement()
        //두번째 이미지뷰의 이미지를 랜덤으로 변경
        secondImageView.image = diceImgArray.randomElement()
    }
    
}

