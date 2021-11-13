//
//  CircularProgressView.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit

class CircularProgressView: UIView {

    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    fileprivate var progressTextLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }

    var progressWitdh: CGFloat = 8.0 {
        didSet {
            trackLayer.lineWidth = progressWitdh
            progressLayer.lineWidth = progressWitdh
        }
    }

    var progressTextColor = UIColor.white {
        didSet {
            progressTextLabel.textColor = progressTextColor
        }
    }

    var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
            progressTextLabel.textColor = progressColor
        }
    }

    fileprivate func createCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width / 2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - 1.5) / 2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        createTrackLayer(circlePath: circlePath)
        createProgressLayer(circlePath: circlePath)
        createCircularText()
    }

    fileprivate func createTrackLayer(circlePath: UIBezierPath) {
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.systemGray6.cgColor
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
    }

    fileprivate func createProgressLayer(circlePath: UIBezierPath) {
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.strokeEnd = 0.0
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)
    }

    fileprivate func createCircularText() {
        progressTextLabel.font = progressTextLabel.font.withSize(frame.size.width / 3)
        progressTextLabel.frame = CGRect(x: (frame.size.width / 2) - progressTextLabel.font.pointSize, y: (frame.size.height / 2) - progressTextLabel.font.pointSize, width: progressTextLabel.font.pointSize * 2, height: progressTextLabel.font.pointSize * 2)
        progressTextLabel.textAlignment = .center
        layer.addSublayer(progressTextLabel.layer)
    }

    func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressTextLabel.text = String(value * 10).maxLength(length: 3)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateprogress")
    }

    func getRatingColor(value: Float) -> UIColor {
        switch value * 100 {
        case 0..<15:
            return UIColor.ratingColors.highRed
        case 15..<30:
            return UIColor.ratingColors.middleRed
        case 30..<40:
            return UIColor.ratingColors.lowRed
        case 40..<50:
            return UIColor.ratingColors.highYellow
        case 50..<60:
            return UIColor.ratingColors.middleYellow
        case 60..<70:
            return UIColor.ratingColors.lowYellow
        case 70..<80:
            return UIColor.ratingColors.lowGreen
        case 80..<90:
            return UIColor.ratingColors.middleGreen
        case 90..<100:
            return UIColor.ratingColors.highGreen
        default:
            return .black
        }
    }

}
