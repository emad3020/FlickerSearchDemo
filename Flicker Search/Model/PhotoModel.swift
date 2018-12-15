//
//  PhotoModel.swift
//  Flicker Search
//
//  Created by Emad on 12/15/18.
//  Copyright © 2018 Askerlap. All rights reserved.
//

import Foundation

struct PhotoModel {
    
    public private(set) var id : String
    public private(set) var owner : String
    public private(set) var secret : String
    public private(set) var server : String
    public private(set) var title : String 
    public private(set) var farm : Int
    public private(set) var isPublic : Int
    public private(set) var isFriend: Int
    public private(set) var isFamily: Int 
}
