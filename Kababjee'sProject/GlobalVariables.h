//
//  GlobalVariables.h
//  Kababjee'sApp
//
//  Created by Amerald on 02/07/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "CategoriesViewController.h"
#import "SWRevealViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ItemDescriptionViewController.h"
#import "BasketViewController.h"
#import "DejalActivityView.h"
#import "MenuItemsViewController.h"
#import "UIView+Toast.h"


extern NSString *CID,*CTitle,*TPrice;
extern int *BasketItems;
extern  NSUInteger btp;
extern NSMutableArray *ItemsOrder;

@interface GlobalVariables : NSObject

+(UIButton *) BarButton;
+ (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;
//
@end
