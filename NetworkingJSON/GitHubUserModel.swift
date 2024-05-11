//
//  GitHubUser.swift
//  NetworkingJSON
//
//  Created by Evgeniy Kostin on 11.05.2024.
//

import Foundation

struct GitHubUserModel: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}
