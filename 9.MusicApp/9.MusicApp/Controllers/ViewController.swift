//
//  ViewController.swift
//  9.MusicApp
//
//  Created by Jade Yoo on 2022/12/29.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var musicTableView: UITableView!
    
    /// 네트워크 매니저(싱글톤)
    var networkManager = NetworkManager.shared
    
    /// 음악데이터를 다루기 위한 배열 (빈 배열로 시작)
    var musicArrays: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        setupDatas()
    }
    
    func setupSearchBar() {
        
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
        networkManager.fetchMusic(searchTerm: "hiphop") { result in
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        
        return cell
    }
    
    
}
// MARK: - UITableView Delegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
