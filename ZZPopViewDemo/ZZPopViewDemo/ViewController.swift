//
//  ViewController.swift
//  ZZPopViewDemo
//
//  Created by artios on 2017/10/26.
//  Copyright © 2017年 artios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.init(red: 200.0/255, green: 200.0/255, blue: 200.0/255, alpha: 1.0)
        configSubViews()
    }
    
    func configSubViews () {
        let alertBtn = configButton(frame: CGRect.init(x: 100, y: 100, width: 200, height: 50), title: "show alert")
        alertBtn.addTarget(self, action: #selector(alertButtonClick(sender:)), for: .touchUpInside)
        self.view.addSubview(alertBtn)
        
        
        let actionSheetBtn = configButton(frame: CGRect.init(x: 100, y: 220, width: 200, height: 50), title: "show actionSheet")
        actionSheetBtn.addTarget(self, action: #selector(actionSheetButtonClick(sender:)), for: .touchUpInside)
        self.view.addSubview(actionSheetBtn)
        
    }
    
    @objc func alertButtonClick(sender:UIButton) {
        
        let alertView = ZZAlertView.init(title: "tips", message: "are you sure to buy this item ?") { (alert, index) in
            print("you click ZZAlert index",index)
        }
        alertView.show()
        
    }
    
    @objc func actionSheetButtonClick(sender:UIButton) {
        
        let actionSheetView = ZZActionSheetView.init(title: "please select an item", buttonTitlesArray: ["itme1","itme2","itme3"]) { (actionSheet, index) in
            print("you click ZZActionSheet index",index)
        }
        actionSheetView.touchWildToHide = true
        actionSheetView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configButton(frame:CGRect,title:String) -> (UIButton) {
        let button = UIButton.init(type: .custom)
        button.frame = frame
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .red
        button.setTitle(title, for: .normal)
        return button
    }
    

}

