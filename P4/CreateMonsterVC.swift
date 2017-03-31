//
//  CreateMonsterVC.swift
//  P4
//
//  Created by champ on 30/03/17.
//  Copyright © 2017 champ. All rights reserved.
//

import UIKit
import CoreData

class CreateMonsterVC: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var ageLbl: UITextField!
    @IBOutlet weak var speciesLbl: UITextField!
    @IBOutlet weak var powerLbl: UITextField!
    @IBOutlet weak var healthLbl: UITextField!
    @IBOutlet weak var feedbackLbl: UILabel!
    
    var controller: NSFetchedResultsController<Monster>!
    var monsters = [Monster]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptFetch()
        // Do any additional setup after loading the view.
    }

    @IBAction func updateBtnPressed(_ sender: UIButton) {
        let name = nameLbl.text
        for monster in monsters {
            if (name == monster.name){
                
                    if let age = ageLbl.text{
                        monster.age = (age as NSString).intValue
                    }
                    if let species = speciesLbl.text{
                        monster.species = species
                    }
                    if let power = powerLbl.text{
                        monster.power = (power as NSString).intValue
                    }
                    if let health = healthLbl.text{
                        monster.health = (health as NSString).intValue
                    }
                    ad.saveContext()
                    feedbackLbl.text = "Changed"
            
                    break
                    }
                
                
            else {
                feedbackLbl.text = "No such monster exists"
            }
            
        
        }
        
        
        
    }
    @IBAction func saveBtnPressed(_ sender: UIButton) {
       // add validations hereqq only allow user to enter numbers in age
        if nameLbl.text != ""  && ageLbl.text != "" && speciesLbl.text != "" && powerLbl.text != "" && healthLbl.text != "" {

        let monster = Monster(context:context)
        
        if let name = nameLbl.text{
            monster.name = name
        }
        if let age = ageLbl.text{
            monster.age = (age as NSString).intValue
        }
        if let species = speciesLbl.text{
            monster.species = species
        }
        if let power = powerLbl.text{
            monster.power = (power as NSString).intValue
        }
        if let health = healthLbl.text{
            monster.health = (health as NSString).intValue
        }
        ad.saveContext()
        feedbackLbl.text = "New monster has been created"
        }
        else{
            feedbackLbl.text = "Not all fields were filled in!"
        }
        
    }
    //fetches items from core data adds all core data  to the array monsters
    func attemptFetch(){
        
            let monstersFetch : NSFetchRequest<Monster> = Monster.fetchRequest()
            do{
                let FetchedMonsters = try context.fetch(monstersFetch as! NSFetchRequest<NSFetchRequestResult>) as! [Monster]
                self.monsters = FetchedMonsters
            }
            catch{
                
                    let error = error as NSError
                    print("\(error)")
                }
    
    }

    
    
    
}
