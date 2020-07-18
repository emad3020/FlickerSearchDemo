//
//  FlickerRepoProtocol.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/11/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation

typealias searchCompletionHandler = (_ apiresponse : PhotoModel?, _ error : APIError?) -> Void

protocol FlickerRepoProtocol {
    
    func startSearch(with name : String, pageIndex : Int, completion : @escaping searchCompletionHandler)
    
    func getOwnerPhotos(ownerId : String, pageIndex: Int , completion : @escaping searchCompletionHandler)
}
