//
//  PhotoCollection.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 07.08.2022.
//

import Foundation
import UIKit

struct PhotoData: Codable {
    
    var results: [UnsplashPhoto]
    
}

struct UnsplashPhoto: Codable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue:String]
    let id: String
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}

typealias RandomPhotoData = [UnsplashPhoto]
