//
//  UserPhotoCell.swift
//  Flicker Search
//
//  Created by Emad Asker on 7/11/20.
//  Copyright © 2020 Askerlap. All rights reserved.
//

import UIKit

class UserPhotoCell: UITableViewCell {
    @IBOutlet weak var photoTitleLabel : UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public var userCellViewModel : UserPhotoCellViewModel? {
        didSet {
            self.photoTitleLabel.text = userCellViewModel?.titleText
            self.userImageView.kf.setImage(with: userCellViewModel?.imageUrl)
        }
    }
    
}
