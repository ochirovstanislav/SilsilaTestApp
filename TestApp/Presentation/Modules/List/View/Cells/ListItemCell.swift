//
//  ListItemCell.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ListItemCell: UITableViewCell {

    private struct Constants {
        static let checkedImage: UIImage = UIImage(named: "SmileIcon")!
        static let uncheckedImage: UIImage = UIImage(named: "SadIcon")!
        static let checkboxViewSideLength: CGFloat = 24.0
        static let imageViewSideLength: CGFloat = 80.0
        static let horizontalBorderSpacing: CGFloat = 16.0
        static let verticalBorderSpacing: CGFloat = 8.0
        static let itemSpacing: CGFloat = 8.0
    }

    private lazy var iconImageView: UIImageView = {
        let outputImageView = UIImageView()

        outputImageView.translatesAutoresizingMaskIntoConstraints = false
        outputImageView.contentMode = .scaleAspectFit
        return outputImageView
    }()

    private lazy var titleLabel: UILabel = {
        let outputLabel = UILabel()

        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        outputLabel.numberOfLines = 0
        return outputLabel
    }()

    private lazy var checkBoxView: CheckboxView = {
        let outputView = CheckboxView()

        outputView.translatesAutoresizingMaskIntoConstraints = false
        outputView.backgroundColor = .white
        return outputView
    }()

    private let disposeBag = DisposeBag()
    private var reusableDisposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("ListItemCell: init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        reusableDisposeBag = DisposeBag()
    }
}

extension ListItemCell {

    private func setup() {
        selectionStyle = .none

        setupLayout()
        bindUI()
    }

    private func bindUI() {
        // Изменяем изображение в иконке вместе с изменением чекбокса
        checkBoxView
            .isChecked
            .map { $0 ? Constants.checkedImage : Constants.uncheckedImage }
            .bind(to: iconImageView.rx.image)
            .disposed(by: disposeBag)
    }

    private func setupLayout() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkBoxView)

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSideLength),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSideLength),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: Constants.verticalBorderSpacing),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Constants.horizontalBorderSpacing),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: iconImageView.bottomAnchor,
                                                constant: Constants.verticalBorderSpacing),

            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor,
                                                constant: Constants.itemSpacing),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor,
                                                constant: Constants.verticalBorderSpacing),

            checkBoxView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                               constant: Constants.itemSpacing),
            checkBoxView.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: checkBoxView.trailingAnchor,
                                                  constant: Constants.horizontalBorderSpacing),
            checkBoxView.widthAnchor.constraint(equalToConstant: Constants.checkboxViewSideLength),
            checkBoxView.heightAnchor.constraint(equalToConstant: Constants.checkboxViewSideLength),

        ])
    }
}

extension ListItemCell: CellProtocol {

    func setup(with cellModel: CellModelProtocol) {
        guard let cellModel = cellModel as? ListItemCellModel else { return }

        titleLabel.text = cellModel.title
        checkBoxView.isChecked.accept(cellModel.isChecked)
        checkBoxView.isChecked.bind(to: cellModel.isCheckedChanged).disposed(by: reusableDisposeBag)
    }
}
