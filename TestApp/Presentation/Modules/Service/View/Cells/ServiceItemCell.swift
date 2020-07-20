//
//  ServiceItemCell.swift
//  TestApp
//
//  Created by stanislav on 20.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ServiceItemCell: UITableViewCell {

    private struct Constants {
        static let verticalBoundsSpacing: CGFloat = 16.0
        static let horizontalBoundsSpacing: CGFloat = 16.0
        static let itemSpacing: CGFloat = 8
    }

    private lazy var titleLabel: UILabel = generateLabel(with: .systemFont(ofSize: 17.0, weight: .bold))
    private lazy var artistLabel: UILabel = generateLabel(with: .systemFont(ofSize: 17.0, weight: .medium))
    private lazy var countryLabel: UILabel = generateLabel(with: .systemFont(ofSize: 10.0, weight: .regular))
    private lazy var companyLabel: UILabel = generateLabel(with: .systemFont(ofSize: 10.0, weight: .regular))
    private lazy var priceLabel: UILabel = generateLabel(with: .systemFont(ofSize: 10.0, weight: .regular))
    private lazy var yearLabel: UILabel = generateLabel(with: .systemFont(ofSize: 10.0, weight: .regular))

    private func generateLabel(with font: UIFont) -> UILabel {
        let outputLabel = UILabel()

        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.font = font
        return outputLabel
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("ListItemCell: init(coder:) has not been implemented")
    }
}

// MARK: - Private
extension ServiceItemCell {

    private func setup() {
        setupLayout()
    }

    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(countryLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(companyLabel)
        contentView.addSubview(yearLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: Constants.horizontalBoundsSpacing),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Constants.itemSpacing),
            contentView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                                  constant: Constants.horizontalBoundsSpacing),

            artistLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                             constant: Constants.itemSpacing),

            countryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            countryLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor,
                                             constant: Constants.itemSpacing),

            companyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            companyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            companyLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor,
                                             constant: Constants.itemSpacing),

            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor,
                                             constant: Constants.itemSpacing),

            yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            yearLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            yearLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,
                                             constant: Constants.itemSpacing),
            contentView.bottomAnchor.constraint(equalTo: yearLabel.bottomAnchor,
                                                constant: Constants.itemSpacing)
        ])
    }
}

// MARK: - CellProtocol
extension ServiceItemCell: CellProtocol {

    func setup(with cellModel: CellModelProtocol) {
        guard let cellModel = cellModel as? ServiceItemCellModel else { return }

        titleLabel.text = cellModel.title
        artistLabel.text = cellModel.artist
        countryLabel.text = cellModel.country
        priceLabel.text = cellModel.price
        companyLabel.text = cellModel.title
        yearLabel.text = cellModel.year
    }
}
