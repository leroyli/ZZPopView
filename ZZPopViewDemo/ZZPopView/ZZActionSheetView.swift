//
//  ZZActionSheetView.swift
//  ZZSwiftDemo
//
//  Created by artios on 2017/10/26.
//  Copyright © 2017年 artios. All rights reserved.
//

import UIKit
import SnapKit


public typealias ActionSheetCompletionHandler = ((ZZActionSheetView , Int)->Void)?

public class ZZActionSheetView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    private var windowView: UIWindow? = (UIApplication.shared.delegate?.window)!
    private var tipLabel       : UILabel?
    private var title          : String?
    private var cancleBtn      : UIButton?
    private var bgView         : UIView?
    public  var touchWildToHide : Bool?
    private var actionTitles : Array! = [String]()
    private var completionHandler:ActionSheetCompletionHandler?
    private var tableView      : UITableView?
    private var cellIdentifier : String = "cell"
    private var rowHeight      : Int = 50
    private var tipLabelHeight : Int = 30
    private var cancleBtnHeight: Int = 50
    
    init(title:String = "tips", buttonTitlesArray:[String] = ["confirm"], handler:ActionSheetCompletionHandler?) {
        super.init(frame: CGRect.init())
        
        self.title = title
        self.completionHandler = handler
        self.actionTitles = buttonTitlesArray
        
        setupActionSheetSubViews()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupActionSheetSubViews
    private func setupActionSheetSubViews() {
        self.bgView = UIView.init(frame: CGRect.init())
        self.bgView?.alpha = 0.3
        self.bgView?.backgroundColor = .white
        self.windowView?.addSubview(self.bgView!)
        self.bgView?.snp.makeConstraints { (make) in
            make.edges.equalTo(self.windowView!)
        }
        
        
        
        var height = rowHeight * self.actionTitles.count + tipLabelHeight + cancleBtnHeight + 30
        
        if self.actionTitles.count >= 3 {
            
            height = rowHeight * 3 + tipLabelHeight + cancleBtnHeight + 30
        }
        
        
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapAction(sender:)))
        self.bgView?.addGestureRecognizer(tap)
        
        self.tipLabel = UILabel.init(frame: CGRect.init())
        self.tipLabel?.textAlignment = .center
        self.tipLabel?.text = self.title
        self.tipLabel?.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(self.tipLabel!)
        self.tipLabel?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.snp.top).offset(10)
            make.height.equalTo(tipLabelHeight)
        })
        
        let lineView = UIView.init(frame: CGRect.init())
        lineView.backgroundColor = UIColor.lightGray
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo((self.tipLabel?.snp.bottom)!).offset(10)
            make.height.equalTo(0.5)
        }
        
        var tableviewHeight = rowHeight * self.actionTitles.count
        
        if self.actionTitles.count >= 3 {
            
            tableviewHeight = rowHeight * 3
        }
        
        self.tableView = UITableView.init(frame: CGRect.init(), style: .plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.backgroundColor = UIColor.white
        self.addSubview(self.tableView!)
        self.tableView?.tableFooterView = UIView()
        self.tableView?.showsVerticalScrollIndicator = false
        self.tableView?.showsHorizontalScrollIndicator = false
        self.tableView?.separatorInset = UIEdgeInsets.init()
        self.tableView?.layoutMargins = UIEdgeInsets.init()
        if #available(iOS 9.0, *) {
            self.tableView?.cellLayoutMarginsFollowReadableWidth = false
        } else {
            // Fallback on earlier versions
        }
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(lineView.snp.bottom)
            make.height.equalTo(tableviewHeight)
        })
        
        let btnUpLineView = UIView.init(frame: CGRect.init())
        btnUpLineView.backgroundColor = UIColor.lightGray
        self.addSubview(btnUpLineView)
        
        let btnDownLineView = UIView.init(frame: CGRect.init())
        btnDownLineView.backgroundColor = UIColor.lightGray
        self.addSubview(btnDownLineView)
        
        self.cancleBtn = UIButton.init(type: .custom)
        self.cancleBtn?.setTitle("cancle", for: .normal)
        self.cancleBtn?.backgroundColor = .white
        self.cancleBtn?.setTitleColor(UIColor.black, for: .normal)
        self.cancleBtn?.addTarget(self, action: #selector(self.cancleAction(sender:)), for: .touchUpInside)
        self.addSubview(self.cancleBtn!)
        
        self.cancleBtn?.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(cancleBtnHeight)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
        
        btnUpLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(0.3)
            make.bottom.equalTo((self.cancleBtn?.snp.top)!)
        }
        
        btnDownLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(0.3)
            make.bottom.equalTo(self.snp.bottom)
        }
        
    }
    
    //MARK: - actionSheetShow
    public func show() {
        
        var height = rowHeight * self.actionTitles.count + tipLabelHeight + cancleBtnHeight + 30
        
        if self.actionTitles.count >= 3 {
            
            height = rowHeight * 3 + tipLabelHeight + cancleBtnHeight + 30
        }
        
        self.windowView?.addSubview(self)
        self.backgroundColor = .white
        self.layer.cornerRadius = 0.0
        self.layer.masksToBounds = true
        
        self.snp.makeConstraints { (make) in
            make.top.equalTo((self.windowView?.snp.bottom)!)
            make.height.equalTo(height)
            make.left.right.equalTo(self.windowView!)
        }
        
        self.alpha = 1
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            
            self.snp.updateConstraints({ (make) in
                make.top.equalTo((self.windowView?.snp.bottom)!).offset(-height)
            })
            
        }) { (animat) in
            
        }
        
    }
    
    //MARK: - actionSheetHide
    private func hide() {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.snp.updateConstraints({ (make) in
                make.top.equalTo((self.windowView?.snp.bottom)!)
            })
            
            self.layoutIfNeeded()
            
        }) { (animat) in
            
            self.removeFromSuperview()
            self.bgView?.removeFromSuperview()
        }
        
    }
    
    //MARK: - cancleAction
    @objc private func cancleAction(sender:UIButton) {
        
        if self.completionHandler != nil {
            self.completionHandler!!(self,sender.tag)
        }
        
        hide()
        
    }
    
    //MARK: - tapAction
    @objc private func tapAction(sender:UITapGestureRecognizer) {
        if self.touchWildToHide == true {
            hide()
        } else {
            return
        }
    }
    
    
    //MARK: - tableView
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.actionTitles.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(rowHeight)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.text = self.actionTitles[indexPath.row]
        
        cell?.separatorInset = UIEdgeInsets.init()
        cell?.layoutMargins = UIEdgeInsets.init()
        cell?.preservesSuperviewLayoutMargins = false
        
        return cell!
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.completionHandler!!(self,indexPath.row+1)
        
        hide()
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
