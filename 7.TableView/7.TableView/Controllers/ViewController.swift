//
//  ViewController.swift
//  7.TableView
//
//  Created by Jade Yoo on 2022/12/06.
//

import UIKit

class ViewController: UIViewController {
    
    //var moviesArray: [Movie] = []
    
    var movieDataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = 120
        
        movieDataManager.makeMovieData()
        //moviesArray = movieDataManager.getMovieData()     // 필요할때마다 getMovieData()를 사용할수도
        
        // 스토리보드가 아닌 코드로 셀을 만들면, 셀 등록 코드 필요
        //tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
    }
    
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 반드시 실행 - (어떤 그룹의) 몇개의 컨텐츠를 만들면 되는지 알려주는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return movieDataManager.getMovieData().count
    }
    
    // 반드시 실행 - 몇번째 행에 있는 셀을 어떠한 방식으로 표시하라고 알려주는 메서드
    //indexPath.section: 그룹
    //indexPath.row: 행
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        // cell의 타입은 UITableViewCell이므로 실제적인 타입으로 타입캐스팅 필요
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let array = movieDataManager.getMovieData()
        
        let movie = array[indexPath.row]
        
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        
        cell.selectionStyle = .none     // 셀 선택시 나타나는 스타일. 디폴트는 .gray
        
        return cell
    }
}
