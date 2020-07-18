//
//  FlickerRepo.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/11/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation

enum APIError : String, Error {
    case noInternet = "Please check internet connection"
    case notFound = "No data found or page removed"
}

class FlickerRepo: FlickerRepoProtocol {
    
    static let instance = FlickerRepo()
    
    lazy var networkManager : NetworkManager = {
        return NetworkManager()
    }()
    
    func startSearch(with name: String, pageIndex: Int, completion: @escaping (searchCompletionHandler)) { 
        
        let target : FlickerEndPoint =
            .searchQuery(method: "flickr.Photos.search", apiKey: "2edf37b890ea8a24298bb787f3414247", searchText: name, pageNumber: 0)
        networkManager.makeApiCall(target, completion: completion)
    }
    
    
    func getOwnerPhotos(ownerId: String, pageIndex: Int, completion: @escaping searchCompletionHandler) {
        let target : FlickerEndPoint = .getUserPhotos(userId: ownerId, apiKey: "2edf37b890ea8a24298bb787f3414247", pageNumbder: pageIndex)
        
        networkManager.makeApiCall(target, completion: completion)
    }
}
