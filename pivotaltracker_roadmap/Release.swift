//
//  Release.swift
//  
//
//  Created by Andrea Herbas on 12/10/15.
//
//

import CoreData
import Foundation

@objc(Release)
public class Release: NSManagedObject {

    @NSManaged public var created_at: NSDate
    @NSManaged public var accepted_at: NSDate?
    @NSManaged public var deadline: NSDate?
    @NSManaged public var desc: String
    @NSManaged public var id: NSNumber
    @NSManaged public var name: String
    @NSManaged public var order: NSNumber
    @NSManaged public var requested_by_id: NSNumber
    @NSManaged public var updated_at: NSDate
    @NSManaged public var project_id: NSNumber
    @NSManaged public var state: ReleaseState
    
    /*public init(name: String) {
        self.name = name
        
        created_at = NSDate()
        self.updated_at = NSDate()
        self.desc = ""
        self.id = 0
        self.order = 0
        self.requested_by_id = 0
        self.state = ReleaseState.Unstarted
    }*/
}
