//
//  SearchService.swift
//  Flicker Search
//
//  Created by Emad on 12/15/18.
//  Copyright © 2018 Askerlap. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchService {
    static let instance = SearchService()
    var searchPhotosArr = [PhotoModel]()
    var userPhotosArr = [PhotoModel]()
    
    
    func startSearch(with name : String, pageIndex : Int, completion : @escaping CompletionHandler){
        let url = "\(BASE_URL)?method=\(QUERY_SEARCH)&api_key=\(APIKEY)&text=\(name)&page=\(pageIndex)&format=\(FORMAT)&nojsoncallback=1"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        Alamofire.request(encodedUrl, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: DEFAULT_HEADER).responseJSON { (response) in
            
            if response.error == nil {
                guard let data = response.data else {completion(false);return}
                
                let responseJson = try! JSON(data: data)
                let photos = responseJson["photos"]
                
                if let photoArray = photos["photo"].array {
                    
                    for item in photoArray {
                        self.searchPhotosArr.append(self.parsePhotos(item: item))
                    }
                    
                    completion(true)
                    
                } else {
                    completion(false)
                }
                
                
            } else {
                debugPrint( response.error as Any)
                completion(false)
            }
        }
    }
    
    
    
    
    func getPhotos(for userId : String , pageIndex : Int, completion : @escaping CompletionHandler) {
       
         let url = "\(BASE_URL)?method=\(QUERY_PHOTO)&api_key=\(APIKEY)&user_id=\(userId)&page=\(pageIndex)&format=\(FORMAT)&nojsoncallback=1"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
         
        Alamofire.request(encodedUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            
            if response.error == nil {
                guard let data = response.data else {completion(false);return}
                
                let responseJson = try! JSON(data: data)
                let photos = responseJson["photos"]
                
                if let photoArray = photos["photo"].array {
                    for item in photoArray {
                        self.userPhotosArr.append(self.parsePhotos(item: item))
                    }
                    completion(true)
                    
                } else {
                    completion(false)
                }
                
            } else {
                debugPrint( response.error as Any)
                completion(false)
            }
        }
        
    }
    
    
    func parsePhotos( item : JSON) -> PhotoModel {
        var photo : PhotoModel!
      
            let id = item["id"].stringValue
            let owner = item["owner"].stringValue
            let secret = item["secret"].stringValue
            let server = item["server"].stringValue
            let title = item["title"].stringValue
            let farm = item["farm"].intValue
            let isPublic = item["ispublic"].intValue
            let isFriend = item["isfriend"].intValue
            let isFamily = item["isfamily"].intValue
            
            photo = PhotoModel.init(id: id, owner: owner, secret: secret, server: server, title: title, farm: farm, isPublic: isPublic, isFriend: isFriend, isFamily: isFamily)
        return photo
    }
    
}
