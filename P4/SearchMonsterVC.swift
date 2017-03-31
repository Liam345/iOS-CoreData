//
//  SearchMonsterVC.swift
//  P4
//
//  Created by champ on 30/03/17.
//  Copyright © 2017 champ. All rights reserved.
//

import UIKit
import CoreData

class SearchMonsterVC: UIViewController, UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    @IBOutlet weak var monsterCountLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var controller: NSFetchedResultsController<Monster>!
    var monsters = [Monster]()
    var filteredMonsters = [Monster]()
    let searchController = UISearchController(searchResultsController:nil)//we will display the search results in the same view as table view therefore we will not be needing the searchResultsController
    
    func filterContentForSearchText(searchText:String, scope:String="All"){
        filteredMonsters = monsters.filter{
            monster in
            return monster.name!.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    // its a required function for UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchResultsUpdater = self //informs searchController when text changes within UI text bar
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar // add search bar to the top of table
        //Will generate Monsters only for the first time application starts
        let fetchResult :NSFetchRequest<Monster> = Monster.fetchRequest()
        do {
            let count = try context.count(for: fetchResult)
            if count==0{
                generateMonsters()
            }
        }catch{
            let error = error as NSError
            print("\(error)")
        }
       // if controller.data == nil {
        
        //}
        
        attemptFetch()
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonsterCell", for: indexPath) as! MonsterCell
        
            
        configureCell(cell:cell,indexPath:indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell:MonsterCell, indexPath:NSIndexPath){
        
       // let monster = controller.object(at: indexPath as IndexPath)
        if searchController.isActive && searchController.searchBar.text != ""{
            let monster = filteredMonsters[indexPath.row]
            cell.updateUI(monster: monster)
        }
        else {
               let monster = monsters[indexPath.row]
                cell.updateUI(monster: monster)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if let sections = controller?.sections{
            
          //      let sectionInfo = sections[section]
           //     return sectionInfo.numberOfObjects // commented out section was used before we stored a list of monsters in the array // herqq , it will slow performance if you store a list of monsters . Ask
       // }
       // return 0
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredMonsters.count
        }
        
        return monsters.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller?.sections{
            return sections.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //implement BoilerPlate of CoreData
    func attemptFetch(){
        let fetchRequest : NSFetchRequest<Monster> = Monster.fetchRequest()
        let nameSort = NSSortDescriptor(key: "name", ascending: false)
        fetchRequest.sortDescriptors = [nameSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller //notifies for changes in data to the views
        
        do{
            try controller.performFetch()
        }
        catch{
            let error = error as NSError
            print("\(error)")
        }
        //fetches items from core data adds all core data  to the array monsters
        do{
            let FetchedMonsters = try context.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [Monster]
            self.monsters = FetchedMonsters
        }
        catch{
            
            let error = error as NSError
            print("\(error)")
        }


    }
    
    
    func generateMonsters(){
        let monster = Monster(context:context)
        monster.name = "Squirtle"
        monster.age = 5
        monster.species = "water"
        monster.power = 70
        monster.health = 600
        
        let monster2 = Monster(context:context)
        monster2.name = "Bulbasaur"
        monster2.age = 12
        monster2.species = "plant"
        monster2.power = 80
        monster2.health = 500
        
        let monster3 = Monster(context:context)
        monster3.name = "Charmander"
        monster3.age = 9
        monster3.species = "fire"
        monster3.power = 100
        monster3.health = 400
        
        let monster4 = Monster(context:context)
        monster4.name = "Pikachu"
        monster4.age = 12
        monster4.species = "electric"
        monster4.power = 100
        monster4.health = 550
        
        let monster5 = Monster(context:context)
        monster5.name = "Meowth"
        monster5.age = 15
        monster5.species = "cat"
        monster5.power = 75
        monster5.health = 450
        
        ad.saveContext() //persists data to core
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let monsterElement = monsters[indexPath.row]
        performSegue(withIdentifier: "ViewMonsterVC", sender: monsterElement)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewMonsterVC"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let monsterDetail : Monster
                if searchController.isActive && searchController.searchBar.text != "" {
                    monsterDetail = filteredMonsters[indexPath.row]
                }
                else{
                    monsterDetail = monsters[indexPath.row]
                }
                if let destination = segue.destination as? ViewMonsterVC{
                    destination.monsterDetail = monsterDetail
                }
            }
        
    }
}
}
