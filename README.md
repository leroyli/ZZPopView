# ZZPopView
A PopView that include alert and actionSheet

![img](https://github.com/leroyli/ZZPopView/blob/master/ZZPopViewDemo/ZZPopViewDemo/screenShot/popview0.png)

![img](https://github.com/leroyli/ZZPopView/blob/master/ZZPopViewDemo/ZZPopViewDemo/screenShot/popview1.png)

![img](https://github.com/leroyli/ZZPopView/blob/master/ZZPopViewDemo/ZZPopViewDemo/screenShot/popview2.png)

## useExample
```
        // alert
        let alertView = ZZAlertView.init(title: "tips", message: "are you sure to buy this item ?") { (alert, index) in
            print("you click ZZAlert index",index)
        }
        alertView.show()
        
        
        // actionSheet
        let actionSheetView = ZZActionSheetView.init(title: "please select an item", buttonTitlesArray: ["itme1","itme2","itme3"]) { (actionSheet, index) in
            print("you click ZZActionSheet index",index)
        }
        actionSheetView.touchWildToHide = true
        actionSheetView.show()
```
