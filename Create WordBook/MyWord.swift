//
//  MyWord.swift
//  Create WordBook
//
//  Created by 中重歩夢 on 2018/09/11.
//  Copyright © 2018年 Ayumu Nakashige. All rights reserved.
//

import Foundation
import RealmSwift

class myWordObject: Object {
    @objc dynamic var wordName: String = ""
    @objc dynamic var wordDetail: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic private var _image: UIImage? = nil
    @objc dynamic var image: UIImage? {
        set {
            self._image = newValue
            if let value = newValue {
                self.imageData = UIImagePNGRepresentation(value)
            }
            
        }
        get {
            if let image = self._image {
                return image
            }
            if let data = self.imageData {
                self._image = UIImage(data: data)
                return self._image
            }
            return nil
        }
    }
    @objc dynamic var imageData: Data? = nil
    
 
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return["image", "_image"]
    }
}
