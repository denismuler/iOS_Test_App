//
//  DetailPosts.swift
//  iOS_Test_App
//
//  Created by Georgie Muler on 18.07.2022.
//

import Foundation

struct DetailPostList: Decodable {
    let post: DetailPost
}

struct DetailPost: Decodable {
    var postId: Int
    var timeshamp: Int
    var title: String?
    var text: String?
    var likes_count: Int
    var postImage: String?
}
