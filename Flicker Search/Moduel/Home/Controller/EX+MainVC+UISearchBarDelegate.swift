//
//  EX+MainVC+UISearchBarDelegate.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/11/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation
import UIKit

extension MainVC : UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      
        if searchBar.text != nil || searchBar.text != "" {
            
            mViewModel.search(by: searchBar.text ?? "" )
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
