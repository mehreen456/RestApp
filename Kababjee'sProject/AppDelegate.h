//
//  AppDelegate.h
//  Kababjee'sProject
//
//  Created by Amerald on 09/08/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "MyTableViewCell.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *CID;
@property(nonatomic,retain) NSString * CTitle;
@property(nonatomic,retain) NSMutableArray * ItemsOrder;

@end
