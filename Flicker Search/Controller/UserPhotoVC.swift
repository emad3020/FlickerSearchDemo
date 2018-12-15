//
//  UserPhotoVC.swift
//  Flicker Search
//
//  Created by Emad on 12/15/18.
//  Copyright © 2018 Askerlap. All rights reserved.
//

import UIKit
import JGProgressHUD

class UserPhotoVC: UIViewController {
    
    var selectedUserId : String!
    var initialPage = 1
    
    @IBOutlet weak var tableView: UITableView!
    
    let progressIndicator = JGProgressHUD(style: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationItem.title = "More photos for this user"
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SearchService.instance.userPhotosArr.removeAll()
        
        loadUserPhoto(for: selectedUserId,index: initialPage)
    }
    
    
    func loadUserPhoto(for id : String, index: Int) {
        
        progressIndicator.show(in: self.view)
        
        SearchService.instance.getPhotos(for: id,pageIndex: index) { (success) in
            
            self.progressIndicator.dismiss()
            
            if success {
                self.tableView.reloadData()
            }
        }
    }

}



extension UserPhotoVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchService.instance.userPhotosArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SEARCH_CELL, for: indexPath) as? SearchCell else {
            return UITableViewCell()
        }
        
       
        
        let photo = SearchService.instance.userPhotosArr[indexPath.row]
        cell.configureCell(for: photo)
        
        if indexPath.row == SearchService.instance.userPhotosArr.count - 1 {
            print("----- user pagenation index \(initialPage) ----- ")
            initialPage += 1
            loadUserPhoto(for: selectedUserId, index: initialPage)
        }
        
        return cell
    }
}
