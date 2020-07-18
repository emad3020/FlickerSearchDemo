//
//  ViewController.swift
//  Flicker Search
//
//  Created by Emad on 12/15/18.
//  Copyright © 2018 Askerlap. All rights reserved.
//

import UIKit
import JGProgressHUD

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    var initialPage = 1
    
    lazy var progressIndicator = {
        return JGProgressHUD(style: .dark)
    }()
    
     lazy var mViewModel : HomeViewModel =  {
            return HomeViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initVM()
    }
    
    
    private func initVM() {
      
        
        mViewModel.observState?.bind { [weak self] (state) in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch state {
                case .loading:
                    self.progressIndicator.show(in: self.view)
                    
                case .reloadData:
                    self.tableView.reloadData()
                    
                case .faliure(let errorMessage):
                    self.progressIndicator.dismiss()
                    print("error found is: \(String(describing: errorMessage))")
                default:
                    self.progressIndicator.dismiss()
                }
            }
            
        }
    }
    
    
    private func initView() {
        let nib = UINib(nibName: "\(SearchPhotoCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(SearchPhotoCell.self)")
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
    }
     
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == USER_SEGUES {
            if let destination = segue.destination as? UserPhotoVC {
                destination.selectedUserId = sender as? String
            }
        }
    }
    
    
    
    func loadSearchResult( keyword text : String, index : Int) {
     
           // progressIndicator.show(in: self.view)
            
            /* SearchService.instance.startSearch(with: text,pageIndex: index) { (success) in
                
                self.progressIndicator.dismiss()
                
                if success {
                    self.tableView.reloadData()
                }
            }*/
       
        
       
    }
    
    
    
    func clearResult(){
        initialPage = 1
        //SearchService.instance.searchPhotosArr.removeAll()
        self.tableView.reloadData()
        self.view.endEditing(true)
    }

  

}






