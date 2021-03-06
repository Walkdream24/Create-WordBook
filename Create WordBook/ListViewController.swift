//
//  ListViewController.swift
//  Create WordBook
//
//  Created by 中重歩夢 on 2018/09/12.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating {
   
    
    
    var myWordList: [myWordObject] = []
    var selectWord: String!
    
    var searchController = UISearchController()
   
    
    @IBOutlet weak var listTableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        searchSet()
        
 
    }
    func searchSet() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
    }
    func updateSearchResults(for SearchController: UISearchController) {
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
            let realm = try! Realm()
            try! realm.write {
                realm.delete(myWordList[indexPath.row])
            }

                myWordList.remove(at: indexPath.row)
                listTableView.deleteRows(at: [indexPath], with: .fade)
     
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        selectWord = myWordList[indexPath.row].wordName
        performSegue(withIdentifier: "toDetailController", sender: myWordList[indexPath.row].wordDetail)
        
     
        
        listTableView.deselectRow(at: indexPath, animated: true)
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetailController") {
            let detailVC : DetailViewController = (segue.destination as? DetailViewController)!
            detailVC.getDetail = sender as! String
            detailVC.getWord = selectWord
           
          
            
        }
    }

    

   
    
//   @IBAction func createButton(_ sender: Any) {
//        performSegue(withIdentifier: "create", sender: self)
//    }
//
   

   
}
