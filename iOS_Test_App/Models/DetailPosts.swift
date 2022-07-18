//
//  DetailPosts.swift
//  iOS_Test_App
//
//  Created by Georgie Muler on 18.07.2022.
//

import Foundation

struct DetailPostsList: Decodable {
    let posts: [DetailPosts]
}

struct DetailPosts: Decodable {
    var postId: Int
    var timeshamp: Int
    var title: String?
    var preview_text: String?
    var likes_count: Int
}
