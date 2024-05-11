//
//  ContentView.swift
//  NetworkingJSON
//
//  Created by Evgeniy Kostin on 11.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var githubUserModel: GitHubUserModel?
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: githubUserModel?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120)
            
            Text(githubUserModel?.login ?? "Login placeholder")
                .bold()
                .font(.title3)
            
            Divider()
            
            Text(githubUserModel?.bio ?? "Bio placeholder")
                .padding()
            
            Spacer()
        }
        .padding()
        .task {
            do {
                githubUserModel = try await getUser()
            } catch GitHubError.invalidURL {
                print("invalid URL")
            } catch GitHubError.invalidResponse {
                print("invalid response")
            } catch GitHubError.invaliData {
                print("invalid data")
            } catch {
                print("unexpected error")
            }
        }
    }
}

#Preview {
    ContentView()
}
