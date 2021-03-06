//
//  MovieTableViewCell.swift
//  RottenTomatoes
//
//  Created by Amit Bharadwaj on 9/13/14.
//  Copyright (c) 2014 Amit Bharadwaj. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var sysnopsisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        var bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.redColor()
        self.selectedBackgroundView = bgColorView
    }

}
