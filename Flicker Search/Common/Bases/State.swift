//
//  State.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/10/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation
public enum State  {
    case empty
    case loading
    case success
    case reloadData
    case faliure(String?)
}
