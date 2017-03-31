//
//  ViewMonsterVC.swift
//  P4
//
//  Created by champ on 31/03/17.
//  Copyright © 2017 champ. All rights reserved.
//

import UIKit

class ViewMonsterVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var speciesLbl: UILabel!
    @IBOutlet weak var powerLbl: UILabel!
    @IBOutlet weak var healthLbl: UILabel!
    private var _monsterDetail:Monster!
    
    var monsterDetail: Monster{
        get{
            return _monsterDetail
        }
        set{
            _monsterDetail = newValue
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = monsterDetail.name
        ageLbl.text = String(describing: monsterDetail.age)
        speciesLbl.text = monsterDetail.species
        powerLbl.text = String(describing: monsterDetail.power)
        healthLbl.text = String(describing: monsterDetail.health)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
