//
//  Posts.swift
//  iOS_TestApp
//
//  Created by Georgie Muler on 17.07.2022.
//

import Foundation

struct PostsList: Decodable {
    let posts: [Posts]
}

struct Posts: Decodable {
    var postId: Int
    var timeshamp: Int
    var title: String?
    var preview_text: String?
    var likes_count: Int
}


