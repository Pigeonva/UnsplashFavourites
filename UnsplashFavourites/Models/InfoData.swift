//
//  InfoData.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 10.08.2022.
//

import Foundation

struct InfoData: Codable {
    
    let createdAt: String
    let downloads: Int
    let user: User
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case downloads
        case user
        case location
    }
}

struct User: Codable {
    
    let name: String
}

struct Location: Codable {
    
    let name: String?
}
