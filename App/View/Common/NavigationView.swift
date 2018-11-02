//
//  NavigationView.swift
//  JetFri
//
//  Created by Quan Nguyen Dinh on 6/11/18.
//  Copyright © 2018 UpPlus. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class NavigationView: UIView {
    var backClicked: (() -> ())?
    var isShowBackBt = true {
        didSet {
            if isShowBackBt == false {
                 backItem.isHidden = true
            }
        }
    }
    lazy var backItem: UIImageView = {
        let imgv = UIImageView()
        imgv.image = #imageLiteral(resourceName: "i_back").withRenderingMode(.alwaysTemplate)
        imgv.tintColor = .gray
        imgv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTap)))
        imgv.isUserInteractionEnabled = true
        return imgv
    }()
    
    var naviTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "REVIEW"
        label.textColor = .black
//        label.font = FDefined.fontBoldLato(size: 17)
        return label
    }()
    
    convenience init(isShowBack: Bool) {
        self.init(frame: .zero)
        isShowBackBt = isShowBack
        initSubViews()
        initLayouts()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubViews()
        initLayouts()
    }
    
    func initSubViews() {
        self.addSubview(backItem)
        self.addSubview(naviTitleLabel)
        self.backgroundColor = .white
    }
    
    func initLayouts() {
        backItem.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(12.5)
            make.width.height.equalTo(30)
        }
        
        naviTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        if !isShowBackBt {
            backItem.isHidden = true
        }
    }
    
    @objc func backTap() {
        if let backBlog = self.backClicked {
            backBlog()
        }
    }
    
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
