//
//  Coordinator.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import Swinject

protocol Coordinator: AnyObject {
    
    func performTransition(transition: Transition)
}
