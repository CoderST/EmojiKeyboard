//
//  EmojiRegular.swift
//  EmojiNSRegularExpression
//
//  Created by xiudou on 2016/11/24.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class EmojiRegular: NSObject {

    private lazy var emojiManage : EmojiManage = EmojiManage()
    
    func attributedTextWithText(text : String, font : UIFont)->NSMutableAttributedString?{
        let mutableAttributedString = NSMutableAttributedString(string: text)
        // 1 定义表情正则
        let pattern = "\\[.*?\\]"
        // 2 创建查找
        guard let regularExpression = try? NSRegularExpression(pattern: pattern, options: []) else { return nil }
        // 3 获得查找结果
        let textCheckingResults = regularExpression.matchesInString(text, options: [], range: NSMakeRange(0, text.characters.count))
        // 4 如果结果为0 结束后续操作
        if textCheckingResults.count == 0 {
            
            return nil
        }
        
        // 5 遍历所有查找到的结果
        for result in textCheckingResults{
            // 5.1 获取对应的字符如:[哈哈]
            let chs = (text as NSString).substringWithRange(result.range)
            // 5.2 更具字符到本地搜索对应的图片路径
            guard let pngPath = matchEmojiPngPath(chs) else { return nil}
            // 6 创建图文混排
            let attachment = EmojiTextAttachment()
            // 6.1 记录值
            attachment.chs = chs
            // 6.2 更具图片路径创建UIImage
            attachment.image = UIImage(contentsOfFile: pngPath)
            // 6.3 设置图片尺寸
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            // 6.4 转为属性字符串
            let imageString = NSAttributedString(attachment: attachment)
            // 7 把[哈哈]替换成对应的属性字符串UIImage
            mutableAttributedString.replaceCharactersInRange(result.range, withAttributedString: imageString)
            return mutableAttributedString
        }
        
        return nil
    }
    
    
}

extension EmojiRegular {
    /**
     更具字符[哈哈]查找对应的图片路径
     */
    private func matchEmojiPngPath(chs : String)->String?{
        
        for emojiPack in emojiManage.emojiPakes{
            
            for emoji in emojiPack.emojiArray{
                
                if emoji.chs == chs{
                    
                    return emoji.pngPath ?? ""
                }
                
            }
        }
        return nil
    }

}
