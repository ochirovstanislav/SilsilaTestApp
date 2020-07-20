//
//  CheckboxView.swift
//  TestApp
//
//  Created by stanislav on 19.07.2020.
//  Copyright © 2020 Ochirov Stanislav. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct CheckboxViewConfiguration {

    var borderWidth: CGFloat = 1.0
    var checkedColor: UIColor = .blue
}

final class CheckboxView: UIControl {

    let isChecked = BehaviorRelay<Bool>(value: false)

    private var feedbackGenerator = UIImpactFeedbackGenerator.init(style: .light) // Необходим для выбрации при нажатии
    private let increasedTouchRadius: CGFloat = 10 // Радиус увеличения области нажатия на кнопку
    private let configuration: CheckboxViewConfiguration
    private let disposeBag = DisposeBag()

    init(frame: CGRect = .zero, configuration: CheckboxViewConfiguration = .init()) {
        self.configuration = configuration

        super.init(frame: frame)

        // Вызываем setNeedsDisplay() при изменении isChecked для перерисовки view (draw(_ rect: CGRect))
        isChecked.subscribe(onNext: { [weak self] (_) in
            self?.setNeedsDisplay()
        }).disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("CheckboxView: init(coder:) has not been implemented")
    }

    // Отрисовываем края нашего чекбокса
    override func draw(_ rect: CGRect) {
        let newRectInset = configuration.borderWidth / 2
        let newRect = rect.insetBy(dx: newRectInset,
                                   dy: newRectInset)

        let context = UIGraphicsGetCurrentContext()!

        context.setStrokeColor(isChecked.value ? configuration.checkedColor.cgColor : tintColor.cgColor)
        context.setLineWidth(configuration.borderWidth)

        let shapePath = UIBezierPath.init(ovalIn: newRect)

        context.addPath(shapePath.cgPath)
        context.strokePath()
        context.fillPath()

        if isChecked.value {
            drawCheckMark(frame: newRect)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setNeedsDisplay()
    }

    // Подготавливаем feedbackGenerator к вызову вибрации по нажатию на кнопку
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        feedbackGenerator.prepare()
    }

    // Отпуская кнопку, меняем значение isChecked и посылаем вибрацию
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        isChecked.accept(!isChecked.value)
        sendActions(for: .valueChanged)
        self.feedbackGenerator.impactOccurred()
    }

    // Увеличиваем область нажатия на кнопку
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let relativeFrame = self.bounds
        let hitTestEdgeInsets = UIEdgeInsets(top: -increasedTouchRadius,
                                             left: -increasedTouchRadius,
                                             bottom: -increasedTouchRadius,
                                             right: -increasedTouchRadius)
        let hitFrame = relativeFrame.inset(by: hitTestEdgeInsets)

        return hitFrame.contains(point)
    }
}

// MARK: - Private

extension CheckboxView {

    private func drawCheckMark(frame: CGRect) {
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: frame.minX + 0.26000 * frame.width, y: frame.minY + 0.50000 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.42000 * frame.width, y: frame.minY + 0.62000 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.38000 * frame.width, y: frame.minY + 0.60000 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.42000 * frame.width, y: frame.minY + 0.62000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.70000 * frame.width, y: frame.minY + 0.24000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.78000 * frame.width, y: frame.minY + 0.30000 * frame.height))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.44000 * frame.width, y: frame.minY + 0.76000 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.20000 * frame.width, y: frame.minY + 0.58000 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.44000 * frame.width, y: frame.minY + 0.76000 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.26000 * frame.width, y: frame.minY + 0.62000 * frame.height))
        configuration.checkedColor.setFill()
        bezierPath.fill()
    }
}
