//
//  EmojiViewControllerCell.swift
//  22222222
//
//  Created by xiudou on 2016/11/23.
//  Copyright © 2016年 xiudo. All rights reserved.
//

import UIKit
let emojiItemNotificationCenter = "emojiItemNotificationCenter"
private let emojiItemCellIdentifier = "emojiItemCellIdentifier"
class EmojiViewControllerCell: UICollectionViewCell {
    
    // MARK:- 懒加载
    // 可以显示文字,可以显示图片
//    private lazy var emojiButton : UIButton = {
//        
//        let button = UIButton()
//        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
//        button.userInteractionEnabled = false
//        button.titleLabel?.font = UIFont.systemFontOfSize(32)
//        return button
//        
//    }()
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: EmoticonCollectionViewCellLayout())
        collectionView.backgroundColor = UIColor(red: 246/256.0, green: 246/256.0, blue: 246/256.0, alpha: 1.0)
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.registerClass(EmojiItemCell.self, forCellWithReuseIdentifier: emojiItemCellIdentifier)
        return collectionView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(collectionView)
    }
    
    var groups : [Emoji]?{
        didSet{
            guard let _ = groups else { return }
            collectionView.reloadData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension EmojiViewControllerCell : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return groups?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(emojiItemCellIdentifier, forIndexPath: indexPath) as! EmojiItemCell
        cell.emoji = groups![indexPath.item]
        return cell;
    }

}

// MARK:- UICollectionViewDelegate
extension EmojiViewControllerCell : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let emoji = groups![indexPath.item]
        
        NSNotificationCenter.defaultCenter().postNotificationName(emojiItemNotificationCenter, object: emoji)
        
    }
}

class EmoticonCollectionViewCellLayout : UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        // 1.计算itemWH
        //
                let itemWH = UIScreen.mainScreen().bounds.width / CGFloat(columnsNumber)
        
                // 2.设置layout的属性
                itemSize = CGSize(width: itemWH, height: itemWH)
                minimumInteritemSpacing = 0
                minimumLineSpacing = 0
                // 3.设置collectionView的属性
                collectionView?.pagingEnabled = true
                collectionView?.showsHorizontalScrollIndicator = false
                collectionView?.showsVerticalScrollIndicator = false
                let insetMargin = (collectionView!.bounds.height - 3 * itemWH) / 2
                if PHONE_5 == false{
        
                    collectionView?.contentInset = UIEdgeInsets(top: insetMargin, left: 0, bottom: insetMargin, right: 0)
                }
    }
}


