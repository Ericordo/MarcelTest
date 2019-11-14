//
//  NetworkService.swift
//  MarcelTest
//
//  Created by Eric Ordonneau on 30/10/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//


import Foundation

class NetworkService {
    
    private init() {}
    
    static let shared = NetworkService()
    
    func getFavoritesData(completion: @escaping (Result<[Favorite], Error>) -> Void) {
        var favorites : [Favorite] = []
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        let endpoint = "https://api.myjson.com/bins/fztyg"
        let safeURLString = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let endpointURL = URL(string: safeURLString!) else {
            print("The URL is invalid")
            return
        }
        
        var request = URLRequest(url: endpointURL)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data else {
                print("The payload is invalid")
                return
            }
            let decoder = JSONDecoder()
            do {
                let favoritesDictionary = try decoder.decode([String : [Favorite]].self, from: dataResponse)
                print("jsonDecoded")
                let favoritesArray = favoritesDictionary["favorites"]
                favoritesArray?.forEach({ favorite in
                    var newFavorite = Favorite()
                    newFavorite.type = favorite.type ?? ""
                    newFavorite.address = favorite.address ?? ""
                    newFavorite.lat = favorite.lat ?? 0.0
                    newFavorite.long = favorite.long ?? 0.0
                    favorites.append(newFavorite)
                })
                DispatchQueue.main.async {
                    completion(.success(favorites))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func getProposalsData(completion: @escaping (Result<[Proposal], Error>) -> Void) {
          var proposals : [Proposal] = []
          let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
          let endpoint = "https://api.myjson.com/bins/1bjt0o"
          let safeURLString = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
          
          guard let endpointURL = URL(string: safeURLString!) else {
              print("The URL is invalid")
              return
          }
          
          var request = URLRequest(url: endpointURL)
          request.httpMethod = "GET"
          
          let dataTask = session.dataTask(with: request) { (data, response, error) in
              guard let dataResponse = data else {
                  print("The payload is invalid")
                  return
              }
           
              do {
                let jsonData = try JSONSerialization.jsonObject(with: dataResponse, options: .mutableContainers) as? [String : Any]
                  print("jsonDecoded")
                guard let dataProposals = jsonData?["proposals"] as? [[String : Any]] else { return }
                dataProposals.forEach { proposal in
                    guard let range = proposal["range"] as? String else { return }
                    guard let price = proposal["price"] as? Double else { return }
                    guard let waitingTime = proposal["waitingTime"] as? Int else { return }
                    let newProposal = Proposal(range: range, price: price, waitingTime: waitingTime)
                    proposals.append(newProposal)
                }
                  DispatchQueue.main.async {
                    completion(.success(proposals))
                  }
              } catch let error {
                  completion(.failure(error))
              }
          }
          dataTask.resume()
      }
}
