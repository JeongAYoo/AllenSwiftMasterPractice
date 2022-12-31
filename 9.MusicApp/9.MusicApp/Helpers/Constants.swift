//
//  Constants.swift
//  9.MusicApp
//
//  Created by Jade Yoo on 2022/12/31.
//

import UIKit

// MARK: - Name Space

// 데이터 영역에 저장 (열거형, 구조체 다 가능 / 전역 변수로도 선언 가능)
/// API 문자열 묶음
public enum MusicAPI {
    static let requestUrl = "http://itunes.apple.com/search?"
    static let mediaParam = "media=music"
}

/// Cell 문자열 묶음
public struct Cell {
    static let musicCellIdentifier = "MusicCell"
    static let musicCollectionViewCellIdentifier = "MusicCollectionViewCell"
    private init() {}   // 다른 곳에서 생성자를 통해서 인스턴스를 생성하지 못하도록 막기
}

/// 컬렉션뷰 구성을 위한 설정
public struct CVCell {
    static let spacingWidth: CGFloat = 1
    static let cellColumns: CGFloat = 3
    private init() {}
}
