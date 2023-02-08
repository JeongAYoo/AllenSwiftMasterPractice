//
//  SearchResultViewController.swift
//  9.MusicApp
//
//  Created by Jade Yoo on 2023/01/07.
//

import UIKit

final class SearchResultViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 컬렉션뷰의 레이아웃을 담당하는 객체
    let flowLayout = UICollectionViewFlowLayout()
    
    // 네트워크 매니저 (싱글톤)
    let networkManager = NetworkManager.shared
    
    var musicArrays: [Music] = []
    
    /// (서치바에서) 검색을 위한 단어를 담는 변수 (전화면에서 전달받음)
    var searchTerm: String? {
        didSet {
            setupDatas()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    // MARK: - Methods
    func setupCollectionView() {
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .white
        // 컬렉션뷰의 스크롤 방향 설정
        flowLayout.scrollDirection = .vertical
        
        // 셀의 너비 = 화면 너비 - (줄간격 * 셀의 갯수 - 1) / 셀의 갯수
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWidth * (CVCell.cellColumns - 1)) / CVCell.cellColumns
        
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        // 아이템 사이 간격 설정
        flowLayout.minimumInteritemSpacing = CVCell.spacingWidth
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = CVCell.spacingWidth
        
        // 컬렉션뷰의 속성에 할당
        collectionView.collectionViewLayout = flowLayout
    }
    
    func setupDatas() {
        guard let term = searchTerm else { return }
        print("네트워킹 시작 단어: \(term)")
        
        // (네트워킹 시작전에) 다시 빈배열로 만들기
        self.musicArrays = []
        
        // 네트워킹 시작 (찾고자하는 단어를 가지고)
        networkManager.fetchMusic(searchTerm: term) { result in
            switch result {
            case .success(let musicDatas):
                self.musicArrays = musicDatas
                // 메인스레드에서 컬렉션뷰를 리로드
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionView DataSource
extension SearchResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArrays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.musicCollectionViewCellIdentifier, for: indexPath) as! MusicCollectionViewCell
        cell.imageUrl = musicArrays[indexPath.item].imageUrl
        
        return cell
    }
    
}
