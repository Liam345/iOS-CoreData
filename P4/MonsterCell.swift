//
//  MonsterCell.swift
//  P4
//
//  Created by champ on 30/03/17.
//  Copyright © 2017 champ. All rights reserved.
//

import UIKit

class MonsterCell: UITableViewCell {

    @IBOutlet weak var monsterNameLbl: UILabel!
    @IBOutlet weak var monsterSpeciesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
// Uncomment this method to perform the same function as upDateUI below
//    override func setSelected(_ selected: true, animated: true) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    func updateUI(monster:Monster){
        monsterNameLbl.text = monster.name
        monsterSpeciesLbl.text = monster.species
    }
}
