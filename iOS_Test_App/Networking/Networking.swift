//
//  Networking.swift
//  iOS_TestApp
//
//  Created by Georgie Muler on 17.07.2022.
//

import Foundation

protocol NetworkingDelegate {
    func showPosts(with postsList: PostsList)
}

class Networking {
    
    static let shared = Networking()
    
    private var decoder = JSONDecoder()
    
    var delegate: NetworkingDelegate?
    
    //    private init() {}
    
    func fetchPostsList() {
        guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let files = self.decodeFiles(with: data) {
                    self.delegate?.showPosts(with: files)
                } else {
                    // Error
                }
            }
        }.resume()
    }
    
    func decodeFiles(with data: Data) -> PostsList? {
        do {
            let posts = try decoder.decode(PostsList.self, from: data)
            print(posts)
            return posts
        } catch {
            return nil
        }
    }
    
    //    func fetchPostsList(onCompletion: @escaping([Posts]) -> ()) {
    //        let urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
    //        let url = URL(string: urlString)!
    //
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //
    //            guard let data = data else {
    //                print("error data is nil")
    //                return
    //            }
    //
    //            guard let postsList = try? JSONDecoder().decode(PostsList.self, from: data) else {
    //                print("couldn't decode JSON")
    //                return
    //            }
    //
    //            print(postsList.posts)
    //        }
    //        task.resume()
    //
    //    }
}
