//
//  RandomPhotoData.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 10.08.2022.
//

import Foundation

struct RandomPhotoDataElement: Codable {
    
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

//typealias RandomPhotoData = [RandomPhotoDataElement]
