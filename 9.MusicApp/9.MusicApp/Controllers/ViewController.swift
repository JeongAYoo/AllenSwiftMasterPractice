//
//  ViewController.swift
//  9.MusicApp
//
//  Created by Jade Yoo on 2022/12/29.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    
    // 서치 컨트롤러 생성 ==> 네비게이션 아이템에 할당
//    let searchController = UISearchController()
    
    // 서치 Results 컨트롤러 ⭐️
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    @IBOutlet weak var musicTableView: UITableView!
    
    /// 네트워크 매니저(싱글톤)
    var networkManager = NetworkManager.shared
    
    /// 음악데이터를 다루기 위한 배열 (빈 배열로 시작)
    var musicArrays: [Music] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        setupDatas()
    }
    
    // MARK: - Methods
    func setupSearchBar() {
        self.title = "Music Search"
        navigationItem.searchController = searchController
        // 1) 단순 서치바의 사용
        //searchController.searchBar.delegate = self
        
        // 2) 서치 Results 컨트롤러의 사용 (복잡한 구현 가능)
        searchController.searchResultsUpdater = self
        
        // 첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
    }
    
    /// 테이블 뷰 세팅
    func setupTableView() {
        musicTableView.dataSource = self
        musicTableView.delegate = self
        // Nib파일을 사용위해 등록
        musicTableView.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
    }
    
    /// 데이터 셋업
    func setupDatas() {
        // 네트워킹 시작
        networkManager.fetchMusic(searchTerm: "jazz") { result in
            switch result {
            case .success(let musicDatas):
                self.musicArrays = musicDatas
                // 테이블뷰 리로드
                DispatchQueue.main.async {
                    self.musicTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

// MARK: - UITableView DataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        
        let musicElement = musicArrays[indexPath.row]
        
        cell.imageUrl = musicElement.imageUrl
        cell.songNameLabel.text = musicElement.songName
        cell.artistNameLabel.text = musicElement.artistName
        cell.albumNameLabel.text = musicElement.albumName
        cell.releaseDateLabel.text = musicElement.releaseDateString
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}
// MARK: - UITableView Delegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}

// MARK: - UISearchBar Delegate (단순) 서치바 확장
//extension ViewController: UISearchBarDelegate {
//
////    // 유저가 글자를 입력하는 순간마다 호출되는 메서드
////    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
////        print(searchText)
////        // (검색결과를 보여줄 새로운 테이블을 만들거니까) 다시 빈 배열로 만들기⭐️
////        self.musicArrays = []
////
////        // 네트워킹 시작
////        networkManager.fetchMusic(searchTerm: searchText) { result in
////            switch result {
////            case .success(let musicDatas):
////                self.musicArrays = musicDatas
////                DispatchQueue.main.async {
////                    self.musicTableView.reloadData()
////                }
////            case .failure(let error):
////                print(error.localizedDescription)
////            }
////        }
////    }
//
//    // 검색(Search) 버튼을 눌렀을 때 호출되는 메서드
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }
//        print(text)
//        // 다시 빈 배열로 만들기⭐️
//        self.musicArrays = []
//
//        // 네트워킹 시작
//        networkManager.fetchMusic(searchTerm: text) { result in
//            switch result {
//            case .success(let musicDatas):
//                self.musicArrays = musicDatas
//                DispatchQueue.main.async {
//                    self.musicTableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        self.view.endEditing(true)
//    }
//}

// MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    
    // (필수) 유저가 글자를 입력하는 순간마다 호출되는 메서드 ==> 일반적으로 다른 화면을 보여줄 때 구현
    func updateSearchResults(for searchController: UISearchController) {
        //print("서치바에 입력되는 단어", searchController.searchBar.text)
        
        // 글자를 치는 순간에 다른 화면을 보여주고 싶다면 (컬렉션뷰를 보여줌)
        let vc = searchController.searchResultsController as! SearchResultViewController
        // 컬렉션뷰에 찾으려는 단어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
    
}
