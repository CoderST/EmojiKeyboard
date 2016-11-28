//
//  ToolBarCell.swift
//  22222222
//
//  Created by xiudou on 2016/11/23.
//  Copyright © 2016年 xiudo. All rights reserved.
//

import UIKit
private let titleFontSize : CGFloat = 14
private let topMargin : CGFloat = 5
private let lineViewWidth : CGFloat = 1
class ToolBarCell: UICollectionViewCell {
    
    private lazy var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGrayColor()
        return lineView
    }()
    
    private lazy var titleLabel : UILabel = {
       
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.redColor()
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.systemFontOfSize(titleFontSize)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lineView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title : String?{
        
        didSet{
            
            guard let title = title else { return }
            titleLabel.text = title
            
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.size.width
        let height = bounds.size.height
        titleLabel.frame = bounds
        
        lineView.frame = CGRect(x: width + lineViewWidth, y: topMargin, width: lineViewWidth, height: height - 2 * topMargin)
    }
}
