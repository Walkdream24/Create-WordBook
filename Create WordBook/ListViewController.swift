//
//  ListViewController.swift
//  Create WordBook
//
//  Created by 中重歩夢 on 2018/09/12.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    
    var myWordList: [myWordObject] = []
    var searchController = UISearchController()
    
    @IBOutlet weak var listTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        listTableView.tableHeaderView = searchController.searchBar
        
        
    }
    func updateSearchResult(for SearchController: UISearchController) {
        let predicate = NSPredicate(format: "wordName CONTAINS %@", searchController.searchBar.text!)
        let realm = try! Realm()
        let wordObj = realm.objects(myWordObject.self).filter(predicate)
        myWordList = []
        wordObj.forEach { (word) in
            myWordList.append(word)
        }
        listTableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let realm = try! Realm()
        let wordObj = realm.objects(myWordObject.self)
        myWordList = []
        wordObj.forEach { (word) in
            myWordList.append(word)
        }
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = myWordList[indexPath.row].wordName
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWordList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            
            let realm = try! Realm()
            try! realm.write {
                realm.delete(self.myWordList[indexPath.row])
            }
            listTableView.reloadData()
        }

           
    }
    
    
    @IBAction func createButton(_ sender: Any) {
        performSegue(withIdentifier: "create", sender: self)
    }


   
}
