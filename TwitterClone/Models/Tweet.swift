//
//  Tweet.swift
//  TwitterClone
//
//  Created by Jim Yang on 2023-11-24.
//

import Foundation

struct Tweet: Codable, Identifiable{
    let id = UUID().uuidString
    let author: TwitterUser
    let authorID: String
    let tweetContent: String
    var likesCount: Int
    var likers: [String]
    let isReply: Bool
    let parentReference: String?
}
