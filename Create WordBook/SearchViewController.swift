//
//  SearchViewController.swift
//  Create WordBook
//
//  Created by 中重歩夢 on 2018/09/14.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//
protocol ModalViewControllerDelegate {
    
    func modalDidFinished(SearchResultReturn: NSArray)
}
import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate {
    
    var delegate: ModalViewControllerDelegate! = nil
    var items: NSArray = []
    private var searchResult: NSArray = []
    
    @IBOutlet var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

    }
    
    func searchItems(searchText: String) {
        if searchText != "" {
            searchResult = items.filter { item in
                return(item as! String).contains(searchText)
            }as NSArray
        }else{
            searchResult = items
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.view.endEditing(true)
        searchResult = items
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func searchButtonTapped(_sender: Any) {
        searchItems(searchText: searchBar.text! as String)
        self.delegate.modalDidFinished(SearchResultReturn: searchResult)
        dismiss(animated: true, completion: nil)
    }
    

  

}
