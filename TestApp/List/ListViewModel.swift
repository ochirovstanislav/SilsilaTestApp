//
//  ListViewModel.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import Foundation

final class ListViewModel {

    private let listRepository: ListRepositoryProtocol

    init(listRepository: ListRepositoryProtocol) {
        self.listRepository = listRepository
    }


}
