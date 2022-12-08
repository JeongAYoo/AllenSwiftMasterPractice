//
//  ViewController.swift
//  7.TableView
//
//  Created by Jade Yoo on 2022/12/06.
//

import UIKit

class ViewController: UIViewController {
    
    //var moviesArray: [Movie] = []
    
    // MVC패턴을 위한 데이터 매니저 (배열 관리 - 데이터)
    var movieDataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupDatas()
        
        // 스토리보드가 아닌 코드로 셀을 만들면, 셀 등록 코드 필요
        //tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
    }
    
    func setupTableView() {
        //델리게이트 패턴의 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        // 셀의 높이 설정
        tableView.rowHeight = 120
    }
    
    func setupDatas() {
        movieDataManager.makeMovieData()        // 일반적으로는 서버에 요청
        //moviesArray = movieDataManager.getMovieData()     // 데이터 받아서 뷰컨의 배열에 저장
        // 또는 필요할때마다 getMovieData()를 사용할수도
    }
    

}

extension ViewController: UITableViewDataSource {
    
    // 1. 테이블뷰에 (어떤 그룹의) 몇개의 데이터를 표시할 것인지를 뷰컨트롤러에게 물어보는 메서드 (반드시 구현)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return movieDataManager.getMovieData().count
    }
    
    // 2. 셀의 구성(몇번째 행에 있는 셀을 어떠한 방식으로 표시)을 뷰컨트롤러에게 물어보는 메서드 (반드시 구현)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        // (힙에 올라간) 재사용 가능한 셀을 꺼내서 사용하는 메서드 (애플이 미리 잘 만들어 놓음)
        // (스토리보드로 구현시, 사전에 셀을 등록하는 과정이 내부 매커니즘에 존재)
        // cell의 타입은 UITableViewCell이므로 실제적인 타입으로 타입캐스팅 필요
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let array = movieDataManager.getMovieData()
        let movie = array[indexPath.row]
        
        //indexPath.section: 그룹
        //indexPath.row: 행
        
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        
        cell.selectionStyle = .none     // 셀 선택시 나타나는 스타일. 디폴트는 .gray
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // 셀이 선택되었을 때 호출되며, 어떤 동작을 할것인지 뷰컨트롤러에게 물어보는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 세그웨이를 실행 - 화면전환
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    // prepare 세그웨이 (데이터 전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            
            let array = movieDataManager.getMovieData()
            let indexPath = sender as! IndexPath    // Any타입인 sender를 IndexPath타입으로 캐스팅
            detailVC.movieData = array[indexPath.row]   // 우리가 전달하기 원하는 영화 데이터. 배열에서 아이템을 꺼내서, 다음화면으로 전달
        }
    }
}
