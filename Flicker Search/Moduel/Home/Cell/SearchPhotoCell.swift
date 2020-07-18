//
//  SearchPhotoCell.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/11/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import UIKit
import Kingfisher

class SearchPhotoCell: UITableViewCell {

  @IBOutlet weak var titleLbl: UILabel!
  @IBOutlet weak var ownerLbl: UILabel!
  @IBOutlet weak var searchImg : UIImageView!
    
    var searchCellViewModel : SearchCellViewModel? {
        didSet{
            ownerLbl.text = searchCellViewModel?.ownerText
            titleLbl.text = searchCellViewModel?.titleText
            searchImg.kf.setImage(with: searchCellViewModel?.imageUrl, placeholder: nil, options: [.transition(.fade(1))], completionHandler: nil)
        }
    }
    
}
