//
//  EmojiItemCell.swift
//  EmojiKeyboard
//
//  Created by xiudou on 2016/11/30.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class EmojiItemCell: UICollectionViewCell {
    private lazy var emojiButton : UIButton = {
        
        let button = UIButton()
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.userInteractionEnabled = false
        button.titleLabel?.font = UIFont.systemFontOfSize(32)
        return button
        
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(emojiButton)
    }

    var emoji : Emoji?{
        
        didSet{
            
            guard let emoji = emoji else { return }
            emojiButton.setImage(UIImage(contentsOfFile: emoji.pngPath ?? ""), forState: .Normal)
            emojiButton.setTitle(emoji.emojiCode ?? "", forState: .Normal)
            
            if emoji.isRemove{
                emojiButton.setImage(UIImage(named: "compose_emotion_delete"), forState: .Normal)
            }
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        emojiButton.frame = contentView.bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
