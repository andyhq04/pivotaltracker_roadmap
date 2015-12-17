//
//  ReleaseFetchedResultsController.swift
//  pivotaltracker_roadmap
//
//  Created by Andrea Herbas on 12/11/15.
//  Copyright (c) 2015 iTatay. All rights reserved.
//

import Foundation

public protocol FetchedResultsControllerDataSourceDelegate: NSObjectProtocol {
    func configureCell(cell: UITableViewCell, object: AnyObject) -> Void
}

public class FetchedResultsControllerDataSource: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    private var tableView: UITableView
    public var fetchedResultsController: NSFetchedResultsController
    public var delegate: FetchedResultsControllerDataSourceDelegate?
    
    public init(tableView: UITableView) {
        self.tableView = tableView
        self.fetchedResultsController = NSFetchedResultsController()
        
        super.init()
        
        self.tableView.dataSource = self
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fetchedObjects = fetchedResultsController.fetchedObjects {
            return fetchedObjects.count
        }
        
        return 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("roadmapCellId", forIndexPath: indexPath) as! UITableViewCell
        var data = fetchedResultsController.objectAtIndexPath(indexPath) as! Release
        
        self.delegate!.configureCell(cell, object: data)
        return cell
    }
    
    public func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    public func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    public func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            if newIndexPath!.section == 0 {
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        case NSFetchedResultsChangeType.Delete:
            var newIndexPath = NSIndexPath(forRow: indexPath!.row, inSection: 0)
            
            tableView.deleteRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        case NSFetchedResultsChangeType.Update:
            var newIndexPath = NSIndexPath(forRow: indexPath!.row, inSection: 0)
            
            tableView.reloadRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        case NSFetchedResultsChangeType.Move:
            
            var fromIndexPath = NSIndexPath(forRow: indexPath!.row, inSection: 0)
            var toIndexPath = NSIndexPath(forRow: newIndexPath!.row, inSection: 0)
            
            tableView.moveRowAtIndexPath(fromIndexPath, toIndexPath: toIndexPath)
        default:
            return
        }
    }
    
    public func setupReleaseFetchedResultsController() {
        self.fetchedResultsController.delegate = self
        var query = String(format: "project_id == 1438492")
        var fetchRequest = NSFetchRequest(entityName: NSStringFromClass(Release.self))

        fetchRequest.fetchBatchSize = 15
        
        var sortDescriptor = NSSortDescriptor(key: "order", ascending:true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var predicate = NSPredicate(format: query)
        fetchRequest.predicate = predicate
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)

        var error: NSError? = nil
        if !fetchedResultsController.performFetch(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            NSLog("Unresolved error \(error)")
            abort()
        }
    }

}