//
//  DisplaySearchCellView.swift
//  Github
//
//  Created by Anas Belkhadir on 13/02/2016.
//  Copyright © 2016 Anas Belkhadir. All rights reserved.
//

import UIKit

class DisplaySearchCellView: UITableViewCell {
    

    @IBOutlet weak var name: UILabel!


    
    @IBOutlet weak var forks: UILabel!
    
    @IBOutlet weak var stars: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
