//
//  ViewController.swift
//  Create WordBook
//
//  Created by 中重歩夢 on 2018/09/11.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import UIKit
import RealmSwift
import LTMorphingLabel

class ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var morphingLabel: LTMorphingLabel!
    
    private var timer: Timer?
    private var index: Int = 0
    private let textList = ["MyDictionary","Let's", "Create!"]
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordTextField.delegate = self
        detailTextField.delegate = self
        successLabel.isHidden = true
        imageView.image = UIImage(named: "default.jpg")
        morphingLabel.morphingEffect = .scale
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
        timer?.fire()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super .viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    @objc func update(timer: Timer) {
        morphingLabel.text = textList[index]
        
        index += 1
        if index >= textList.count {
            index = 0
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        newWordIDAndSave()
        success()
       
        
        
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
        let value = imageView.image
        let data = UIImagePNGRepresentation(value!)
        addNewWord.imageData = data!
    
        
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
    
    func success() {
        successLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.successLabel.isHidden = true
        }
    }
    
    @IBAction func sendImageButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerView = UIImagePickerController()
            pickerView.sourceType = .photoLibrary
            pickerView.delegate = self
            self.present(pickerView, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = image
        self.dismiss(animated: true, completion:  nil)
    }
    
    
   
    
    
}

