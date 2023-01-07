//
//  NetworkManager.swift
//  9.MusicApp
//
//  Created by Jade Yoo on 2022/12/31.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

// MARK: - NetworkManager
final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    typealias NetworkCompletion = (Result<[Music], NetworkError>) -> Void
    
    /// 네트워킹 요청하는 함수 (음악데이터 가져오기)
    func fetchMusic(searchTerm: String, completion: @escaping NetworkCompletion) {
        let urlString = "\(MusicAPI.requestUrl)\(MusicAPI.mediaParam)&term=\(searchTerm)"
        print(urlString)
        
        performRequest(with: urlString) { result in
            completion(result)
        }
        
    }
    
    /// 실제 Request하는 함수 (비동기적 실행 -> 클로저 방식으로 끝난 시점을 전달받도록 설계)
    private func performRequest(with urlString: String, completion: @escaping NetworkCompletion) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            if let musics = self.parseJSON(safeData) {
                print("Parse 실행")
                completion(.success(musics))
            } else {
                print("Parse 실패")
                completion(.failure(.parseError))
            }
            
        }
        task.resume()
    }
    
    /// 받아온 데이터 분석하는 함수 (동기적 실행)
    private func parseJSON(_ musicData: Data) -> [Music]? {
        //성공
        do {
            let musicData = try JSONDecoder().decode(MusicData.self, from: musicData)
            return musicData.results
        //실패
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
