//
//  Transition.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// Типы переходов, которые передаются в Coordinator
enum Transition {
    case listItemMenu(initialTitle: String, onUpdateAction: PublishRelay<String>?)
}
