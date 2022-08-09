//
//  PhotoCollection.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 07.08.2022.
//

import Foundation
import UIKit

struct PhotoData: Codable {
    
    let results: [UnsplashPhoto]
    
}

struct UnsplashPhoto: Codable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue:String]
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

struct Sizes: Codable {
    
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
