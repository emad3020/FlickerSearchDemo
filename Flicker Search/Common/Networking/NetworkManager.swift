//
//  NetworkManager.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/11/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation
import Moya
import Result

class NetworkManager {
    static let environment : Environment = .development
    
   fileprivate let provider = MoyaProvider<FlickerEndPoint>()
    
    func makeApiCall<T: Codable>(_ target : FlickerEndPoint,completion : @escaping ((_ response : T?, _ error : APIError?) -> Void) ) {
        
        provider.request(target) { [weak self] (result) in
            guard let _ = self else { return }
            
            switch result {
                
            case .success(let response):
                
                do {
                    
                    let responseData = try JSONDecoder().decode(T.self,from: response.data)
                    completion(responseData,nil)
                    
                } catch(let ex){
                    
                    print(#function , "exception is: \(String(describing: ex))")
                    
                    completion(nil, .notFound)
                }
                
            case .failure(let error):
                
                print(#function , "error is: \(String(describing: error.errorDescription))")
                
                completion(nil,.noInternet)
                
            }
        }
    }
}
