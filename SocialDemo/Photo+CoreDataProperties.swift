//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Parikshit Hedau on 01/08/18.
//
//

import Foundation
import CoreData

extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var created_date: String?
    @NSManaged public var name: String?
    @NSManaged public var photoId: String?
    @NSManaged public var picture: String?
    @NSManaged public var source: String?
    @NSManaged public var type: String?

}
