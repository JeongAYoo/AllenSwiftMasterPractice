//
//  MusicCell.swift
//  9.MusicApp
//
//  Created by Jade Yoo on 2023/01/06.
//

import UIKit

class MusicCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    /// 이미지 URL을 전달받는 속성
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
    // MARK: - Initializer
    // 스토리보드 또는 Nib으로 만들때, 사용하게 되는 생성자 코드
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainImageView.contentMode = .scaleToFill
    }

    // MARK: - Methods
    
    // 셀이 재사용되기 전에 호출되는 메서드
    override func prepareForReuse() {
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행
        self.mainImageView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /// URL => 이미지를 세팅하는 메서드
    private func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
}
