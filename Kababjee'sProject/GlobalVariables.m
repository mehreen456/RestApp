//
//  GlobalVariables.m
//  Kababjee'sApp
//
//  Created by Amerald on 02/07/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "GlobalVariables.h"

NSString *CID = @" ";
NSString *CTitle = @" ";
NSString *TPrice = @" ";
NSMutableArray * ItemsOrder= nil;
NSUInteger btp=0;
int *BasketItems=0;

@implementation GlobalVariables


+(UIButton*) BarButton
{
    
    UIButton *basket = [UIButton buttonWithType:UIButtonTypeSystem];
    basket.backgroundColor = [UIColor clearColor];
    [basket setImage:[UIImage imageNamed:@"basket"] forState:UIControlStateNormal];
    [basket setTitle:[@"   Rs " stringByAppendingString:TPrice] forState:UIControlStateNormal];
    basket.titleLabel.font=[UIFont systemFontOfSize:16];
    [basket.titleLabel sizeToFit];
    basket.tintColor = [UIColor whiteColor];
    [basket setTranslatesAutoresizingMaskIntoConstraints:YES];
    basket.autoresizesSubviews = YES;
    basket.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    
    return basket;

}
//
+ (CGFloat)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGFloat result = font.pointSize+4;
    if (text) {
        CGSize size;
        
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, 300)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height+1);
        result = MAX(size.height, result); 
    }
    return result;
}

@end
