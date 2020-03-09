//
//  ShowDetailTableViewCell.swift
//  TVGuide
//
//  Created by Laura Daniela Krayacich on 06/03/2020.
//  Copyright © 2020 Laura Daniela Krayacich. All rights reserved.
//

import UIKit

class ShowDetailTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "showDetailTableViewCell"
    
    @IBOutlet weak var episodeTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setup(episode: EpisodePresentable) {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        episodeTitle.text = episode.name
    }
    
}
