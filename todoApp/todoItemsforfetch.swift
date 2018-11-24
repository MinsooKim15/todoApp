//
//  todoItemsforfetch.swift
//  todoApp
//
//  Created by minsoo kim on 24/11/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit
import CoreData

class todoItemsforfetch: NSManagedObject {
    @NSManaged var itemTitle : String?
    @NSManaged var madeTime : Date?
    @NSManaged var notRemoved : Bool
    @NSManaged var workNotDone : Bool
}
