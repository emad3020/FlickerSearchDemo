//
//  Constant.swift
//  Flicker Search
//
//  Created by Emad on 12/15/18.
//  Copyright © 2018 Askerlap. All rights reserved.
//

import Foundation


typealias CompletionHandler = (_ success : Bool) -> ()

//MARK : URL Section

let BASE_URL = "https://api.flickr.com/services/rest/"
let QUERY_SEARCH = "flickr.Photos.search"
let QUERY_PHOTO = "flickr.people.getPhotos"
let APIKEY = "2edf37b890ea8a24298bb787f3414247"
let FORMAT = "json"


//MARK : Segues Section
let USER_SEGUES = "userSegues"


//MARK : Cell Section
let SEARCH_CELL = "searchCell"


//MARK : HEADER Section
let DEFAULT_HEADER = ["Content-Type" : "application/json;charset=utf-8"]

