//
//  EX+MainVC+UITableViewDataSource.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/11/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation
import UIKit


extension MainVC : UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  mViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchPhotoCell.self)", for: indexPath) as? SearchPhotoCell else {
            return UITableViewCell() }
        
        let viewModelCell = mViewModel.getCellViewModel(at: indexPath)
        cell.searchCellViewModel = viewModelCell
        
        return cell
        
    }
}
