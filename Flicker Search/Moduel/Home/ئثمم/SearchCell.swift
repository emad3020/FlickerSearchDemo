//
//  SearchCell.swift
//  Flicker Search
//
//  Created by Emad on 12/15/18.
//  Copyright © 2018 Askerlap. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var searchImg : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.selectionStyle = .none
        }
        
    }

    
    
    func configureCell(for photo : PhotoModel) {
        self.titleLbl.text = photo.title
       
        self.searchImg.kf.indicatorType = .activity
        
        let url = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"

        let resource = ImageResource(downloadURL: URL(string: url)!)
        
        self.searchImg.kf.setImage(with: resource, placeholder: nil, options: [.transition(.fade(1))], completionHandler: nil)
        
    }
}
