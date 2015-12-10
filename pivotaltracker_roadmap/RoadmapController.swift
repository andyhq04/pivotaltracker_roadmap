//
//  RoadmapController.swift
//  
//
//  Created by Andrea Herbas on 12/10/15.
//
//

import UIKit

public class RoadmapController: UITableViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    public override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var roadmapCell = tableView.dequeueReusableCellWithIdentifier("roadmapCellId", forIndexPath: indexPath) as! UITableViewCell
        
        roadmapCell.textLabel!.text = "Title release"
        
        return roadmapCell
    }
}
