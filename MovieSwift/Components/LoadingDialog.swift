//
//  LoadingDialog.swift
//  MovieSwift
//
//  Created by Canberk Bibican on 16.10.2021.
//

import UIKit
import Lottie

class LoadingDialog: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    lazy var dialogView: UIView = {
        var dialog = UIView()
        return dialog
    }()

    lazy var animation: AnimationView = {
        var animationView = AnimationView(name: "loading-anim")
        return animationView
    }()
    
    func setupView() {
        self.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
        self.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        self.setupDialogView()
        self.setupAnimation()
    }
    
    func playAnimation(){
        animation.play()
    }
    
    func stopAnimation(){
        animation.stop()
    }
}

extension LoadingDialog {
    func setupDialogView(){
        self.addSubview(dialogView)
        dialogView.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
        dialogView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.left.equalTo(self.snp.left).offset(0)
        }
    }
    
    func setupAnimation() {
        dialogView.addSubview(animation)
        animation.loopMode = .loop
        animation.play()
        animation.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(100)
            make.center.equalTo(dialogView)
        }
    }
}
