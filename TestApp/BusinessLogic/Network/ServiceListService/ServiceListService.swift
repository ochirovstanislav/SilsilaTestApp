//
//  WebService.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import RxSwift
import RxCocoa

final class ServiceListService: ServiceListServiceProtocol {

    /*
     Получаем данные с бэка. Загрузка происходит в background потоке
     */

    func getServiceList() -> Single<Data> {
        let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        let url = URL(string: "https://www.w3schools.com/xml/cd_catalog.xml")!

        return Single<Data>.create { single in
            let defaultSession = URLSession(configuration: .default)

            let dataTask = defaultSession.dataTask(with: url) { data, response, error in
                if let error = error {
                    single(.error(error))
                } else if let data = data {
                    single(.success(data))
                }
            }

            dataTask.resume()

            return Disposables.create {
                dataTask.cancel()
            }
        }.observeOn(concurrentScheduler)
    }
}
