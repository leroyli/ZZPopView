//
//  ZZAlertView.swift
//  ZZSwiftDemo
//
//  Created by artios on 2017/10/26.
//  Copyright © 2017年 artios. All rights reserved.
//

import UIKit
import SnapKit


public typealias AlertCompletionHandler = ((ZZAlertView , Int) -> Void)?

public class ZZAlertView: UIView {
    
    private var windowView : UIWindow? = (UIApplication.shared.delegate?.window)!
    private var tipLabel       : UILabel?
    private var messageLabel   : UILabel?
    private var seportLineView : UIView?
    private var title          : String?
    private var message        : String?
    private var confirmBtn     : UIButton?
    private var cancleBtn      : UIButton?
    private var downLineView   : UIView?
    private var buttonView     : UIView?
    private var bgView         : UIVisualEffectView?
    public  var touchWildToHide: Bool?
    private var completionHandler:AlertCompletionHandler?
    
    
    init(title:String = "title", message:String = " ", handler:AlertCompletionHandler?) {
        super.init(frame: CGRect.init())
        
        self.title = title
        self.message = message
        
        self.completionHandler = handler
        
        setupAlertSubViews()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupAlertSubViews
    private func setupAlertSubViews() {
        
        self.bgView = UIVisualEffectView.init()
        self.bgView?.backgroundColor = .clear
        self.bgView?.effect = UIBlurEffect(style: .light)
        self.windowView?.addSubview(self.bgView!)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tapAction(sender:)))
        self.bgView?.addGestureRecognizer(tap)
        
        var lastAttribute = self.snp.top
        
        if self.title != nil {
            self.tipLabel = UILabel.init(frame: CGRect.init())
            self.tipLabel?.text = self.title
            self.tipLabel?.font = UIFont.systemFont(ofSize: 20)
            self.tipLabel?.textAlignment = .center
            self.addSubview(self.tipLabel!)
            
            self.tipLabel?.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(10)
                make.right.equalTo(self.snp.right).offset(-10)
                make.top.equalTo(lastAttribute).offset(10)
            })
            
            lastAttribute = (self.tipLabel?.snp.bottom)!
        }
        
        if self.message != nil {
            self.messageLabel = UILabel.init(frame: CGRect.init())
            self.messageLabel?.numberOfLines = 0
            self.messageLabel?.text = self.message
            self.messageLabel?.font = UIFont.systemFont(ofSize: 15)
            self.messageLabel?.textAlignment = .center
            self.addSubview(self.messageLabel!)
            
            self.messageLabel?.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(10)
                make.right.equalTo(self.snp.right).offset(-10)
                make.top.equalTo(lastAttribute).offset(10)
            })
            
            lastAttribute = (self.messageLabel?.snp.bottom)!
        }
        
        
        self.downLineView = UIView.init(frame: CGRect.init())
        self.downLineView?.backgroundColor = UIColor.lightGray
        self.addSubview(self.downLineView!)
        
        self.downLineView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(0.5)
            make.top.equalTo(lastAttribute).offset(20)
        })
        
        self.buttonView = UIView.init(frame: CGRect.init())
        self.buttonView?.backgroundColor = .white
        self.addSubview(self.buttonView!)
        
        self.buttonView?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self)
            make.top.equalTo((self.downLineView?.snp.bottom)!)
            make.height.equalTo(40)
        })
        
        self.confirmBtn = UIButton.init(type: .custom)
        self.confirmBtn?.tag = 1
        self.confirmBtn?.setTitle("confirm", for: .normal)
        self.confirmBtn?.backgroundColor = .white
        self.confirmBtn?.setTitleColor(.black, for: .normal)
        self.confirmBtn?.addTarget(self, action: #selector(self.confirmAction(sender:)), for: .touchUpInside)
        self.buttonView?.addSubview(self.confirmBtn!)
        
        self.confirmBtn?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.buttonView!)
            make.bottom.equalTo((self.buttonView?.snp.bottom)!).offset(-5)
            make.left.equalTo((self.buttonView?.snp.centerX)!).offset(0.25)
            make.top.equalTo(self.buttonView!)
        })
        
        self.cancleBtn = UIButton.init(type: .custom)
        self.cancleBtn?.tag = 0
        self.cancleBtn?.setTitle("cancle", for: .normal)
        self.cancleBtn?.backgroundColor = .white
        self.cancleBtn?.setTitleColor(.black, for: .normal)
        self.cancleBtn?.addTarget(self, action: #selector(self.cancleAction(sender:)), for: .touchUpInside)
        self.buttonView?.addSubview(self.cancleBtn!)
        
        self.cancleBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.buttonView!)
            make.bottom.equalTo((self.buttonView?.snp.bottom)!).offset(-5)
            make.right.equalTo((self.buttonView?.snp.centerX)!).offset(-0.25)
            make.top.equalTo(self.buttonView!)
        })
        
        self.seportLineView = UIView.init(frame: CGRect.init())
        self.seportLineView?.backgroundColor = UIColor.lightGray
        self.buttonView?.addSubview(self.seportLineView!)
        
        self.seportLineView?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.buttonView!)
            make.bottom.equalTo(self.buttonView!)
            make.width.equalTo(0.5)
            make.centerX.equalTo((self.buttonView?.snp.centerX)!)
        })
        
        self.snp.makeConstraints { (make) in
            make.bottom.equalTo((self.buttonView?.snp.bottom)!)
        }
        
    }
    
    //MARK: - alertShow
    public func show() {
        
        for item in (self.windowView?.subviews)! {
            if item.isKind(of: ZZAlertView.self) {
                return
            }
        }
        
        self.bgView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.windowView!)
        })
        
        self.windowView?.addSubview(self)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        
        self.snp.makeConstraints { (make) in
            make.width.equalTo(260)
            make.center.equalTo(self.windowView!.snp.center)
        }
        
        
        self.layoutIfNeeded()
        
        self.alpha = 0
        self.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.0)
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            
            self.alpha = 1
            self.layer.transform = CATransform3DIdentity
            
        }) { (animat) in
            
            
        }
    }
    
    //MARK: - alertHide
    private func hide() {
        UIView.animate(withDuration: 0.2, animations: {
            
            self.alpha = 0
            
        }) { (animat) in
            
            self.removeFromSuperview()
            self.bgView?.removeFromSuperview()
            
        }
        
    }
    
    //MARK: - confirmAction
    @objc private func confirmAction(sender:UIButton) {
        
        if self.completionHandler != nil {
            self.completionHandler!!(self,sender.tag)
        }
        
        hide()
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
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
