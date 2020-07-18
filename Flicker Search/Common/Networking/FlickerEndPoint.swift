//
//  FlicerEndPoint.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/11/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum Environment {
    case development
}

enum FlickerEndPoint {
    case searchQuery(method: String,apiKey : String, searchText: String, pageNumber : Int)
    
    case getUserPhotos(userId: String,apiKey : String, pageNumbder: Int)
}


extension FlickerEndPoint : TargetType {
 
    
    private var environmentUrl : String {
        switch NetworkManager.environment {
        case .development:
            return "https://api.flickr.com/"
        }
    }
    
     public var baseURL: URL {
          guard let url = URL(string: environmentUrl) else {
              fatalError("BaseURL can't be configured")
          }
          
          return url
      }
    
    public var path : String {
        switch self {
        case .searchQuery, .getUserPhotos:
            return "services/rest"
        }
        
        
    }
    
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .searchQuery, .getUserPhotos:
            return .get
        }
    }
    
    
    public var task : Task {
        switch self {
        case .searchQuery(let method, let key, let text , let page):
            let parameter: [String : Any] = ["method": method,
                                             "api_key":key,
                                             "text": text,
                                             "page": page,
                                             "format":"json",
                                             "nojsoncallback":1]
            
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
        case .getUserPhotos(let userId,let key, let pageNumbder):
            let parameter : [String : Any] = ["method":"flickr.people.getPhotos",
                                              "api_key":key,
                                              "user_id": userId,
                                              "page":pageNumbder,
                                              "format":"json",
                                              "nojsoncallback":1 ]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
           switch self {
           case .searchQuery, .getUserPhotos:
                   return URLEncoding.default
           }
       }
    
    public var headers: [String : String]? {
        switch self {
        case .searchQuery, .getUserPhotos:
            return nil
        }
    }
    
    public var sampleData: Data {
        switch self {
        default:
            return Data()
            
        }
    }
}

