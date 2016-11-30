//
//  EmojiPack.swift
//  22222222
//
//  Created by xiudou on 2016/11/23.
//  Copyright © 2016年 xiudo. All rights reserved.
//  每一个文件夹全部的emoji

import UIKit

class EmojiPack: NSObject {
    
    lazy var emojiArray : [Emoji] = [Emoji]()
    private let pageTotleCount = 3 * columnsNumber
    init(fileName : String) {
        super.init()
        // 1 获取完整路径
        guard let packPath = NSBundle.mainBundle().pathForResource("\(fileName)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle") else { return }
        // 2 通过路径加载数据
        guard let dicArray = NSArray(contentsOfFile: packPath) as? [[String : String]] else { return }
        // 3 数组转模型
        var index = 0
        
        for var dict in dicArray{
            
            // 给png属性重新复制(添加文件夹名称)
            if let png = dict["png"] {
                dict["png"] = fileName + "/" + png
            }
            
            emojiArray.append(Emoji(dic: dict))
            
            // 4 判断是否满足一页 不满足添加空  一页最后一个item为删除按钮
            index++
            if index == (pageTotleCount - 1){
                index = 0
                // 5 第21位添加删除按钮
                emojiArray.append(Emoji(isRemove: true))
            }
            
            
        }
        // 6 处理空白按钮
        let count = emojiArray.count % pageTotleCount
        if count == 0 {
            return
        }
        
        for _ in count..<(pageTotleCount - 1){
            // 7 添加占位空emoji
            emojiArray.append(Emoji(isEmpty: true))
        }
        
        // 8 在添加占位空emoji最后添加一个删除按钮
        emojiArray.append(Emoji(isRemove: true))
    }
}
