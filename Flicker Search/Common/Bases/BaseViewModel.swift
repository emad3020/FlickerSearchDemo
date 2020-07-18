//
//  BaseViewModel.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/18/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation
class BaseViewModel<T: Codable>: ViewModelProtocol  {
    
    
    typealias cellViewModel = SearchCellViewModel

    var observState: Observable<State?>?
    var apiProtocol: FlickerRepoProtocol?
    var observer : Observable<T>?
    
    
    init(_ apiManager : FlickerRepoProtocol = FlickerRepo()){
        self.apiProtocol = apiManager
        self.observState = Observable<State?>(.empty)
    }
    
    final class func fetchData(data: T){}
    
   func userPressedCell(at indexPath: IndexPath) {
       
   }
    
    func fuckYou() -> String {
        fatalError("must override")
        return "hello"
    }
    
    
    
}
