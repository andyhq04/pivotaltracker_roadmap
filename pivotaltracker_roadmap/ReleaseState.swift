//
//  ReleaseState.swift
//  pivotaltracker_roadmap
//
//  Created by Andrea Herbas on 12/10/15.
//  Copyright (c) 2015 iTatay. All rights reserved.
//

import Foundation

@objc public enum ReleaseState: Int {
    case Accepted, Started, Planned, Unstarted, Unscheduled
}