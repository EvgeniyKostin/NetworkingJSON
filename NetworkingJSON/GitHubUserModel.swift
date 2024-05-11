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
//class GitHubUserModel: Codable {
//    var login: String = ""
//    var avatarUrl: String = ""
//    var bio: String = ""
//
//    init(login: String, avatarUrl: String, bio: String) {
//        self.login = login
//        self.avatarUrl = avatarUrl
//        self.bio = bio
//    }
//}

func getUser() async throws -> GitHubUserModel {
    let endPoint = "https://api.github.com/users/EvgeniyKostin"
    guard let url = URL(string: endPoint) else {
        throw GitHubError.invalidURL }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response  as? HTTPURLResponse, response.statusCode == 200 else {
        throw GitHubError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GitHubUserModel.self, from: data)
    } catch {
        throw GitHubError.invaliData
    }
}

enum GitHubError: Error {
    case invalidURL
    case invalidResponse
    case invaliData
}
