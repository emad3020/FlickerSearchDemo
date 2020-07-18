//
//  Observable.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/10/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation

public class Observable<ObserverType> {
    
    public typealias Observer = (ObserverType) -> Void
    
    private var observers : [Observer]
    
     public var value : ObserverType {
        didSet{
            notifyObserverChanges(value)
        }
    }
    
    public init(_ value : ObserverType) {
         self.value = value
         print("observer inint value :\(value)")
         observers = []
         print("observer inint values :\(observers)")
    }
    
    public func bind(_ observer: @escaping Observer) {
      self.observers.append(observer)
      notifyObserverChanges(value)
    }
    
    
     private func notifyObserverChanges( _ value : ObserverType) {
       
        
        for observer in observers {
            observer(value)
        }
        
    }
}
