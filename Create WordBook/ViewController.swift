//
//  ViewController.swift
//  Create WordBook
//
//  Created by 中重歩夢 on 2018/09/11.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordTextField.delegate = self
        detailTextField.delegate = self
        
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        newWordIDAndSave()
        performSegue(withIdentifier: "see", sender: self)
        
        
    }
    
    func newWordIDAndSave() {
        let realm = try! Realm()
        let lastWord = realm.objects(myWordObject.self).sorted(byKeyPath: "id", ascending: false)
        var addId: Int = 1
        
        if lastWord.count > 0 {
            addId = lastWord[0].id + 1
            
        }
        
        let addNewWord = myWordObject()
        addNewWord.id = addId
        addNewWord.wordDetail = detailTextField.text!
        addNewWord.wordName = wordTextField.text!
        
        if addNewWord.wordName == "" {
            dismiss(animated: true, completion: nil)
            
        }
        try! realm.write {
            realm.add(addNewWord, update: true)
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let addNewWord = myWordObject()
        addNewWord.wordName = wordTextField.text!
        addNewWord.wordDetail = detailTextField.text!
        
        wordTextField.resignFirstResponder()
        detailTextField.resignFirstResponder()
        return true
    }
    
   
    
    
}

