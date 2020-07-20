//
//  XMLParserManager.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import RxSwift
import RxCocoa

final class XMLParserManager: NSObject {

    private var allItems = [ServiceListItemModel]()
    private var currentItem: ServiceListItemModel?
    private var currentKeyPath: WritableKeyPath<ServiceListItemModel, String?>?
    private let result = PublishSubject<Void>()
    private var completeCallback: (() -> Void)?
    private let disposeBag = DisposeBag()

    func parse(from data: Data) -> Single<[ServiceListItemModel]> {
        return Single<[ServiceListItemModel]>.create { [unowned self] single in
            let parser = XMLParser(data: data)
            
            self.completeCallback = {
                return single(.success(self.allItems))
            }

            parser.delegate = self
            parser.parse()

            return Disposables.create {
                parser.abortParsing()
            }
        }
    }
}

extension XMLParserManager: XMLParserDelegate {

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {


        switch elementName.lowercased() {
        case "cd":
            currentItem = ServiceListItemModel()
        case "title":
            currentKeyPath = \.title
        case "artist":
            currentKeyPath = \.artist
        case "country":
            currentKeyPath = \.country
        case "company":
            currentKeyPath = \.company
        case "price":
            currentKeyPath = \.price
        case "year":
            currentKeyPath = \.year
        default:
            currentKeyPath = nil
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard
            !trimmedString.isEmpty,
            currentKeyPath != nil,
            currentItem != nil
            else { return }

        currentItem![keyPath: currentKeyPath!] = trimmedString
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName.lowercased() == "cd" {
            if currentItem != nil {
                allItems.append(currentItem!)
            }
            currentItem = nil
        }

        currentKeyPath = nil
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        completeCallback?()
        allItems.removeAll()
    }
}
