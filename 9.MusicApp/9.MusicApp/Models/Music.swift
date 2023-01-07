//
//  Music.swift
//  9.MusicApp
//
//  Created by Jade Yoo on 2022/12/31.
//

import Foundation

//MARK: - Music Data Model

/// 실제 API에서 받게 되는 정보
struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

/// 실제 우리가 사용하게될 음악(Music) 모델 구조체
struct Music: Codable {
    let songName: String?
    let artistName: String?
    let albumName: String?
    let previewUrl: String?
    let imageUrl: String?
    private let releaseDate: String?
    
    // 네트워크에서 주는 이름을 변환하는 방법 (원시값)
    enum CodingKeys: String, CodingKey {
        case songName = "trackName"
        case artistName
        case albumName = "collectionName"
        case previewUrl
        case imageUrl = "artworkUrl100"
        case releaseDate
    }
    
    // 계산 속성. 날짜 형식 "yyyy-MM-dd"로 변환
    var releaseDateString: String? {
        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)
        // String => Date로 변환
        guard let isoDate = ISO8601DateFormatter().date(from: releaseDate ?? "") else {
            return ""
        }
        
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = myFormatter.string(from: isoDate)  // 다시 문자열로 변환
        return dateString
    }
}
