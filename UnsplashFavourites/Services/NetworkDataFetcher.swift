//
//  NetworkDataFetcher.swift
//  UnsplashFavourites
//
//  Created by Артур Фомин on 07.08.2022.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService  = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping (PhotoData?)->()) {
        
        networkService.request(searchTerm: searchTerm) { data, error in
            if let error = error {
                print("Error recieved requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: PhotoData.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        
        do{
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError{
            print("Failed to decode error", jsonError)
            return nil
        }
    }
    
}
