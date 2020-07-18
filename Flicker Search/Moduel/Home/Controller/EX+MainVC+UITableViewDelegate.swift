//
//  EX+MainVC+UITableViewDelegate.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/11/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import Foundation
import UIKit

extension MainVC : UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let photo = SearchService.instance.searchPhotosArr[indexPath.row]
        mViewModel.userPressedCell(at: indexPath)
        performSegue(withIdentifier: USER_SEGUES, sender: mViewModel.selectedPhoto?.owner)
        }
}
