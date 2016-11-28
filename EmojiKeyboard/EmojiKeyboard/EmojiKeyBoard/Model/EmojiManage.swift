//
//  EmojiManage.swift
//  22222222
//
//  Created by xiudou on 2016/11/23.
//  Copyright © 2016年 xiudo. All rights reserved.
//  管理类(管理"com.apple.emoji","com.sina.default","com.sina.lxh"文件)

import UIKit

class EmojiManage {

    var emojiPakes : [EmojiPack] = [EmojiPack]()
    
    init(){
        emojiPakes.append(EmojiPack(fileName: "com.apple.emoji"))
        emojiPakes.append(EmojiPack(fileName: "com.sina.default"))
        emojiPakes.append(EmojiPack(fileName: "com.sina.lxh"))
    }
    
//    var fileNames : [String]?{
//        didSet{
//            guard let fileNames = fileNames else { return }
//            if fileNames.count > 0{
//                for name in fileNames{
//                    emojiPakes.append(EmojiPack(fileName: name))
//                }
//            }
//        }
//    }
}
