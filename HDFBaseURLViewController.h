//
//  HDFBaseURLViewController.h
//  newPatient
//
//  Created by Dawn on 14/11/21.
//  Copyright (c) 2014年 haodf.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HDFBaseURLViewControllerDelegate;
/// 实现的功能是：用户点击此页面可以改变 HDFNetworkManager 的 baseURLString，如果必要，可以清除用户信息
@interface HDFBaseURLViewController : UIViewController

@property (weak) id <HDFBaseURLViewControllerDelegate> delegate;

@end


// MARK:HDFBaseURLViewControllerDelegate
@protocol HDFBaseURLViewControllerDelegate <NSObject>

- (void)HDFBaseURLViewControllerDidSelectURL;

@end