//
//  PhotoModel.swift
//  Flicker Search
//
//  Created by Emad on 12/15/18.
//  Copyright © 2018 Askerlap. All rights reserved.
//

import Foundation

// MARK: - PhotoModel
struct PhotoModel: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
