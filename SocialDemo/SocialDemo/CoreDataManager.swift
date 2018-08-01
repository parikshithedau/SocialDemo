//
//  CoreDataManager.swift
//  SocialDemo
//
//  Created by Parikshit Hedau on 30/07/18.
//  Copyright © 2018 parikshit.hedau. All rights reserved.
//

import UIKit

class CoreDataManager: NSObject {
    
    func savePhoto(dict:[String:Any], type:String) {
        
        if type == "fb" {
            
            saveFacebookPhoto(dict: dict)
        }
    }
    
    func saveFacebookPhoto(dict:[String:Any]) {
        
        let id = dict["id"] as! String
        let name = dict["name"] as! String
        let created_time = dict["created_time"] as! String
        let picture = dict["picture"] as! String
        let source = dict["source"] as! String
    }
}
