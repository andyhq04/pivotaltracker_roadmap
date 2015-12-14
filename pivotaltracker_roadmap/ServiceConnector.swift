//
//  ServiceConnector.swift
//  pivotaltracker_roadmap
//
//  Created by Andrea Herbas on 12/10/15.
//  Copyright (c) 2015 iTatay. All rights reserved.
//

import Foundation
import UIKit

public class ServiceConnector {
    
    public var releaseService: ReleaseService?
    public var managedObjectStore: RKManagedObjectStore?
    
    class var sharedInstance: ServiceConnector {
        struct Static {
            static var instance: ServiceConnector?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ServiceConnector()
        }
        
        return Static.instance!
    }
    
    public init() {
        self.setupObjectManager()
        
        self.releaseService = ReleaseService(managedObjectStore: managedObjectStore!)
    }
    
    public func setupObjectManager() {

        let managedObjectModel = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectModel

        managedObjectStore = RKManagedObjectStore(managedObjectModel: managedObjectModel)
        managedObjectStore!.createPersistentStoreCoordinator()

        var options = [NSMigratePersistentStoresAutomaticallyOption: NSNumber(bool: true), NSInferMappingModelAutomaticallyOption: NSNumber(bool: true)]
        var storePath = RKApplicationDataDirectory().stringByAppendingPathComponent("pivotaltracker_roadmap.sqlite")

        var error: NSError?
        var persistentStore = managedObjectStore!.addSQLitePersistentStoreAtPath(storePath, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: options, error: &error)

        if persistentStore == nil {
            NSLog("Error %@", storePath)
            NSLog("Error %@", error!)
        }
        managedObjectStore!.createManagedObjectContexts()
        managedObjectStore!.mainQueueManagedObjectContext.undoManager = NSUndoManager()

        var baseUrl = "https://www.pivotaltracker.com/services/v5/"
        var objectManager: RKObjectManager = RKObjectManager(baseURL: (NSURL(string: baseUrl)))

        objectManager.managedObjectStore = managedObjectStore
        objectManager.operationQueue!.maxConcurrentOperationCount = 1

        RKObjectManager.setSharedManager(objectManager)
    }
    
    public func getReleaseService() -> ReleaseService {
        return self.releaseService!
    }
}