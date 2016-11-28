//
//  Emoji.swift
//  22222222
//
//  Created by xiudou on 2016/11/23.
//  Copyright © 2016年 xiudo. All rights reserved.
//  一个emoji属性

import UIKit

class Emoji: NSObject {

    var code : String?{   // 0x1f603
        didSet{
            guard let code = code else { return }
            let scanner = NSScanner(string: code)
            var value : UInt32 = 0
            if scanner.scanHexInt(&value){
                // 将获取的value转为字符
                let char = Character(UnicodeScalar(value))
                emojiCode = String(char)
            }
            
            
        }
    }
    var png : String?{   // d_zuiyou.png
        
        didSet{
            guard let png = png else { return }
            pngPath = NSBundle.mainBundle().bundlePath + "/Emoticons.bundle/" + png
        }
    }
    var chs : String?  // [最右]
    
    // MARK:- 数据处理
    var pngPath : String?
    var emojiCode : String?
    var isRemove : Bool = false
    var isEmpty : Bool = false
    
    override init() {
        
    }
    // MARK:- 构造函数
    init(dic : [String : String]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    init(isRemove : Bool) {
        self.isRemove = isRemove
    }
    
    init(isEmpty : Bool) {
        self.isEmpty = isEmpty
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    // MARK:- 打印
    override var description : String {
        return dictionaryWithValuesForKeys(["emojiCode", "png", "chs"]).description
    }
}
