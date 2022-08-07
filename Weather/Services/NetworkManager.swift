//
//  NetworkManager.swift
//  Weather
//
//  Created by Дарья Носова on 30.07.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    //URLSession
//    func fetchData(from url: String, with completion: @escaping(Result<ModelWeather, NetworkError>) -> Void) {
//        guard let url = URL(string: url) else {
//            completion(.failure(.invalidUrl))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                completion(.failure(.noData))
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let weather = try JSONDecoder().decode(ModelWeather.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(weather))
//                }
//            } catch let error {
//                completion(.failure(.decodingError))
//                print(error)
//            }
//        }.resume()
//    }
    
    //Alamofire
    func fetchDataAlamofire(from url: String, with completion: @escaping(Result<ModelWeather,NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: ModelWeather.self) { dataResponse in
                switch dataResponse.result {
                case .success(let weather):
                    completion(.success(weather))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
}
