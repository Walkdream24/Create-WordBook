//
//  ListTableViewController.swift
//  Create WordBook
//
//  Created by 中重歩夢 on 2018/09/11.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class ListTableViewController: UITableViewController {
    
    
    var myWordList: [myWordObject] = []
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        listTableView.tableHeaderView = searchController.searchBar
        
    }
    
    func updateSearchResult(for searchController: UISearchController) {
        
        let predicate = NSPredicate(format: "wordName CONTAINS %@", searchController.searchBar.text!)
        let realm = try! Realm()
        let myWordObj = realm.objects(myWordObject.self).filter(predicate)
        myWordList = []
        myWordObj.forEach { (word) in
            myWordList.append(word)
        }
        listTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let realm = try! Realm()
        let myWordObj = realm.objects(myWordObject.self)
        myWordList = []
        myWordObj.forEach { (word) in
            myWordList.append(word)
        }
        listTableView.reloadData()
        
        
    }

   

   // override func numberOfSections(in tableView: UITableView) -> Int {
       
        //return 1
   // }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myWordList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = myWordList[indexPath.row].wordName
        return cell
    }
 

    
    
    @IBAction func createPageButton(_ sender: Any) {
        performSegue(withIdentifier: "create", sender: self)
    }
    


}
