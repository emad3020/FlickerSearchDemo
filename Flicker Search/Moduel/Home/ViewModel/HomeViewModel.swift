//
//  HomeViewModel.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/8/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation
import Kingfisher

class HomeViewModel: ViewModelProtocol {
    
    var observState: Observable<State?>?
    
    typealias T = PhotoModel?
    typealias cellViewModel  = SearchCellViewModel
    
    var observer: Observable<PhotoModel?>?
    var apiProtocol: FlickerRepoProtocol?
    
    var photoArray = [Photo]()
    var selectedPhoto: Photo?
    
    private var cellViewModels  = [SearchCellViewModel]() {
        didSet{
            self.observState?.value = .reloadData
        }
    }
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    private var searchQuery : String?
    
    init(apiService : FlickerRepoProtocol = FlickerRepo()) {
        self.apiProtocol = apiService
        self.observer = Observable<PhotoModel?>(nil)
        self.observState = Observable<State?>(.empty)
    }
    
 
    
    func getCellViewModel(at indexPath: IndexPath) -> SearchCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    
    func search(by name : String, pageIndex : Int = 0) {
        observState?.value = .loading
        self.searchQuery = name
        
        apiProtocol?.startSearch(with: name, pageIndex: pageIndex, completion: { [weak self] (photos, error) in
            guard let self = self else { return }
            
            guard  error == nil,let photos = photos else {
                self.observState?.value = .faliure(error?.rawValue)
                return
            }
            self.fetchPhotoData(photos: photos.photos.photo)
            self.observState?.value = .success
            
        })
    }
    
    private func creareCellViewModel(item : Photo) -> SearchCellViewModel {
        let photoUrl = "https://farm\(item.farm).staticflickr.com/\(item.server)/\(item.id)_\(item.secret).jpg"
        let imageResource = ImageResource(downloadURL: URL(string: photoUrl)!)
        
        
        return SearchCellViewModel(titleText: item.title, ownerText: item.owner, imageUrl: imageResource)
    } 
    
    private func fetchPhotoData(photos : [Photo]) {
        self.photoArray = photos
        
        var cellVM = [SearchCellViewModel]()
        
        for photoItem in photos {
            cellVM.append(creareCellViewModel(item: photoItem))
        }
        
        self.cellViewModels.append(contentsOf: cellVM)
    }
    
    func userPressedCell(at indexPath: IndexPath) {
        self.selectedPhoto = self.photoArray[indexPath.row]
    }
    
    
    func loadMorePhotos(_ index: Int){
        search(by: searchQuery ?? "", pageIndex: index)
    }
    
}
