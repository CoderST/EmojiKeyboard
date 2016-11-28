//
//  ToolBarCollectionView.swift
//  22222222
//
//  Created by xiudou on 2016/11/23.
//  Copyright © 2016年 xiudo. All rights reserved.
//

import UIKit
protocol ToolBarViewDelegate : class{
    
    func didSelectedTitle(title : String, index : Int)
}
// MARK:- 常量
private let toolBarViewIdentifier = "collectionViewIdentifier"
let WINDOW_WIDTH = UIScreen.mainScreen().bounds.size.width
let WINDOW_HEIGHT = UIScreen.mainScreen().bounds.size.height
class ToolBarView: UIView {
    
    weak var delegate : ToolBarViewDelegate?
    
    // MARK:- 懒加载
    private lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.scrollEnabled = false
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(ToolBarCell.self, forCellWithReuseIdentifier: toolBarViewIdentifier)
        return collectionView
    }()
    
    private lazy var titleArray : [String] = [String]()

    var titles : [String]?{
        
        didSet{
            guard let titles = titles else { return }
            for title in titles{
                titleArray.append(title)
            }
            
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        if titleArray.count > 0{
            
            let width = WINDOW_WIDTH / CGFloat(titleArray.count)
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CGSize(width: width, height: bounds.size.height)
        }
    }
}

// MARK:- UICollectionViewDataSource
extension ToolBarView : UICollectionViewDataSource {
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return titleArray.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(toolBarViewIdentifier, forIndexPath: indexPath) as! ToolBarCell
        collectionViewCell.title = titleArray[indexPath.item]
        return collectionViewCell
    }

}

extension ToolBarView : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        let title = titleArray[indexPath.item]
        delegate?.didSelectedTitle(title, index: indexPath.item)
        
    }
}

