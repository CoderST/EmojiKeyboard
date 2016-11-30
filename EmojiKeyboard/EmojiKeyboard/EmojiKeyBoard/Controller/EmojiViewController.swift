//
//  EmojiViewController.swift
//  22222222
//
//  Created by xiudou on 2016/11/23.
//  Copyright © 2016年 xiudo. All rights reserved.
//

import UIKit

/**
 *  @request 必须实现
 */
protocol emojiViewControllerDelegate : class{
    /**
     toolBar 标题名称数组
     */
    func toolBarTitles()->[String]
    
}

// MARK:- 常量
private let emojiViewControllerIdentifier = "collectionViewIdentifier"
let PHONE_5 = CGSizeEqualToSize(CGSizeMake(320, 568), UIScreen.mainScreen().bounds.size)
/// 列数
let columnsNumber : NSInteger = 7
/// toolBar高度
let toolBarHeight : CGFloat = PHONE_5 ? 48.5 : 49

class EmojiViewController: UIViewController {
    
    // MARK:- 变量
    weak var delegate : emojiViewControllerDelegate?
    /// 定义block
    var emojiCallBack  : (emoji : Emoji) ->()
    
//    var titles : [String] = [String]()
    
    // MARK:- 懒加载
    private lazy var toolBar : ToolBarView = {
        let toolBar  = ToolBarView()
        toolBar.delegate = self
        return toolBar
    }()
    
    // 初始化UICollectionView
    private lazy var collectionView : UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: EmoticonCollectionViewLayout())
        collectionView.backgroundColor = UIColor(red: 246/256.0, green: 246/256.0, blue: 246/256.0, alpha: 1.0)
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.registerClass(EmojiViewControllerCell.self, forCellWithReuseIdentifier: emojiViewControllerIdentifier)
        return collectionView
        
    }()
    
    private lazy var emojiManage : EmojiManage = EmojiManage()
    
    // MARK:- 构造函数
    init(emojiCallBack : (emoji : Emoji) ->()){
        self.emojiCallBack = emojiCallBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        let titles = delegate?.toolBarTitles()
        if titles?.count == 0{
            return
        }
        
        
        setupUI()
        
        toolBar.titles = titles
        
        
        // 监听通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didselectedEmojiItemClick:", name: emojiItemNotificationCenter, object: nil)
        
    }
    
    func didselectedEmojiItemClick(infor : NSNotification){
        guard let emoji = infor.object as?  Emoji else { return }
        emojiCallBack(emoji: emoji)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}

// MARK:- UI布局
extension EmojiViewController {
    private func setupUI(){
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        toolBar.backgroundColor = UIColor.darkGrayColor()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["toolBar" : toolBar, "collectionView" : collectionView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[toolBar]-0-|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionView]-0-[toolBar(\(toolBarHeight))]-0-|", options: [.AlignAllLeft, .AlignAllRight], metrics: nil, views: views)
        view.addConstraints(constraints)
    }
}

// MARK:- UICollectionViewDataSource
extension EmojiViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        
        return emojiManage.emojiPakes.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        /*
        if groups == nil { return 0 }
        print("pppppppp",groups?.count)
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum

        */
        
        let emojiPake = emojiManage.emojiPakes[section]
        let pageNumber = (emojiPake.emojiArray.count - 1) / 21 + 1
        print("pageNumber = \(pageNumber)")
        return pageNumber
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(emojiViewControllerIdentifier, forIndexPath: indexPath) as! EmojiViewControllerCell
//        collectionViewCell.emoji = emojiManage.emojiPakes[indexPath.section].emojiArray[indexPath.item]
        collectionViewCell.backgroundColor = UIColor.redColor()
        setupCell(collectionViewCell, indexPath: indexPath)
        return collectionViewCell
    }
    
    
    func setupCell(cell : EmojiViewControllerCell,indexPath : NSIndexPath){
        // 1  0 ~ 20
        // 2  21 ~ 41
        // 3  42 ~ 62
        // 取出对应的页面数据的个数传递给cell中的collectionView
        let emojiPake = emojiManage.emojiPakes[indexPath.section]
        print("emojiPake.emojiArray = \(emojiPake.emojiArray.count)")
            let startItem = indexPath.item * 21
            var endItem = (indexPath.item + 1) * 21 - 1
            // 处理越界问题
            if endItem > emojiPake.emojiArray.count - 1{
                endItem = emojiPake.emojiArray.count - 1
            }
            let tempGroup = Array(emojiPake.emojiArray[startItem ... endItem])
            cell.groups = tempGroup
        }
    }

// MARK:- ToolBarViewDelegate
extension EmojiViewController : ToolBarViewDelegate {
    func didSelectedTitle(title: String, index: Int) {
        
        let indexPath = NSIndexPath(forRow: 0, inSection: index)
        
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: true)
    }
    
}


class EmoticonCollectionViewLayout : UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        // 1.计算itemWH
//        
//        let itemWH = UIScreen.mainScreen().bounds.width / CGFloat(columnsNumber)
//        
//        // 2.设置layout的属性
//        itemSize = CGSize(width: itemWH, height: itemWH)
//        minimumInteritemSpacing = 0
//        minimumLineSpacing = 0
//        scrollDirection = .Horizontal
//        // 3.设置collectionView的属性
//        collectionView?.pagingEnabled = true
//        collectionView?.showsHorizontalScrollIndicator = false
//        collectionView?.showsVerticalScrollIndicator = false
//        let insetMargin = (collectionView!.bounds.height - 3 * itemWH) / 2
//        if PHONE_5 == false{
//            
//            collectionView?.contentInset = UIEdgeInsets(top: insetMargin, left: 0, bottom: insetMargin, right: 0)
//        }
        
        itemSize = collectionView!.bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Horizontal
        // 3.设置collectionView的属性
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
    }
}

