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
    
    let progressIndicator = JGProgressHUD(style: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //loadSearchResult(keyword: "chooclate")
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
     
            progressIndicator.show(in: self.view)
            
            SearchService.instance.startSearch(with: text,pageIndex: index) { (success) in
                
                self.progressIndicator.dismiss()
                
                if success {
                    self.tableView.reloadData()
                }
            }
       
        
       
    }
    
    
    
    func clearResult(){
        initialPage = 1
        SearchService.instance.searchPhotosArr.removeAll()
        self.tableView.reloadData()
        self.view.endEditing(true)
    }

  

}



extension MainVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchService.instance.searchPhotosArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SEARCH_CELL, for: indexPath) as? SearchCell else {
            return UITableViewCell() }
        let photo = SearchService.instance.searchPhotosArr[indexPath.row]
        cell.configureCell(for: photo)
        
        if indexPath.row == SearchService.instance.searchPhotosArr.count - 1 {
            print("-------- pagenation in \(initialPage) ------")
            initialPage += 1
            loadSearchResult(keyword: searchBar.text!, index: initialPage)
        }
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = SearchService.instance.searchPhotosArr[indexPath.row]
        
        performSegue(withIdentifier: USER_SEGUES, sender: photo.owner)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}


extension MainVC : UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      
        if searchBar.text != nil || searchBar.text != "" {
             loadSearchResult(keyword: searchBar.text!, index: initialPage)
        }
        
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        clearResult()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            clearResult()
        }
    }
    
    
}
