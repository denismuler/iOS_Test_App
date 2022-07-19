//
//  Networking.swift
//  iOS_TestApp
//
//  Created by Georgie Muler on 17.07.2022.
//

import Foundation

protocol NetworkingDelegate {
    func showPosts(with posts: [Posts])
}

class Networking {
    
    static let shared = Networking()
    
    private var decoder = JSONDecoder()
    
    var delegate: NetworkingDelegate?
        
    func fetchPostsList() {
        guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
              if let postList = self.decodePosts(with: data) {
                  self.delegate?.showPosts(with: postList.posts)
                } else {
                  print("Networking error")
                }
            }
        }.resume()
    }
    
    func decodePosts(with data: Data) -> PostsList? {
        do {
            return try decoder.decode(PostsList.self, from: data)
        } catch {
            print("Response data structure was changed")
            return nil
        }
    }
    
     func getPost(id: Int, completion: @escaping (Result<DetailPost, Error>) -> Void) {
      guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(id).json") else { return }
      
      let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error  in
        guard let self = self else { return }
        if let error = error {
          completion(.failure(error))
        } else if let safeData = data {
          do {
            let result = try self.decoder.decode(DetailPostList.self, from: safeData)
            completion(.success(result.post))
          }
          catch {
            completion(.failure(error))
          }
        }
      }
      task.resume()
    }
}
