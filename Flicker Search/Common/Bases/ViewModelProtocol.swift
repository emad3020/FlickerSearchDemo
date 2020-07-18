//
//  BaseViewModel.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/8/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation



protocol ViewModelProtocol {
    
    
    associatedtype cellViewModel
    
    var observState : Observable<State?>? { get set }
    
    var apiProtocol : FlickerRepoProtocol? { set get}
   
    func getCellViewModel(at indexPath : IndexPath) -> cellViewModel?
    func userPressedCell(at indexPath : IndexPath)
}

extension ViewModelProtocol {
    func getCellViewModel(at indexPath : IndexPath) -> cellViewModel? { return nil }
    
}

