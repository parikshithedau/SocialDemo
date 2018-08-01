//
//  DatabaseManager.swift
//  SocialDemo
//
//  Created by Parikshit Hedau on 30/07/18.
//  Copyright © 2018 parikshit.hedau. All rights reserved.
//

import UIKit

class DatabaseManager: NSObject {

    func savePhotos(arrayPhotos:[[String:Any]], type:String, completionBlock:((Bool)->())?) {
        
        for dict in arrayPhotos {
            
            let coreManager = CoreDataManager()
            
            coreManager.savePhoto(dict: dict, type: type)
        }
    }
}
