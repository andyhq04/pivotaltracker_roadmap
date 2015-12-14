//
//  RoadmapController.swift
//  
//
//  Created by Andrea Herbas on 12/10/15.
//
//

import UIKit

public class RoadmapController: UITableViewController, FetchedResultsControllerDataSourceDelegate {

    private var projectId: String = "1234"
    private var fetchedResultsControllerDataSource: FetchedResultsControllerDataSource?

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsControllerDataSource = FetchedResultsControllerDataSource(tableView: self.tableView)
        fetchedResultsControllerDataSource!.delegate = self
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        ServiceConnector.sharedInstance.getReleaseService().getAll(projectId, success: nil)
        fetchedResultsControllerDataSource!.setupReleaseFetchedResultsController()
    }
    
    public func configureCell(cell: UITableViewCell, object: AnyObject) {
        cell.textLabel!.text = "Title release"
    }
}
