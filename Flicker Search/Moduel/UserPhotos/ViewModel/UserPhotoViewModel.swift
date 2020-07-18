//
//  UserPhotoViewModel.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/11/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation
import Kingfisher

class UserPhotoViewModel: ViewModelProtocol{
    typealias T = Photos?
    typealias cellViewModel = UserPhotoCellViewModel
    
    
    var observState: Observable<State?>?
    var observer: Observable<Photos?>?
    var apiProtocol: FlickerRepoProtocol?
    
    private var userCellViewModels = [UserPhotoCellViewModel]() {
        didSet{
            self.observState?.value = .reloadData
        }
    }
    
    public var numberOfCells : Int {
        return userCellViewModels.count 
    }
    
    init(_ networkAPI : FlickerRepoProtocol = FlickerRepo() ) {
        self.apiProtocol = networkAPI
        self.observState = Observable<State?>(.empty)
        self.observer = Observable<Photos?>(nil)
    }
   
    func loadPhotos(for user : String){
        observState?.value = .loading
        
        apiProtocol?.getOwnerPhotos(ownerId: user, pageIndex: 0, completion: { [weak self] (photoModel, error) in
            
            guard let self = self else { return }
            guard error == nil , let photos = photoModel else {
                self.observState?.value = .faliure(error?.rawValue)
                return
            }
            self.fetchData(photoArr: photos.photos.photo)
            
            self.observState?.value = .success 
            
        })
    }
    
    private func fetchData(photoArr : [Photo]) {
        var userCellVM = [UserPhotoCellViewModel]()
        
        for photoItem in photoArr {
            userCellVM.append(createUserCellViewModel(item: photoItem))
        }
        
        self.userCellViewModels = userCellVM
    }
    
    private func createUserCellViewModel( item : Photo ) -> UserPhotoCellViewModel {
        let photoUrl = "https://farm\(item.farm).staticflickr.com/\(item.server)/\(item.id)_\(item.secret).jpg"
        let imageSource = ImageResource(downloadURL: URL(string: photoUrl)!)
        
        return UserPhotoCellViewModel(isFamily: item.isfamily, isPublic: item.ispublic, isFriend: item.isfriend, titleText: item.title, imageUrl: imageSource)
    }
    
    
    func getCellViewModel(at indexPath: IndexPath) -> UserPhotoCellViewModel {
        return userCellViewModels[ indexPath.row]
       }
       
       func userPressedCell(at indexPath: IndexPath) {
           
       }
     
    
}
