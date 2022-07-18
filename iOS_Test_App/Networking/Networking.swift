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
              if let postList = self.decodeFiles(with: data) {
                  self.delegate?.showPosts(with: postList.posts)
                } else {
                  print("Networking error")
                }
            }
        }.resume()
    }
    
    func decodeFiles(with data: Data) -> PostsList? {
        do {
            return try decoder.decode(PostsList.self, from: data)
        } catch {
            print("Response data structure was changed")
            return nil
        }
    }
    
}
