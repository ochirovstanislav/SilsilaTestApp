//
//  ListViewModel.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import RxSwift
import RxCocoa

final class ListViewModel {

    let cellModels = BehaviorRelay<[ListItemCellModel]>(value: [])
    let errorString = BehaviorRelay<String?>(value: nil)

    private let listRepository: ListRepositoryProtocol
    private let coordinator: ListCoordinator
    private var cellModelsDisposeBag: DisposeBag!
    private let disposeBag = DisposeBag()
    private var listItems = BehaviorRelay<[ListItemModel]>(value: [])

    init(listRepository: ListRepositoryProtocol, coordinator: ListCoordinator) {
        self.listRepository = listRepository
        self.coordinator = coordinator

        bind()
        updateData()
    }
}

// MARK: - Private
extension ListViewModel {

    private func bind() {
        listItems
            .do { [weak self] in self?.cellModelsDisposeBag = DisposeBag() }
            .map { $0.map { [unowned self] in self.obtainCellModel(from: $0) } }
            .bind(to: cellModels)
            .disposed(by: disposeBag)
    }

    private func updateData() {
        listItems.accept(listRepository.obtainAllListItems())
    }

    // Создание модели ячейки для ListItemModel
    private func obtainCellModel(from item: ListItemModel) -> ListItemCellModel {
        let cellModel = ListItemCellModel(id: item.id,
                                          title: item.title,
                                          isChecked: item.isChecked)

        /*
         Debounce 1 секунда необходим для того, чтобы не шла запись на каждое измение.
         Запись в базу произйодет только после того как не трогать checkBox 1 секунду.
        */
        cellModel
            .isCheckedChanged
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (isChecked) in
                self?.listRepository.updateIsCheckedInListItem(item, isChecked: isChecked)
        }).disposed(by: disposeBag)

        return cellModel
    }

    func onAddTap() {
        let updateAction = PublishRelay<String>()
        let transition = Transition.listItemMenu(initialTitle: "",
                                                 onUpdateAction: updateAction)

        updateAction.subscribe(onNext: { [weak self] (newTitle) in
            guard let self = self else { return }

            if !self.listRepository.addListItem(ListItemModel(title: newTitle)) {
                self.errorString.accept("Ошибка при создании объекта")
            } else {
                self.updateData()
            }
        }).disposed(by: disposeBag)

        coordinator.performTransition(transition: transition)
    }

    func onEditTap(at index: Int) {
        guard index < listItems.value.count else { return }

        let listItem = listItems.value[index]
        let updateAction = PublishRelay<String>()
        let transition = Transition.listItemMenu(initialTitle: listItem.title,
                                                 onUpdateAction: updateAction)

        updateAction.subscribe(onNext: { [weak self] (newTitle) in
            guard let self = self else { return }

            if !self.listRepository.updateTitleInListItem(listItem, newTitle: newTitle) {
                self.errorString.accept("Ошибка при редактировании объекта")
            } else {
                self.updateData()
            }
        }).disposed(by: disposeBag)


        coordinator.performTransition(transition: transition)
    }

    func onDelete(at index: Int) {
        guard index < listItems.value.count else { return }

        let listItem = listItems.value[index]

        if !self.listRepository.deleteListItem(listItem) {
            self.errorString.accept("Ошибка при удалении объекта")
        } else {
            self.updateData()
        }
    }

}
