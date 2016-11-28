//
//  ViewController.swift
//  EmojiKeyboard
//
//  Created by xiudou on 2016/11/28.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK:- 懒加载
    private lazy var emojiViewController : EmojiViewController = EmojiViewController {[weak self] (emoji) -> () in
        
        self?.textView.insertEmoji(emoji)
        
        
    }
    private lazy var textView : EmojiTextView = {[weak self] in
        
        let textView = EmojiTextView()
        textView.font = UIFont.systemFontOfSize(16)
        textView.frame = self!.view.bounds
        textView.alwaysBounceVertical = true
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        return textView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 添加textview
        view.addSubview(textView)
        // 2 设置代理
        emojiViewController.delegate = self
        // 3 设置自己的键盘
        textView.inputView = emojiViewController.view
    }


}
extension ViewController : emojiViewControllerDelegate{
    
    func toolBarTitles() -> [String] {
        
        return ["哈哈","呵呵","嘻嘻11"]
    }

}
