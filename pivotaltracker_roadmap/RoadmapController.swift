//
//  RoadmapController.swift
//  
//
//  Created by Andrea Herbas on 12/10/15.
//
//

import UIKit

public class RoadmapController: UITableViewController, FetchedResultsControllerDataSourceDelegate {

    private var projectId: String = "1438492"
    private var fetchedResultsControllerDataSource: FetchedResultsControllerDataSource?

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsControllerDataSource = FetchedResultsControllerDataSource(tableView: self.tableView)
        fetchedResultsControllerDataSource!.delegate = self
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        ServiceConnector.sharedInstance.getReleaseService().getAll(projectId, success: { (operation, mappingResult) -> Void in
            self.fetchedResultsControllerDataSource!.setupReleaseFetchedResultsController()
            self.tableView.reloadData()
        })
    }
    
    public func configureCell(cell: UITableViewCell, object: AnyObject) {
        var release = object as! Release
        
        cell.textLabel!.text = release.name
    }
}
