//
//  EmojiTextView.swift
//  22222222
//
//  Created by xiudou on 2016/11/24.
//  Copyright © 2016年 xiudo. All rights reserved.
//

import UIKit

class EmojiTextView: UITextView {
    // MARK:- 对外接口
    
    /**
     判断添加的表情情况(空白,删除,emoji,普通表情)
     */
    func insertEmoji(emoji : Emoji){
        // 1 空白
        if emoji.isEmpty{
            return
        }
        // 2 删除
        if emoji.isRemove{
            
            deleteBackward()
            return
        }
        // 3 emoji表情
        if emoji.emojiCode != nil{
            
            guard let textRange = selectedTextRange else { return }
            
            replaceRange(textRange, withText: emoji.emojiCode!)
            return
        }
        // 4 处理普通表情
        setupNormalEmoji(emoji)
        
        
    }
    
    
    /**
     处理发送的带普通图片文本
     */
    func sendText()->String{
        // 1 创建可变属性字符串
        let textMattributedText = NSMutableAttributedString(attributedString: attributedText)
        // 2 获取文本范围
        let range = NSMakeRange(0, textMattributedText.length)
        // 3 遍历
        textMattributedText.enumerateAttributesInRange(range, options: [], usingBlock: { (dict, range, _) -> Void in
            // 4 判断是否有普通图片
            if dict["NSAttachment"] != nil{
                // 5 获取普通图片属性
                guard let attachment = dict["NSAttachment"] as? EmojiTextAttachment else { return }
                // 6 取出图片属性对应的汉字chs
                textMattributedText.replaceCharactersInRange(range, withString: attachment.chs)
                
            }
        })
        // 7 返回普通字符串
        return textMattributedText.string
    }
    
}

// MARK:- 私有方法
extension EmojiTextView {
    
    /**
     处理普通表情
     */
    private func setupNormalEmoji(emoji : Emoji){
        // 0 创建NSTextAttachment
        let attachment = EmojiTextAttachment()
        // 1 保存chs
        attachment.chs = emoji.chs ?? ""
        // 2 设计image属性
        attachment.image = UIImage(contentsOfFile: emoji.pngPath ?? "")
        // 3 获取文本字体
        if self.font == nil{
            self.font = UIFont.systemFontOfSize(16)
        }
        let font = self.font
        // 4 设置图片显示的尺寸
        attachment.bounds = CGRect(x: 0, y: -4, width: font!.lineHeight, height: font!.lineHeight)
        // 5 创建普通图片属性字符串
        let attributedImageString = NSAttributedString(attachment: attachment)
        // 6 获取textView可变属性字符串
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedText)
        // 7 获取光标位置
        let range = selectedRange
        // 8 光标位置插入普通图片属性字符串
        mutableAttributedString.replaceCharactersInRange(range, withAttributedString: attributedImageString)
        // 9 赋值,显示属性字符串
        attributedText = mutableAttributedString
        // 10 重置font(必须重置,不然显示大小有问题)
        self.font = font
        // 11 设置光标位置(必须设置光标位置,不然选择emoji和普通图片后光标显示位置不对)
        selectedRange = NSMakeRange(range.location + 1 , 0)
    }

}
