//
//  FacebookManager.swift
//  SocialDemo
//
//  Created by Parikshit Hedau on 29/07/18.
//  Copyright © 2018 parikshit.hedau. All rights reserved.
//

import UIKit

class FacebookManager: NSObject {
    
    func checkAuthentication(completionBlock:((Bool)->())?) {
        
        if FBSDKAccessToken.currentAccessTokenIsActive() {
            
            print(FBSDKAccessToken.current().expirationDate)
            
            completionBlock?(true)
        }
        else{
            
            let appDel = UIApplication.shared.delegate as! AppDelegate
            
            let loginManager = FBSDKLoginManager()
            
            loginManager.logIn(withReadPermissions: ["user_photos"], from: appDel.window?.rootViewController!) { (result, error) in
                
                if error !=  nil {
                    
                    completionBlock?(false)
                }
                else
                {
                    completionBlock?(true)
                }
            }
        }
    }
    
    func getPhotos(completionBlock:(([[String:Any]]?)->())?) {
        
        checkAuthentication { (success) in
            
            if success {
                
                self.getPhotosFromServer(completionBlock: { (arr) in
                    
                    completionBlock?(arr)
                })
            }
        }
    }
    
    func getPhotosFromServer(completionBlock:(([[String:Any]]?)->())?) {
    
        let params = ["fields": "photo_count,name,id,picture, photos.fields(name,id,picture,source,created_time)"]
        
        let request = FBSDKGraphRequest(graphPath: "me/albums", parameters: params)
        
        let connection = FBSDKGraphRequestConnection()

        connection.add(request, completionHandler: { (connection, result, error) in
            
            if error == nil {
               
                let dict = result as! [String:Any]
                
                if let arr = dict["data"] as? [[String:Any]] {
                
                    var arrayPhotos = [[String:Any]]()
                    
                    for dict in arr {
                        
                        if let dictData = dict["photos"] as? [String:Any] {
                            
                            if let arrData = dictData["data"] as? [[String:Any]] {

                                arrayPhotos.append(contentsOf: arrData)
                            }
                        }
                    }
                    
                    completionBlock?(arrayPhotos)
                }
                else
                {
                    completionBlock?(nil)
                }
            }            
        })
        
        connection.start()
    }
    
    func getFBAlbumPhoto(albumID: String) {
        
        let params = [ "height": 100, "width": 100, "redirect": true, "fields": "photo_count,name,id,picture,source, date, created_time"] as [String : Any]
        let graphRequest = FBSDKGraphRequest(graphPath: "\(albumID)/photos", parameters: params, httpMethod: "GET")
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            if error == nil {
                //print(result)
                let dict = result as! [String:Any]
                
                let arr = dict["data"] as! [[String:Any]]
                
                for dict in arr {
                    
                    let id = dict["id"] as! String
                    
                    self.getPhotoInfo(photId: id)
                }
                
                print("result are **************\(dict)")
            }
        })
        connection.start()
    }
    
    func getPhotoInfo(photId: String) {
        
        let params = ["fields": "place,name,id,picture,source, created_time"] as [String : Any]
        let graphRequest = FBSDKGraphRequest(graphPath: "\(photId)?fields= place,name,id,picture,source, created_time", parameters: params, httpMethod: "GET")
        let connection = FBSDKGraphRequestConnection()
        connection.add(graphRequest, completionHandler: { (connection, result, error) in
            if error == nil {
                //print(result)
                let dict = result as! [String:Any]
                print("result are **************\(dict)")
            }
        })
        connection.start()
    }
}
