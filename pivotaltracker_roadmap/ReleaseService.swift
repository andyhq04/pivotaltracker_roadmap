//
//  ReleaseService.swift
//  pivotaltracker_roadmap
//
//  Created by Andrea Herbas on 12/10/15.
//  Copyright (c) 2015 iTatay. All rights reserved.
//

import Foundation

public class ReleaseService {

    private var managedObjectStore: RKManagedObjectStore
    
    public init(managedObjectStore: RKManagedObjectStore) {
        self.managedObjectStore = managedObjectStore
        
        setupMapping()
        configureRoutes()
    }
    
    public func setupMapping() {
        var releaseMapping = RKEntityMapping(forEntityForName: "Release", inManagedObjectStore: managedObjectStore)
        releaseMapping.addAttributeMappingsFromDictionary([
            "id": "id",
            "name": "name",
            "description": "desc",
            "current_state": "state",
            "deadline": "deadline",
            "story_type": "type",
            "accepted_at": "accepted_at",
            "created_at": "created_at",
            "updated_at": "updated_at",
            "project_id": "project_id"
            
        ]);
        releaseMapping.identificationAttributes = ["id"]
        //releaseMapping.addConnectionForRelationship("project", connectedBy: ["project_id": "id"])
        
        var dynamicMapping = RKDynamicMapping()
        
        dynamicMapping.addMatcher(RKObjectMappingMatcher(keyPath: "story_type", expectedValue: "release", objectMapping: releaseMapping))
        
        var responseDescriptor = RKResponseDescriptor(mapping: dynamicMapping, method: RKRequestMethod.Any, pathPattern: "projects/:project_id/stories", keyPath: nil, statusCodes: RKStatusCodeIndexSetForClass(RKStatusCodeClass.Successful))

        var releaseRequestMapping = RKEntityMapping(forEntityForName: "Release", inManagedObjectStore:managedObjectStore)
        releaseRequestMapping.addAttributeMappingsFromDictionary([
            "id": "id",
            "name": "name",
            "description": "desc",
            "story_type": "type",
            "deadline": "deadline",
            "current_state": "state"
        ]);
        releaseRequestMapping.identificationAttributes = ["id"]
        
        var dynamicInverseMapping = RKDynamicMapping()
        dynamicInverseMapping.addMatcher(RKObjectMappingMatcher(keyPath: "type", expectedValue: "release", objectMapping: releaseRequestMapping.inverseMapping()))
        
        var releaseRequestDescriptor = RKRequestDescriptor(mapping: dynamicInverseMapping, objectClass: Release.self, rootKeyPath: nil, method: RKRequestMethod.Any)
        
        RKObjectManager.sharedManager().addResponseDescriptor(responseDescriptor)
        RKObjectManager.sharedManager().addRequestDescriptor(releaseRequestDescriptor)
        
        //self.managedObjectStore.managedObjectCache = RKInMemoryManagedObjectCache(managedObjectContext: managedObjectStore.mainQueueManagedObjectContext)//[[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectSyore.persistentStoreManagedObjectContext];
    }
    
    public func configureRoutes() {
        RKObjectManager.sharedManager().router.routeSet.addRoute(RKRoute(name: "stories_index", pathPattern: "projects/:project_id/stories", method: RKRequestMethod.GET))
    }
    
    public func getAll(projectId: String, success: ((operation: RKObjectRequestOperation!, mappingResult: RKMappingResult!) -> Void)!) -> Void {
        var projectIdObject:[String:String] = ["project_id": projectId]
        var params: [String: String] = ["filter": "type:release includedone:true"]
        
        RKObjectManager.sharedManager().getObjectsAtPathForRouteNamed("stories_index", object: projectIdObject, parameters: params, success: success, failure: nil)
    }
}