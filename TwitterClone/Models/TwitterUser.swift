//
//  TwitterUser.swift
//  TwitterClone
//
//  Created by Jim Yang on 2023-11-15.
//

import Foundation
import Firebase

struct TwitterUser:Codable{
    let id: String
    var displayName: String = ""
    var username: String = ""
    var followersCount: Int = 0
    var followingCount: Int = 0
    var createdOn: Date = Date()
    var bio: String = ""
    var avatarPath: String = ""
    var isUserOnboarded: Bool = false
    
    init(from user: User) {
        self.id = user.uid
    }
    
}
