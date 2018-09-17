//
//  DetailViewController.swift
//  Create WordBook
//
//  Created by 中重歩夢 on 2018/09/14.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var getWord: String!
    var getDetail: String!
  
  

    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTextView.text = getDetail
        wordLabel.text = getWord

        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)

//    }


    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//    @IBAction func backButton(_ sender: Any) {
//
//        let backView = storyboard!.instantiateViewController(withIdentifier: "backView")
//        self.present(backView,animated: true, completion: nil)
    
     
//    }

  

}
