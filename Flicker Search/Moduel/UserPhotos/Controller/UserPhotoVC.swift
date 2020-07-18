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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let progressIndicator = JGProgressHUD(style: .dark)
    var selectedUserId : String?
    
    lazy var mViewModel : UserPhotoViewModel = {
        return UserPhotoViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       initVM()
       initView()
        
        
    }
    
    private func initVM() {
        
        mViewModel.observState?.bind({ [weak self] (state) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                
                switch state {
                    
                case .loading:
                    self.progressIndicator.show(in: self.view)
                    print("loading in userid: \(String(describing: self.selectedUserId))")
                    
                case .reloadData:
                    self.tableView.reloadData()
                    
                default:
                    self.progressIndicator.dismiss()
                }
            }
        })
        
        
        
        mViewModel.loadPhotos(for: selectedUserId ?? "")
    }
    
    private func initView() {
        self.navigationItem.title = "More photos for this user"
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "\(UserPhotoCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(UserPhotoCell.self)")
    }
    
    
    func loadUserPhoto(for id : String, index: Int) {
        
        progressIndicator.show(in: self.view)
        
        /*SearchService.instance.getPhotos(for: id,pageIndex: index) { (success) in
            
            self.progressIndicator.dismiss()
            
            if success {
                self.tableView.reloadData()
            }
        }*/
    }

}




