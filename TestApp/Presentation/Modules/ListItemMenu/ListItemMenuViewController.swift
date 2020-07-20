//
//  ListItemMenuViewController.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ListItemMenuViewController: UIViewController {

    private struct Constants {
        static let horizontalBorderSpacing: CGFloat = 16.0
        static let verticalBorderSpacing: CGFloat = 16.0
        static let itemSpacing: CGFloat = 8.0
        static let elementsHeight: CGFloat = 40.0

        static let actionsButtonsCornerRadius: CGFloat = 4.0
        static let actionButtonsColor: UIColor = UIColor(red: 56/255.0, green: 116/255.0, blue: 224/255.0, alpha: 1.0)
    }

    private lazy var titleTextField: UITextField = {
        let outputTextField = UITextField()

        outputTextField.translatesAutoresizingMaskIntoConstraints = false
        outputTextField.borderStyle = .roundedRect
        outputTextField.placeholder = LocalizedStrings.itemName
        return outputTextField
    }()

    private lazy var confirmButton: UIButton = {
        let outputButton = UIButton()

        outputButton.translatesAutoresizingMaskIntoConstraints = false
        outputButton.setTitle(LocalizedStrings.done, for: .normal)
        outputButton.setTitleColor(.darkGray, for: .disabled)
        outputButton.backgroundColor = Constants.actionButtonsColor
        outputButton.layer.cornerRadius = Constants.actionsButtonsCornerRadius
        outputButton.layer.masksToBounds = true
        return outputButton
    }()

    private lazy var discardButton: UIButton = {
        let outputButton = UIButton()

        outputButton.translatesAutoresizingMaskIntoConstraints = false
        outputButton.setTitle(LocalizedStrings.revert, for: .normal)
        outputButton.backgroundColor = Constants.actionButtonsColor
        outputButton.layer.cornerRadius = Constants.actionsButtonsCornerRadius
        outputButton.layer.masksToBounds = true
        return outputButton
    }()

    private let disposeBag = DisposeBag()
    private let onUpdateAction: PublishRelay<String>?
    private let initialTitle: String
    private let dismissKeyboardRecognizer = UITapGestureRecognizer()

    init(initialTitle: String, onUpdateAction: PublishRelay<String>?) {
        self.onUpdateAction = onUpdateAction
        self.initialTitle = initialTitle

        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("ListItemMenuViewController init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

// MARK: - Private

extension ListItemMenuViewController {

    private func setup() {
        view.backgroundColor = .white
        titleTextField.text = initialTitle
        view.addGestureRecognizer(dismissKeyboardRecognizer)

        setupLayout()
        bindUI()
    }

    private func bindUI() {
        confirmButton.rx
            .tap
            .subscribe(onNext: { [weak self] (_) in
                self?.onConfirmTap() })
            .disposed(by: disposeBag)

        discardButton.rx
            .tap
            .subscribe(onNext: { [weak self] (_) in
                self?.onDiscardTap() })
            .disposed(by: disposeBag)

        dismissKeyboardRecognizer.rx
            .event
            .subscribe(onNext: { [weak self] (_) in
                self?.view.endEditing(true) })
            .disposed(by: disposeBag)

        // Пока поле не заполнено, кнопка сохранения заблокирована
        titleTextField.rx
            .text
            .map { !($0?.isEmpty ?? true) }
            .bind(to: confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    private func setupLayout() {
        view.addSubview(titleTextField)
        view.addSubview(confirmButton)
        view.addSubview(discardButton)

        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                    constant: Constants.horizontalBorderSpacing),
            titleTextField.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                                constant: Constants.verticalBorderSpacing),
            titleTextField.heightAnchor.constraint(equalToConstant: Constants.elementsHeight),
            safeArea.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor,
                                                    constant: Constants.horizontalBorderSpacing),

            discardButton.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            discardButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor,
                                               constant: Constants.itemSpacing),
            discardButton.heightAnchor.constraint(equalToConstant: Constants.elementsHeight),

            confirmButton.leadingAnchor.constraint(equalTo: discardButton.trailingAnchor,
                                                   constant: Constants.itemSpacing),
            confirmButton.topAnchor.constraint(equalTo: discardButton.topAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: Constants.elementsHeight),
            confirmButton.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            confirmButton.widthAnchor.constraint(equalTo: discardButton.widthAnchor)
        ])
    }

    private func onConfirmTap() {
        if let titleTextFieldText = titleTextField.text {
            onUpdateAction?.accept(titleTextFieldText)
        }

        dismiss(animated: true)
    }

    private func onDiscardTap() {
        // Если тайтл изменен и это не пустая строка, то предлагаем сохранить объект
        guard
            let titleTextFieldText = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !titleTextFieldText.isEmpty,
            titleTextFieldText != initialTitle
            else { dismiss(animated: true)
                return }

        showDiscardAlert().subscribe(onSuccess: { [weak self] (isSaveNeed) in
            if isSaveNeed {
                self?.onUpdateAction?.accept(titleTextFieldText)
            }

            self?.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }

    private func showDiscardAlert() -> Single<Bool> {
        return Single<Bool>.create { single in
            let alert = UIAlertController(title: LocalizedStrings.listItemMenuAlertQuestion,
                                          message: LocalizedStrings.listItemMenuAlertDescription,
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: LocalizedStrings.yes, style: .default) { _ in single(.success(true)) })
            alert.addAction(UIAlertAction(title: LocalizedStrings.no, style: .cancel) { _ in single(.success(false))})

            self.present(alert, animated: true)

            return Disposables.create { alert.dismiss(animated: true, completion: nil) }
        }
    }

}
