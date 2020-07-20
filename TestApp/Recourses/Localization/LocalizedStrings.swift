//
//  LocalizedStrings.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation

struct LocalizedStrings {
    static let done = NSLocalizedString("Done", comment: "Confirm changes")
    static let revert = NSLocalizedString("Revert", comment: "Discard changes")
    static let list = NSLocalizedString("List", comment: "First screen")
    static let service = NSLocalizedString("Service", comment: "Second screen")
    static let itemName = NSLocalizedString("Item name", comment: "List item menu placeholder")
    static let yes = NSLocalizedString("Yes", comment: "Question's answer")
    static let no = NSLocalizedString("No", comment: "Question's answer")
    static let listItemMenuAlertQuestion = NSLocalizedString("Save changes?", comment: "Confirm question on list item menu screen")
    static let listItemMenuAlertDescription = NSLocalizedString("Item was changed, you can save it", comment: "Confirm description on list item menu screen")
    static let delete = NSLocalizedString("Delete", comment: "Delete object")
    static let edit = NSLocalizedString("Edit", comment: "Edit object")

}
