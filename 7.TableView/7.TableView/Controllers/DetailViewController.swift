//
//  DetailViewController.swift
//  7.TableView
//
//  Created by Jade Yoo on 2022/12/07.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // 전 화면에서 받아올 데이터 저장
    var movieData: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        mainImageView.image = movieData?.movieImage     // UIImage와 대입하려는 값 모두 옵셔널이라 벗길 필요 없음
        movieNameLabel.text = movieData?.movieName
        descriptionLabel.text = movieData?.movieDescription
    }
    
}
