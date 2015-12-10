//
//  Release.swift
//  
//
//  Created by Andrea Herbas on 12/10/15.
//
//

import CoreData
import Foundation

public class Release {

    public var created_at: NSDate
    public var accepted_at: NSDate?
    public var deadline: NSDate?
    public var desc: String
    public var id: NSNumber
    public var name: String
    public var order: NSNumber
    public var requested_by_id: NSNumber
    public var updated_at: NSDate
    public var state: ReleaseState
    
    public init(name: String) {
        self.name = name
        
        self.created_at = NSDate()
        self.updated_at = NSDate()
        self.desc = ""
        self.id = 0
        self.order = 0
        self.requested_by_id = 0
        self.state = ReleaseState.Unstarted
    }
}
